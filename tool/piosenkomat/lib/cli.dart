import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import 'classify.dart';
import 'gmail.dart';
import 'hrcpsng.dart';
import 'mailbox.dart';
import 'model.dart';
import 'people.dart';
import 'plan.dart';
import 'report.dart';
import 'reply.dart';
import 'review.dart';
import 'run_dir.dart';
import 'similarity.dart';

/// Skąd komenda bierze skrzynkę. Domyślnie prawdziwy Gmail z `--credentials`
/// i `--token`; testy podstawiają własną.
typedef MailboxConnector = Future<Mailbox> Function(ArgResults args);

/// [root]: katalog z `out/` i `archive/` — domyślnie katalog narzędzia.
Future<int> runPiosenkomat(List<String> args, {MailboxConnector? connect, String root = '.'}) async {
  final runner = _Runner(connect ?? _connectGmail, root);
  if (args.isEmpty) {
    stdout.writeln(runner.usage);
    return 64;
  }
  // Po polsku, bo na to trafia się najczęściej.
  if (!args.first.startsWith('-') && !runner.commands.containsKey(args.first)) {
    stderr.writeln('Nie ma komendy „${args.first}”.');
    stdout.writeln(runner.usage);
    return 64;
  }
  try {
    return await runner.run(args) ?? 0;
  } on UsageException catch (e) {
    stderr
      ..writeln(e.message)
      ..writeln(e.usage);
    return 64;
  } on FileSystemException catch (e) {
    stderr.writeln('${e.message}: ${e.path}');
    return 1;
  }
}

class _Runner extends CommandRunner<int> {
  _Runner(MailboxConnector connect, String root)
      : super('./piosenkomat', 'piosenkomat: sitko mejli z piosenkami na $kInboxEmail.') {
    for (final command in [
      _ScanCommand(connect, root),
      _ReviewCommand(connect, root),
      _FinalizeCommand(connect, root),
      _ReplyCommand(connect, root),
      _StatusCommand(connect, root),
      _ReopenCommand(connect, root),
      _UnlabelCommand(connect, root),
      _ExplainCommand(connect, root),
    ]) {
      addCommand(command);
    }
  }

  @override
  String get usageFooter => '\nPrzebieg jest jeden naraz: scan --push → przegląd na stronie → '
      'review --push → wklejenie final-* do all_songs → finalize --push.\n'
      'Odpowiedzi do autorów czekają w szkicach: reply --push, kiedy chcesz.\n'
      'Bez --push nic w Gmailu się nie zmienia. Flagi komendy: ./piosenkomat <komenda> --help';
}

Future<Mailbox> _connectGmail(ArgResults args) => GmailMailbox.connect(
      credentialsFile: File(args['credentials'] as String? ?? defaultCredentialsPath()),
      tokenFile: File(args['token'] as String? ?? defaultTokenPath()),
    );

/// Wspólne dla komend: opcje, przebieg, dry-run.
abstract class _PiosenkomatCommand extends Command<int> {
  _PiosenkomatCommand(this.connectMailbox, this.root);

  final MailboxConnector connectMailbox;
  /// Katalog z `out/` i `archive/`.
  final String root;

  ArgResults get args => argResults!;

  /// Ile argumentów pozycyjnych przyjmuje komenda; `null` — dowolnie wiele.
  /// Zbędny argument to błąd, nie cicha „cała kolejka”.
  int? get maxRest => 0;

  @override
  Future<int> run() async {
    final max = maxRest;
    if (max != null && args.rest.length > max) {
      usageException('Nieoczekiwany argument: ${args.rest.skip(max).join(' ')}');
    }
    return execute();
  }

  Future<int> execute();

  Future<Mailbox> connect() => connectMailbox(args);

  /// Jedyny przebieg — `out/run/`.
  RunDir get runDir => RunDir.current(root: root);

  /// Mejle otwartego przebiegu: z `out/run/` — jego plan; bez — wszystko
  /// z `song/*` w wątkach z otwartym werdyktem w Gmailu (przebieg otwarty
  /// gdzie indziej). Pusty = nic nie jest otwarte.
  Set<String> _openRunMessages(Mailbox mailbox, Map<String, Set<String>> current) {
    if (runDir.exists) return runDir.readRunPlan().labelsByMessage.keys.toSet();
    String threadOf(String id) => mailbox.knownThreadOf(id) ?? id;
    final open = {for (final id in openVerdicts(current)) threadOf(id)};
    return {for (final id in current.keys) if (open.contains(threadOf(id))) id};
  }

  bool get push => args['push'] as bool;
  bool get force => args['force'] as bool;

  /// Tylko komendy, które łączą się z Gmailem.
  void addGmailOptions() => argParser
    ..addOption('credentials', help: 'Domyślnie secrets/credentials.json')
    ..addOption('token', help: 'Domyślnie secrets/gmail_token.json');

  /// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
  /// „wypchnij to, co widzisz na sucho, do skrzynki”.
  void addPushFlag(String help) => argParser.addFlag('push', negatable: false, help: help);

  void addForceFlag(String help) => argParser.addFlag('force', negatable: false, help: help);

  /// Tylko komendy, które porównują ze śpiewnikiem.
  void addSongsDbOption() => argParser.addOption('songs-db', help: 'Ścieżka do all_songs.hrcpsng');

  /// Bez `--push` komenda kończy na liście: mówi, co zrobiłoby `--push`.
  /// `true` = to był dry-run, dalej nie idziemy.
  bool dryRun(String whatPushDoes) {
    if (push) return false;
    stdout.writeln('\nDry-run: nic nie zmieniono. --push $whatPushDoes.');
    return true;
  }

  /// `-n`: liczba dodatnia albo brak.
  int? limit() {
    final raw = args['limit'] as String?;
    if (raw == null) return null;
    final limit = int.tryParse(raw);
    if (limit == null || limit <= 0) usageException('--limit wymaga liczby dodatniej.');
    return limit;
  }

  SongBook loadSongBook() {
    final path = args['songs-db'] as String? ?? defaultSongsDbPath();
    final book = loadBook(path);
    stdout.writeln('Śpiewnik: $path (${plural(book.songs.length, 'tytuł', 'tytuły', 'tytułów')})');
    return book;
  }

  /// Plan przebiegu, który jest już w Gmailu — na nim pracują `review`
  /// i `finalize`. `null` = nie ma takiego (powód już wypisany).
  RunPlan? pushedRun() {
    if (!runDir.exists) {
      stderr.writeln('Nie ma otwartego przebiegu (${runDir.path}). Zacznij od: ./piosenkomat scan --push');
      return null;
    }
    final plan = runDir.readRunPlan();
    if (plan.pushedAt == null) {
      stderr.writeln(_interrupted(plan));
      return null;
    }
    return plan;
  }
}

// ---------------------------------------------------------------------------
// scan
// ---------------------------------------------------------------------------

class _ScanCommand extends _PiosenkomatCommand {
  _ScanCommand(super.connectMailbox, super.root) {
    argParser
      ..addOption('limit',
          abbr: 'n', help: 'Ile zgłoszeń (wątków) z kolejki, każde w całości (domyślnie wszystkie)')
      ..addFlag('newest', negatable: false, help: 'Najnowsze N zamiast najstarszych')
      ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');
    addSongsDbOption();
    addGmailOptions();
    addPushFlag('Nadaj etykiety, załóż szkice i out/run/ (bez tej flagi tylko raport)');
  }

  @override
  final name = 'scan';
  @override
  final description = 'Przesiew kolejki (inbox bez song/*, po wątkach) — raport. Z --push '
      'otwiera przebieg: etykiety w Gmailu, szkice z blokiem o starej apce i katalog out/run/ '
      'z plikami do przeglądu na stronie. Rusza tylko, gdy żaden przebieg nie jest otwarty.';

  @override
  Future<int> execute() async {
    final run = runDir;
    if (run.exists) {
      final plan = run.readRunPlan();
      if (plan.pushedAt != null) {
        stderr.writeln('STOP. Otwarty przebieg ${plan.id} — najpierw go domknij. '
            'Co czeka: ./piosenkomat status');
        return 1;
      }
      if (!push) {
        stderr.writeln(_interrupted(plan));
        return 1;
      }
      stdout.writeln('Dokańczam przerwany scan --push przebiegu ${plan.id}.');
      final mailbox = await connect();
      return _push(mailbox, run, plan, await mailbox.songLabelsByMessage());
    }

    final limit = this.limit();
    final book = loadSongBook();
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    // Przebieg otwarty gdzie indziej — inny komputer albo skasowany katalog.
    // Gmail to jedyny wspólny stan, więc to on rozstrzyga.
    final open = openVerdicts(current);
    if (open.isNotEmpty) {
      stderr.writeln('STOP. ${_openElsewhere(open.length)}');
      return 1;
    }

    final messages = await _fetchQueue(mailbox, current, limit: limit);
    if (messages.isEmpty) {
      stdout.writeln('Nic do przesiania.');
      return 0;
    }
    // Nasze wysłane z tych wątków: kto dostał już odpowiedź i — do rozmowy
    // w edytorze — co mu napisaliśmy. W kolejce ich nie ma (leżą w `SENT`),
    // a bez nich po `reopen` widać odpowiedź autora bez pytania.
    final sentByThread = await mailbox.sentIdsByThread();
    final threads = {for (final m in messages) m.threadId};
    final weRepliedThreads = {
      for (final t in threads) if (sentByThread.containsKey(t)) t,
      ...await _oldAppAuthorsWeRepliedTo(mailbox, messages),
    };
    final ours = await mailbox.getMessages([
      for (final t in threads) ...?sentByThread[t],
    ]);

    final id = newRunId(DateTime.now());
    final classified = classifyBatch([...messages, ...ours],
        book: book, weRepliedThreads: weRepliedThreads, run: id);
    final report = formatRunReport(classified);
    stdout
      ..writeln()
      ..write(report);
    if (dryRun('otworzy przebieg: etykiety, szkice z blokiem o starej apce i ${run.path}')) return 0;

    assignUniqueIds([for (final c in classified) if (c.goesToFile) c.song!]);
    final plan = RunPlan.fromClassified(classified, id: id);
    _writeRun(run, plan, classified, report);
    return _push(mailbox, run, plan, current);
  }

  /// Kolejka do przesiania: wątki bez `song/*`, każdy w całości, [limit]
  /// najstarszych (z `--newest` najnowszych), bez zgłoszeń ze strony i mejli
  /// nie o piosence. Po drodze mówi, co odsiała.
  Future<List<ContribMessage>> _fetchQueue(
    Mailbox mailbox,
    Map<String, Set<String>> current, {
    int? limit,
  }) async {
    final newest = args['newest'] as bool;
    final query = args['query'] as String? ?? kQueueQuery;
    // Cała lista, bo `-n` liczy wątki, a wiadomości jednego wątku bywają
    // rozrzucone po kolejce. Samo listowanie jest tanie — treści nie ciągnie.
    final queueIds = [
      for (final id in await mailbox.listIds(query))
        (id: id, threadId: mailbox.knownThreadOf(id) ?? id),
    ];
    // Odpowiedzi w wątkach z `song/*` odsiewamy przed pobieraniem treści —
    // i przed `-n`, żeby limit liczył prawdziwe zgłoszenia.
    final labeledThreads = {for (final id in current.keys) mailbox.knownThreadOf(id) ?? id};
    final alive = unlabeledQueue(queueIds, labeledThreads);
    final ids = takeThreads(alive, limit, newest: newest);
    final picked = ids.toSet();
    final threadCount = {
      for (final m in alive) if (picked.contains(m.id)) m.threadId,
    }.length;
    final scope = limit == null
        ? 'cała kolejka'
        : '${newest ? 'najnowsze' : 'najstarsze'} '
            '${plural(limit, 'wątek', 'wątki', 'wątków')}';
    final inTagged = queueIds.length - alive.length;
    if (inTagged > 0) {
      stdout.writeln('Pominięto ${plural(inTagged, 'mejl', 'mejle', 'mejli')} w wątkach, '
          'które mają już etykietę song/* — to odpowiedzi po zgłoszeniu, nie zgłoszenia.');
    }
    stdout.writeln('Kolejka ($scope): ${plural(ids.length, 'mejl', 'mejle', 'mejli')} '
        'w ${plural(threadCount, 'wątku', 'wątkach', 'wątkach')}, pobieram…');
    final fetched = await mailbox.getMessages(ids, onProgress: (done, total) {
      if (done % 50 == 0 || done == total) stdout.writeln('  $done/$total');
    });
    final unreadable = fetched.where((m) => m.readError != null).length;
    if (unreadable > 0) {
      stdout.writeln('${plural(unreadable, 'mejl', 'mejle', 'mejli')} nie do rozebrania — '
          'pójdą jako „nie do odczytania”.');
    }
    final queue = partitionQueue(fetched);
    if (queue.web > 0) {
      stdout.writeln('Odsiano ${plural(queue.web, 'zgłoszenie', 'zgłoszenia', 'zgłoszeń')} '
          'ze strony — piosenkomat obsługuje wyłącznie zgłoszenia wysłane z apki. '
          'Te ogarnij ręcznie.');
    }
    final skipped = fetched.length - queue.songs.length - queue.web;
    if (skipped > 0) {
      stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')} '
          '(już otagowane albo nie o piosence), zostają bez zmian.');
    }
    return queue.songs;
  }
}

/// Wątki autorów ze starej apki, którym już coś wysłaliśmy — w którymkolwiek
/// wątku. Blok „zaktualizuj apkę” wystarczy dostać raz. Pytamy o nadawcę:
/// jedno tanie zapytanie na autora ze starej apki.
Future<Set<String>> _oldAppAuthorsWeRepliedTo(
  Mailbox mailbox,
  List<ContribMessage> messages,
) async {
  final oldAppSenders = {
    for (final m in messages)
      if (m.hasOldAppRegion)
        if (emailFromHeader(m.from) case final sender?) sender,
  };
  final weRepliedSenders = {
    for (final sender in oldAppSenders)
      if ((await mailbox.listIds('in:sent to:$sender', limit: 1, newest: true)).isNotEmpty)
        sender,
  };
  return {
    for (final m in messages)
      if (weRepliedSenders.contains(emailFromHeader(m.from))) m.threadId,
  };
}

/// Katalog przebiegu: raport, plan i po dwa pliki na rodzaj — kandydaci
/// i puste miejsce na eksport po przeglądzie. Składany obok i przemianowany
/// na `out/run/` na końcu: wywrotka w połowie nie zostawia połowy przebiegu.
void _writeRun(RunDir run, RunPlan plan, List<Classified> classified, String report) {
  final staging = run.staging;
  if (staging.exists) Directory(staging.path).deleteSync(recursive: true);
  writeText(staging.report, report);
  writePlan(staging.plan, plan);
  // Dwa pliki, bo to dwie roboty: nowe dodajesz, poprawki porównujesz
  // z tym, co w apce. Uwagi jadą w piosenkach — edytor pokaże je nad każdą.
  for (final kind in SubmissionKind.values) {
    final items = [
      for (final c in classified)
        if (c.goesToFile && c.submission.kind == kind) c,
    ];
    if (items.isEmpty) continue;
    writeHrcpsng(staging.candidates(kind), [for (final c in items) c.song!], withPiosenkomatData: true);
    // Miejsce na eksport: pusty, nie kopia kandydatów — kopia wyglądałaby
    // jak przegląd, w którym wszystko weszło.
    staging.writeReviewedPlaceholder(kind);
    final clean = items.where((c) => c.issues.isEmpty).length;
    stdout.writeln('\n${_kindName(kind)}: ${plural(items.length, 'piosenka', 'piosenki', 'piosenek')} '
        '→ ${run.candidates(kind)} ($clean bez zarzutu, ${items.length - clean} z uwagami)');
  }
  Directory(staging.path).renameSync(run.path);
}

/// Druga połowa `scan --push`, którą da się powtórzyć: etykiety z planu
/// (mejle, które mają już `song/*`, zostają jak są), szkice z blokiem o starej
/// apce, znacznik „w Gmailu” w planie.
Future<int> _push(Mailbox mailbox, RunDir run, RunPlan plan, Map<String, Set<String>> current) async {
  final changes = {
    for (final e in plan.labelsByMessage.entries)
      if (!current.containsKey(e.key)) e.key: withReadOnClose((e.value, const [])),
  };
  await mailbox.ensureToolLabels();
  await _applyChanges(mailbox, changes);
  stdout.writeln('\nNadano:');
  countLines(stdout, tally(changes.values.expand((c) => c.$1)));
  final skipped = plan.labelsByMessage.length - changes.length;
  if (skipped > 0) {
    stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')}, '
        'które w międzyczasie dostały etykietę song/*.');
  }
  await syncDrafts(mailbox, _replyThreads(plan, _after(current, changes)), push: true);
  writePlan(run.plan, plan.pushed(DateTime.now()));

  stdout.writeln('\nPrzebieg ${plan.id} otwarty: ${run.path}');
  stdout.writeln(run.kinds.isEmpty
      ? 'Nic nie poszło do przeglądu — domknij od razu: ./piosenkomat finalize --push'
      : 'Wczytuj jeden plik naraz na stronie ze śpiewnikiem, eksport zapisz w reviewed-*.hrcpsng, '
          'potem: ./piosenkomat review --push');
  return 0;
}

// ---------------------------------------------------------------------------
// review
// ---------------------------------------------------------------------------

class _ReviewCommand extends _PiosenkomatCommand {
  _ReviewCommand(super.connectMailbox, super.root) {
    addForceFlag('Pomiń bezpieczniki (pusty eksport, odrzucona większość)');
    addGmailOptions();
    addPushFlag('Przestaw etykiety, zapisz final-* i people.dart, załóż szkice (bez tej flagi tylko lista)');
  }

  @override
  final name = 'review';
  @override
  final description = 'Po przeglądzie na stronie: piosenka w reviewed-* → „${SongLabel.readyToAdd.label}”, '
      'skasowana albo ze zgaszonym przełącznikiem → „${SongLabel.rejectedAfterReview.label}” '
      '(z odpowiedzią do autora — „${SongLabel.replyReviewNote.label}”). Składa final-*.hrcpsng '
      'do wklejenia w all_songs i people.dart, zakłada szkice z tekstem do autora. Wolno powtarzać. '
      'Z kandydatów można wywalać i edytować, nie dodawać: obca piosenka, zły rodzaj albo '
      'sprzeczne kopie → STOP.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final plan = pushedRun();
    if (plan == null) return 1;
    if (_stopOnMissingExports(run)) return 1;
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    if (!isRunInGmail(plan, current)) {
      stderr.writeln('Przebieg ${plan.id} nie ma etykiet w Gmailu (zdjęte ręcznie?). '
          'Cofnij go: ./piosenkomat unlabel --push');
      return 1;
    }
    final results = _review(run, plan, safety: !force);
    if (results == null) return 1;

    final labeling = reviewLabelChanges(results, plan, current);
    for (final thread in labeling.alreadyReplied) {
      stdout.writeln('  JUŻ ODPISANE  ${plan.songByThread[thread]?.title ?? ''}  [$thread] — '
          'tekst do autora już wysłany; zmianę wyślij ręcznie');
    }
    final changes = _applicable(labeling.changes, current);
    final skipped = labeling.changes.length - changes.length;
    if (skipped > 0) {
      stdout.writeln('Pomijam ${plural(skipped, 'mejl', 'mejle', 'mejli')} bez etykiet automatu '
          'albo już domknięte.');
    }
    stdout.writeln('Etykiety do przestawienia: ${plural(changes.length, 'mejl', 'mejle', 'mejli')}');

    // `final-*` i osoby z tego samego przeglądu, co etykiety.
    final otherEmails = otherEmailsBySender(plan);
    final sources = <ContributorSource>[];
    final finals = <SubmissionKind, String>{};
    for (final result in results) {
      final songs = result.acceptedSongs;
      // Przed zdjęciem śladu, bo `sender_is_contributor` siedzi w nim.
      sources.addAll(contributorSourcesOf(songs, otherEmailsBySender: otherEmails));
      final targets = stripPiosenkomat(songs);
      finals[result.kind] = encodeHrcpsng(songs);
      _printFinal(run, result, songs, targets);
    }

    final notes = {for (final r in results) ...r.reviewNotes};
    final threads = _replyThreads(plan, _after(current, changes), notes);
    if (!push) {
      await syncDrafts(mailbox, threads, push: false);
      dryRun('przestawi etykiety, zapisze final-* i people.dart i założy szkice');
      return 0;
    }

    for (final e in finals.entries) {
      writeText(run.finalSongs(e.key), e.value);
    }
    _writePeople(run, collectPeople(sources));
    await mailbox.ensureToolLabels();
    await _applyChanges(mailbox, changes);
    await syncDrafts(mailbox, threads, push: true);
    stdout.writeln('\nDalej: wklej final-*.hrcpsng do all_songs, potem ./piosenkomat finalize --push. '
        'Odpowiedzi do autorów: ./piosenkomat reply --push, kiedy przejrzysz szkice.');
    return 0;
  }
}

/// Przegląd każdego rodzaju: kandydaci kontra plik zwrotny, z wypisaniem.
/// Jedna droga dla `review` i `finalize`. `null` = STOP (już wypisany).
/// [safety]: bezpieczniki na zły plik (pusty eksport, odrzucona większość) —
/// `finalize` ich nie powtarza, bo przeszły, albo zostały świadomie pominięte,
/// w `review`.
List<ReviewResult>? _review(RunDir run, RunPlan plan, {required bool safety}) {
  final results = <ReviewResult>[];
  for (final kind in run.kinds) {
    final candidates = collectCandidates(plan, readHrcpsng(run.candidates(kind)), kind);
    if (candidates.isEmpty) continue;
    final reviewedPath = run.reviewed(kind);
    final reviewed = readHrcpsng(reviewedPath);
    stdout.writeln('${_kindName(kind)}: ${plural(candidates.length, 'kandydat', 'kandydaci', 'kandydatów')}, '
        '${reviewed.length} w $reviewedPath');
    final result = reviewDiff(kind: kind, candidates: candidates, reviewed: reviewed);
    _printReview(result);

    if (result.mustStop) {
      _printStop(result, kind);
      return null;
    }
    if (safety) {
      final error = reviewSafetyError(result,
          reviewedPath: reviewedPath,
          reviewedCount: reviewed.length,
          candidateCount: candidates.length);
      if (error != null) {
        stderr.writeln(error);
        return null;
      }
    }
    results.add(result);
  }
  return results;
}

/// `review` i `finalize` ruszają dopiero z kompletem eksportów: pusty albo
/// brakujący plik zwrotny to przegląd, którego jeszcze nie było, a nie
/// „wszystko weszło”. `true` = STOP, dalej nie idziemy.
bool _stopOnMissingExports(RunDir run) {
  final missing = run.missingExports;
  if (missing.isEmpty) return false;
  for (final path in missing) {
    stderr.writeln('  BRAK EKSPORTU  $path');
  }
  stderr.writeln('STOP. Zapisz tam eksport ze strony i odpal ponownie.');
  return true;
}

/// Co weszło, co wypadło, co rozpoznane inaczej niż po id wątku.
void _printReview(ReviewResult result) {
  stdout
    ..writeln('  WCHODZI    ${result.accepted.length}')
    ..writeln('  ODRZUCONE  ${result.rejected.length}');
  for (final c in result.removed) {
    stdout.writeln('    ODRZUĆ  ${c.title}  [${c.threadId}]');
  }
  for (final m in result.turnedDown) {
    final hasReviewNote = result.reviewNotes.containsKey(m.candidate.threadId);
    stdout.writeln('    ODRZUĆ  ${m.reviewed.title}  [${m.candidate.threadId}]'
        '  (przełącznik${hasReviewNote ? ', z odpowiedzią' : ''})');
  }
  final byOther = [
    for (final m in result.accepted)
      if (m.matchedBy != MatchedBy.threadId) m,
  ];
  if (byOther.isNotEmpty) {
    stdout.writeln('  Rozpoznane inaczej niż po id wątku '
        '(tytuł mógł się zmienić przy przeglądzie): ${byOther.length}');
    for (final m in byOther) {
      stdout.writeln('    ${m.matchedBy.text.padRight(12)} ${m.candidate.title}'
          '${m.reviewed.title == m.candidate.title ? '' : ' → ${m.reviewed.title}'}');
    }
  }
}

void _printStop(ReviewResult result, SubmissionKind kind) {
  for (final s in result.foreign) {
    stderr.writeln('  OBCA    ${s.title} — nie ma jej w kandydatach '
        '(z candidates można wywalać i edytować, nie dodawać)');
  }
  for (final s in result.wrongKind) {
    stderr.writeln('  ZŁY PLIK ${s.title} — to '
        '${s.piosenkomatData!.isCorrection ? 'poprawka' : 'nowa piosenka'}, '
        'a plik jest na ${_kindName(kind).toLowerCase()}');
  }
  for (final e in result.duplicateTargets.entries) {
    stderr.writeln('  DWIE POPRAWKI ${e.key}: ${e.value.join(' / ')} — '
        'podmienić można tylko jedną');
  }
  for (final e in result.conflicts.entries) {
    stderr.writeln('  SPRZECZNE KOPIE ${e.value} [${e.key}] — zostaw jedną albo wyrównaj');
  }
  stderr.writeln('STOP. Popraw eksport i odpal ponownie.');
}

void _printFinal(
  RunDir run,
  ReviewResult result,
  List<SongRaw> songs,
  List<({String id, String title, bool guessed})> targets,
) {
  stdout.writeln('${_kindName(result.kind)}: '
      '${plural(songs.length, 'piosenka', 'piosenki', 'piosenek')} → ${run.finalSongs(result.kind)}');
  if (result.turnedDown.isNotEmpty) {
    stdout.writeln('  pominięto ${result.turnedDown.length} z przełącznikiem „nie wchodzi”');
  }
  if (result.kind != SubmissionKind.correction) return;
  for (final t in targets) {
    stdout.writeln('  podmień ${t.id}  ←  ${t.title}'
        '${t.guessed ? '   (cel ZGADNIĘTY — sprawdź, zanim podmienisz)' : ''}');
  }
  final noTarget = songs.length - targets.length;
  if (noTarget > 0) {
    stdout.writeln('  $noTarget bez celu (no-target-in-app) — te dodasz jak nowe '
        'albo podmienisz ręcznie');
  }
}

void _writePeople(RunDir run, PeopleReport people) {
  writePeopleDart(run.people, people);
  stdout.writeln('Osoby dodające: ${people.newContributors.length} nowych → ${run.people}'
      '${people.knownByEmail.isEmpty ? '' : ', ${people.knownByEmail.length} już w data.dart'}'
      '${people.knownWithNewEmails.isEmpty ? '' : ', ${people.knownWithNewEmails.length} z nowym adresem do dopisania'}'
      '${people.ambiguous.isEmpty ? '' : ', ${people.ambiguous.length} do sprawdzenia (adresy z różnych wpisów)'}'
      '${people.anonymousByEmail.isEmpty ? '' : ', ${people.anonymousByEmail.length} bez karty osoby'}');
  if (people.senderNotContributorByEmail.isNotEmpty) {
    stdout.writeln('${people.senderNotContributorByEmail.length} zgłoszeń '
        'w cudzym imieniu — osobę dodającą przypisz ręcznie '
        '(adres nadawcy jest tylko do odpisania).');
  }
  if (people.newContributors.isNotEmpty) {
    stdout.writeln('Doklej nowe do lib/values/people/data.dart, '
        'zanim wkleisz piosenki do all_songs.');
  }
}

// ---------------------------------------------------------------------------
// finalize
// ---------------------------------------------------------------------------

class _FinalizeCommand extends _PiosenkomatCommand {
  _FinalizeCommand(super.connectMailbox, super.root) {
    addSongsDbOption();
    addForceFlag('Domknij mimo piosenek z final-*, których nie widać w all_songs');
    addGmailOptions();
    addPushFlag('Oznacz „${SongLabel.added.label}” i przenieś przebieg do archive/ '
        '(bez tej flagi tylko lista)');
  }

  @override
  final name = 'finalize';
  @override
  final description = 'Koniec przebiegu, po wklejeniu final-*.hrcpsng do all_songs: mejle '
      'z „${SongLabel.readyToAdd.label}” → „${SongLabel.added.label}” + przeczytane, a out/run/ → '
      'archive/<przebieg>/ z summary.md. Staje, gdy coś czeka na przegląd, przegląd jest '
      'nieaktualny albo piosenek z final-* nie ma w all_songs. Odpowiedzi do autorów czekają '
      'dalej w szkicach — nie blokują.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final plan = pushedRun();
    if (plan == null) return 1;
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();

    final waiting = _threadsWith(plan, current, SongLabel.needsReview);
    if (waiting.isNotEmpty) {
      stderr.writeln('STOP. Na przegląd czeka '
          '${plural(waiting.length, 'zgłoszenie', 'zgłoszenia', 'zgłoszeń')} '
          '(„${SongLabel.needsReview.label}”). Najpierw: ./piosenkomat review --push');
      return 1;
    }
    if (_stopOnMissingExports(run)) return 1;
    final results = _review(run, plan, safety: false);
    if (results == null) return 1;
    // Przegląd ma być aktualny: etykiety i `final-*` z tego eksportu, który
    // leży teraz w `reviewed-*` — inaczej domknęlibyśmy coś innego, niż weszło.
    if (_applicable(reviewLabelChanges(results, plan, current).changes, current).isNotEmpty) {
      stderr.writeln('STOP. Etykiety w Gmailu nie zgadzają się z eksportem — przegląd '
          'nieaktualny. Najpierw: ./piosenkomat review --push');
      return 1;
    }
    // Przed zdjęciem śladu piosenkomatu — cel poprawki siedzi w nim.
    final summary = formatRunSummary(
      plan: plan,
      results: results,
      repliesWaiting: [
        for (final thread in plan.messagesByThread.keys)
          if (_awaits(plan, current, thread, SongLabel.replyOldApp) ||
              _awaits(plan, current, thread, SongLabel.replyReviewNote))
            thread,
      ],
      finalizedAt: DateTime.now(),
    );
    final finals = <SongRaw>[];
    for (final result in results) {
      final songs = result.acceptedSongs;
      stripPiosenkomat(songs);
      final path = run.finalSongs(result.kind);
      final file = File(path);
      if (!file.existsSync() || file.readAsStringSync() != encodeHrcpsng(songs)) {
        stderr.writeln('STOP. $path nie jest z ostatniego przeglądu. Najpierw: ./piosenkomat review --push');
        return 1;
      }
      finals.addAll(songs);
    }

    final missing = _notInAllSongs(loadSongBook(), finals);
    for (final m in missing) {
      stderr.writeln('  NIE MA W ALL_SONGS  $m');
    }
    if (missing.isNotEmpty && !force) {
      stderr.writeln('STOP. Wklej final-*.hrcpsng do all_songs i odpal ponownie '
          '(--force, jeśli świadomie inaczej).');
      return 1;
    }

    stdout
      ..writeln()
      ..write(summary);
    final ready = [
      for (final id in plan.labelsByMessage.keys)
        if (hasToolLabel(current[id] ?? const {}, SongLabel.readyToAdd)) id,
    ];
    final archive = archivePath(plan.id, root: root);
    if (dryRun('oznaczy ${plural(ready.length, 'mejl', 'mejle', 'mejli')} jako „${SongLabel.added.label}”, '
        'zapisze to podsumowanie w summary.md i przeniesie przebieg do $archive')) {
      return 0;
    }

    await mailbox.ensureToolLabels();
    await _applyChanges(mailbox, {
      for (final id in ready)
        id: withReadOnClose(([SongLabel.added.label], [SongLabel.readyToAdd.label]), current: current[id]!),
    });
    writeText(run.summary, summary);
    Directory(p.dirname(archive)).createSync(recursive: true);
    Directory(run.path).renameSync(archive);
    stdout.writeln('Przebieg ${plan.id} domknięty → $archive. '
        'Można zaczynać kolejny: ./piosenkomat scan --push');
    return 0;
  }
}

/// Piosenki z `final-*`, których nie ma w śpiewniku w tej postaci: brak id
/// albo pod nim inna wersja. Poprawka ma już id poprawianej piosenki, więc
/// liczy się dopiero jej nowa treść.
List<String> _notInAllSongs(SongBook book, List<SongRaw> songs) => [
      for (final s in songs)
        if (book.matchTo(s.id, SongProfile(s)) case final m when m?.level != MatchLevel.identical)
          m == null ? '${s.id}  „${s.title}” — nie ma tego id' : '${s.id}  „${s.title}” — pod tym id inna wersja',
    ];

// ---------------------------------------------------------------------------
// reply / status
// ---------------------------------------------------------------------------

class _ReplyCommand extends _PiosenkomatCommand {
  _ReplyCommand(super.connectMailbox, super.root) {
    argParser.addOption('limit', abbr: 'n', help: 'Najwyżej tyle mejli w tym odpaleniu');
    addGmailOptions();
    addPushFlag('Wyślij (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reply';
  @override
  final description = 'Odpowiedzi do autorów: wysyła szkice z kolejki '
      '(„${SongLabel.replyOldApp.label}”, „${SongLabel.replyReviewNote.label}”) — z Twoimi '
      'poprawkami z Gmaila. Jedna kolejka dla wszystkich przebiegów; przebiegu nie blokuje. '
      'Szkic sprzed przeglądu albo pisany ręcznie zostaje — narzędzie mówi, co z nim zrobić.';

  @override
  Future<int> execute() async {
    final limit = this.limit();
    final mailbox = await connect();
    await sendReplies(mailbox, push: push, limit: limit);
    dryRun('wyśle powyższe');
    return 0;
  }
}

class _StatusCommand extends _PiosenkomatCommand {
  _StatusCommand(super.connectMailbox, super.root) {
    addGmailOptions();
  }

  @override
  final name = 'status';
  @override
  final description = 'Co jest otwarte i jaki jest następny krok — według Gmaila, '
      'z katalogiem out/run/ jako podpowiedzią.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final plan = run.exists ? run.readRunPlan() : null;
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final open = openVerdicts(current);

    if (plan == null) {
      stdout.writeln(open.isEmpty
          ? 'Żaden przebieg nie jest otwarty. Dalej: ./piosenkomat scan --push'
          : _openElsewhere(open.length));
    } else {
      stdout.writeln('Przebieg ${plan.id} (${run.path}), zeskanowany ${formatMinute(plan.createdAt)}.');
      if (plan.pushedAt == null) {
        stdout.writeln(_interrupted(plan));
      } else {
        final needsReview = _threadsWith(plan, current, SongLabel.needsReview).length;
        stdout
          ..writeln('  na przegląd czeka  $needsReview')
          ..writeln('  przyjęte           ${_threadsWith(plan, current, SongLabel.readyToAdd).length}');
        final outside = open.where((id) => !plan.labelsByMessage.containsKey(id)).length;
        if (outside > 0) {
          stdout.writeln('  UWAGA: ${plural(outside, 'mejl', 'mejle', 'mejli')} z otwartym werdyktem '
              'spoza tego przebiegu (inny komputer?)');
        }
        stdout.writeln('Dalej: ${_nextStep(run, needsReview)}');
      }
    }

    final replyThreads = {
      for (final e in current.entries)
        if (e.value.contains(SongLabel.replyOldApp.label) || e.value.contains(SongLabel.replyReviewNote.label))
          mailbox.knownThreadOf(e.key) ?? e.key,
    };
    if (replyThreads.isNotEmpty) {
      final drafts = await mailbox.draftIdByThread();
      final withDraft = replyThreads.where(drafts.containsKey).length;
      stdout.writeln('Odpowiedzi czekają: ${plural(replyThreads.length, 'wątek', 'wątki', 'wątków')} '
          '($withDraft ze szkicem). Dalej: ./piosenkomat reply');
    }
    return 0;
  }
}

// ---------------------------------------------------------------------------
// reopen / unlabel / explain
// ---------------------------------------------------------------------------

class _ReopenCommand extends _PiosenkomatCommand {
  _ReopenCommand(super.connectMailbox, super.root) {
    argParser.addOption('query', help: 'Własne query Gmaila zamiast czekających na autora');
    addGmailOptions();
    addPushFlag('Zdejmij etykiety (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reopen';
  @override
  final description = 'Autorzy, którzy odpisali na Twój tekst („${SongLabel.waitingForAuthor.label}”): '
      'zdejmuje z ich wątków „song/*”, żeby wróciły do kolejki i przeszły scan. Kolejka to '
      '„inbox bez song/*, po wątkach”, więc odpowiedź w otagowanym wątku `scan` sam nie widzi.';

  @override
  Future<int> execute() async {
    final mailbox = await connect();
    final query = args['query'] as String? ??
        'label:${labelQueryName(SongLabel.waitingForAuthor.label)}';
    final ids = await mailbox.listIds(query);
    if (ids.isEmpty) {
      stdout.writeln('Nikt nie czeka na autora.');
      return 0;
    }
    stdout.writeln('Czeka na autora: ${plural(ids.length, 'mejl', 'mejle', 'mejli')}, '
        'sprawdzam wątki…');

    final threads = {for (final id in ids) mailbox.knownThreadOf(id) ?? id};
    // Jedno zapytanie na wątek: kto pisał ostatni, jakie wiadomości, temat.
    final authorReplied = [
      for (final t in threads)
        if (await mailbox.threadSummary(t) case final s when s.incomingAfterOurReply) s,
    ];
    if (authorReplied.isEmpty) {
      stdout.writeln('Nikt jeszcze nie odpisał '
          '(${plural(threads.length, 'wątek czeka', 'wątki czekają', 'wątków czeka')}).');
      return 0;
    }

    final labelsByMessage = await mailbox.songLabelsByMessage();
    // Piosenka w pliku albo już w apce → nie ma czego przesiewać na nowo:
    // „dzięki” od autora to nie zgłoszenie, a poprawkę przysyła się z apki.
    bool inSongbook(ThreadSummary t) => t.messageIds.any((id) => const [SongLabel.added, SongLabel.readyToAdd]
        .any((l) => (labelsByMessage[id] ?? const {}).contains(l.label)));
    final reopened = [for (final t in authorReplied) if (!inSongbook(t)) t];
    final skippedCount = authorReplied.length - reopened.length;
    final changes = <String, LabelChange>{
      for (final t in reopened)
        for (final id in t.messageIds)
          if (labelsByMessage[id] case final labels? when labels.isNotEmpty)
            id: (const [], labels.toList()),
    };

    if (skippedCount > 0) {
      stdout.writeln('Pomijam ${plural(skippedCount, 'wątek', 'wątki', 'wątków')} '
          'z „${SongLabel.readyToAdd.label}” albo „${SongLabel.added.label}” — piosenka jest '
          'w pliku albo w apce, odpowiedź to nie nowe zgłoszenie.');
    }
    if (reopened.isEmpty) {
      stdout.writeln('Nic do cofnięcia do kolejki.');
      return 0;
    }
    stdout.writeln('Odpisali w ${plural(reopened.length, 'wątku', 'wątkach', 'wątkach')} — '
        '${plural(changes.length, 'mejl wróci', 'mejle wrócą', 'mejli wróci')} do kolejki:');
    for (final t in reopened) {
      stdout.writeln('  ${t.subject}  ${t.from}  [${t.threadId}]');
    }
    if (dryRun('zdejmie etykiety „song/*”, żeby `scan` zobaczył te wątki na nowo')) {
      return 0;
    }
    await _applyChanges(mailbox, changes);
    stdout.writeln('Zdjęto etykiety z ${plural(changes.length, 'mejla', 'mejli', 'mejli')}. '
        'Wrócą w kolejnym scan --push.');
    return 0;
  }
}

class _UnlabelCommand extends _PiosenkomatCommand {
  _UnlabelCommand(super.connectMailbox, super.root) {
    argParser.addFlag('all', negatable: false, help: 'Cała skrzynka, nie tylko otwarty przebieg');
    addForceFlag('Zdejmij też z domkniętych („${SongLabel.added.label}”) i skasuj przebieg '
        'z robotą z przeglądu');
    addGmailOptions();
    addPushFlag('Cofnij (bez tej flagi tylko lista)');
  }

  @override
  final name = 'unlabel';
  @override
  final description = 'Cofa otwarty przebieg: zdejmuje to, co nadał automat („${SongLabel.auto.label}”), '
      'z jego mejli, kasuje szkice bez Twojego tekstu w ich wątkach i katalog out/run/. Bez '
      'out/run/ przebiegiem są wątki z otwartym werdyktem w Gmailu (inny komputer, skasowany '
      'katalog). Z --all — etykiety automatu z całej skrzynki. Mejle wracają do kolejki.';

  @override
  Future<int> execute() async {
    final run = runDir;
    if (run.exists && run.hasReviewWork && !force) {
      stderr.writeln('STOP. W ${run.path} są eksporty z przeglądu — przepadną. '
          '--force, jeśli świadomie.');
      return 1;
    }
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final scope = args['all'] as bool ? null : _openRunMessages(mailbox, current);
    if (scope != null && scope.isEmpty) {
      stdout.writeln('Żaden przebieg nie jest otwarty. Etykiety automatu z całej skrzynki: '
          './piosenkomat unlabel --all');
      return 0;
    }
    final result = unlabelChanges(current, scope: scope, force: force);
    // Szkice odpowiedzi w cofanych wątkach — bez etykiety `reply/*` nikt by ich
    // nie wysłał. Ta sama reguła co wszędzie: kasujemy tylko szkic bez Twojego
    // tekstu, z tekstem zostaje.
    final drafts = await mailbox.draftIdByThread();
    final threads = {for (final id in result.toRemove.keys) mailbox.knownThreadOf(id) ?? id};
    final draftsToDelete = <String>[];
    var draftsWithText = 0;
    for (final draftId in [for (final t in threads) if (drafts[t] case final id?) id]) {
      switch (draftStep(exists: true, body: await mailbox.draftBody(draftId))) {
        case DraftStep.delete:
          draftsToDelete.add(draftId);
        case DraftStep.differs:
          draftsWithText++;
        case _:
      }
    }

    if (result.toRemove.isEmpty && draftsToDelete.isEmpty && !run.exists) {
      stdout.writeln('Nic do cofnięcia — po automacie nie został ślad.');
      return 0;
    }
    stdout.writeln('Do zdjęcia z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}:');
    countLines(stdout, tally(result.toRemove.values.expand((l) => l)));
    if (draftsToDelete.isNotEmpty) {
      stdout.writeln('Szkice odpowiedzi do skasowania: ${draftsToDelete.length}');
    }
    if (draftsWithText > 0) {
      stdout.writeln('${plural(draftsWithText, 'szkic', 'szkice', 'szkiców')} z tekstem do autora '
          'zostaje — skasuj w Gmailu, jeśli niepotrzebne.');
    }
    if (result.outsideScope > 0) {
      stdout.writeln('Poza tym przebiegiem '
          '${plural(result.outsideScope, 'mejl ma', 'mejle mają', 'mejli ma')} znacznik '
          '„${SongLabel.auto.label}”. Zejdą z `unlabel --all`.');
    }
    if (result.added > 0) {
      stdout.writeln('Pomijam ${plural(result.added, 'domknięty', 'domknięte', 'domkniętych')} '
          '(„${SongLabel.added.label}”) — te piosenki są już w apce; --force, jeśli mimo to '
          'mają zejść.');
    }
    if (run.exists) stdout.writeln('Katalog przebiegu do skasowania: ${run.path}');
    if (dryRun('cofnie powyższe')) return 0;

    await _applyChanges(mailbox, {
      for (final e in result.toRemove.entries) e.key: (const [], e.value),
    });
    for (final draftId in draftsToDelete) {
      await mailbox.deleteDraft(draftId);
    }
    if (run.exists) Directory(run.path).deleteSync(recursive: true);
    stdout.writeln('Cofnięte. Mejle wracają do kolejki, więc `scan` weźmie je ponownie.');
    return 0;
  }
}

class _ExplainCommand extends _PiosenkomatCommand {
  _ExplainCommand(super.connectMailbox, super.root) {
    addSongsDbOption();
  }

  @override
  final name = 'explain';
  @override
  final description = 'Klasyfikacja lokalnych plików .eml, bez Gmaila.';
  @override
  String get invocation => './piosenkomat explain plik.eml [...]';
  @override
  int? get maxRest => null;

  @override
  Future<int> execute() async {
    if (args.rest.isEmpty) usageException('Podaj pliki .eml: ./piosenkomat explain plik.eml');
    final book = loadSongBook();
    final messages = [
      for (final path in args.rest)
        ContribMessage.fromEmlBytes(File(_resolve(path)).readAsBytesSync(), id: p.basename(path)),
    ];
    stdout.write(formatRunReport(classifyBatch(messages, book: book)));
    return 0;
  }
}

// ---------------------------------------------------------------------------
// Pomocnicze
// ---------------------------------------------------------------------------

/// Mejle z otwartym werdyktem automatu: czekają na `review` albo `finalize`.
/// Póki są, przebieg jest otwarty — gdziekolwiek jest jego katalog.
List<String> openVerdicts(Map<String, Set<String>> labelsByMessage) => [
      for (final MapEntry(key: id, value: labels) in labelsByMessage.entries)
        if (hasToolLabel(labels, SongLabel.readyToAdd) || hasToolLabel(labels, SongLabel.needsReview)) id,
    ];

String _openElsewhere(int count) => 'W Gmailu wisi otwarty przebieg, którego tu nie ma: '
    '${plural(count, 'mejl czeka', 'mejle czekają', 'mejli czeka')} na przegląd albo finalize '
    '(inny komputer albo skasowany katalog). Domknij go tam albo cofnij — mejle wrócą do '
    'kolejki: ./piosenkomat unlabel --push';

String _interrupted(RunPlan plan) => 'scan --push przebiegu ${plan.id} został przerwany w połowie — '
    'dokończy go ./piosenkomat scan --push';

/// Wątki przebiegu, w których automat trzyma [label].
List<String> _threadsWith(RunPlan plan, Map<String, Set<String>> current, SongLabel label) => [
      for (final MapEntry(key: thread, value: ids) in plan.messagesByThread.entries)
        if (ids.any((id) => hasToolLabel(current[id] ?? const {}, label))) thread,
    ];

/// Następny krok otwartego przebiegu — po etykietach i plikach w katalogu.
String _nextStep(RunDir run, int needsReview) {
  if (needsReview > 0 || run.missingExports.isNotEmpty) {
    return 'przegląd na stronie, eksport do reviewed-*.hrcpsng, potem ./piosenkomat review --push';
  }
  if (run.kinds.any((kind) => !File(run.finalSongs(kind)).existsSync())) return './piosenkomat review --push';
  if (run.kinds.isEmpty) return './piosenkomat finalize --push (nic nie poszło do przeglądu)';
  return 'wklej final-*.hrcpsng do all_songs, potem ./piosenkomat finalize --push';
}

/// Zmiany, które wolno wypchnąć: tylko na mejlach, które automat wstawił do
/// plików przebiegu i które jeszcze nie weszły do apki ([isInRunFilesByTool]).
Map<String, LabelChange> _applicable(Map<String, LabelChange> changes, Map<String, Set<String>> current) => {
      for (final e in changes.entries)
        if (current[e.key] case final labels? when isInRunFilesByTool(labels))
          e.key: withReadOnClose(e.value, current: labels),
    };

/// Etykiety po [changes] — bez pytania Gmaila drugi raz.
Map<String, Set<String>> _after(Map<String, Set<String>> current, Map<String, LabelChange> changes) => {
      for (final id in {...current.keys, ...changes.keys})
        id: {...?current[id], ...?changes[id]?.$1}..removeAll(changes[id]?.$2 ?? const []),
    };

/// Czy któraś wiadomość wątku ma etykietę [label].
bool _awaits(RunPlan plan, Map<String, Set<String>> labels, String thread, SongLabel label) =>
    plan.messagesOf(thread).any((id) => labels[id]?.contains(label.label) ?? false);

/// Wątki przebiegu, jakie widzą szkice: kto, na co czeka i jaki tekst z [notes]
/// ma dostać. Tekst liczy się tylko w wątku, który czeka na odpowiedź
/// z przeglądu (`reply/review-note`).
List<ReplyThread> _replyThreads(RunPlan plan, Map<String, Set<String>> labels,
        [Map<String, String> notes = const {}]) =>
    [
      for (final MapEntry(key: thread, value: ids) in plan.messagesByThread.entries)
        if (plan.senderByThread[thread] case final sender?)
          (
            threadId: thread,
            sender: sender,
            messageIds: ids,
            oldApp: _awaits(plan, labels, thread, SongLabel.replyOldApp),
            note: _awaits(plan, labels, thread, SongLabel.replyReviewNote) ? notes[thread] : null,
          ),
    ];

/// Mejle o tej samej zmianie idą jedną paczką: `batchModify` bierze do 1000
/// naraz, więc przebieg to kilkanaście strzałów, nie kilkaset.
Future<void> _applyChanges(Mailbox mailbox, Map<String, LabelChange> changes) async {
  final groups = <String, (LabelChange, List<String>)>{};
  for (final e in changes.entries) {
    final (add, remove) = e.value;
    final key = '${add.join('\u0000')}\u0001${remove.join('\u0000')}';
    groups.putIfAbsent(key, () => (e.value, [])).$2.add(e.key);
  }
  for (final ((add, remove), ids) in groups.values) {
    await mailbox.batchModify(ids,
        add: add.isEmpty ? null : add, remove: remove.isEmpty ? null : remove);
  }
}

String _kindName(SubmissionKind k) =>
    k == SubmissionKind.correction ? 'Poprawki' : 'Nowe';

/// Narzędzie działa w `tool/piosenkomat/`, ale użytkownik podaje ścieżki
/// z katalogu, w którym wpisał `./piosenkomat` (przekazany w PIOSENKOMAT_CWD).
String _resolve(String path) {
  if (p.isAbsolute(path) || _exists(path)) return path;
  final cwd = Platform.environment['PIOSENKOMAT_CWD'];
  if (cwd != null) {
    final candidate = p.join(cwd, path);
    if (_exists(candidate)) return candidate;
  }
  return path;
}

bool _exists(String path) =>
    FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;
