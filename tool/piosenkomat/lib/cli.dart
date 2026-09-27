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

Future<int> runPiosenkomat(List<String> args, {MailboxConnector? connect}) async {
  final runner = _Runner(connect ?? _connectGmail);
  // Dwa błędy użycia po polsku, bo to te, na które trafia się najczęściej.
  if (args.isEmpty) {
    stdout.writeln(runner.usage);
    return 64;
  }
  if (!args.first.startsWith('-') && !runner.commands.containsKey(args.first)) {
    stderr.writeln('Nie ma komendy „${args.first}”.');
    stdout.writeln(runner.usage);
    return 64;
  }
  final label = runner.commands['label']!;
  if (args.first == 'label' &&
      (args.length == 1 || !(args[1].startsWith('-') || label.subcommands.containsKey(args[1])))) {
    stderr
      ..writeln('Podaj etap: ./piosenkomat label ${label.subcommands.keys.join('|')}')
      ..writeln(label.usage);
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
  _Runner(MailboxConnector connect)
      : super('./piosenkomat', 'piosenkomat: sitko mejli z piosenkami na $kInboxEmail.') {
    addCommand(_ScanCommand(connect));
    addCommand(_LabelCommand(connect));
    addCommand(_UnlabelCommand(connect));
    addCommand(_ReplyCommand(connect));
    addCommand(_ReopenCommand(connect));
    addCommand(_CleanCommand(connect));
    addCommand(_ExplainCommand(connect));
    addCommand(_PrepareCommand(connect));
  }

  @override
  String get usageFooter => '\nBez katalogu komendy biorą ostatni przebieg z out/.\n'
      'Bez --push nic w Gmailu się nie zmienia.\n'
      'Flagi komendy: ./piosenkomat <komenda> --help';
}

Future<Mailbox> _connectGmail(ArgResults args) => GmailMailbox.connect(
      credentialsFile: File(args['credentials'] as String? ?? defaultCredentialsPath()),
      tokenFile: File(args['token'] as String? ?? defaultTokenPath()),
    );

/// Wspólne dla komend: opcje, katalog przebiegu, dry-run.
abstract class _PiosenkomatCommand extends Command<int> {
  _PiosenkomatCommand(this._connect);

  final MailboxConnector _connect;

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

  Future<Mailbox> connect() => _connect(args);

  /// Tylko komendy, które łączą się z Gmailem.
  void addGmailOptions() => argParser
    ..addOption('credentials', help: 'Domyślnie secrets/credentials.json')
    ..addOption('token', help: 'Domyślnie secrets/gmail_token.json');

  /// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
  /// „wypchnij to, co widzisz na sucho, do skrzynki”.
  void addPushFlag(String help) => argParser.addFlag('push', negatable: false, help: help);

  /// Bez katalogu komendy biorą ostatni przebieg; `--all` — całą skrzynkę.
  void addAllFlag() => argParser.addFlag('all', negatable: false, help: 'Cała skrzynka, nie tylko przebieg');

  /// Tylko komendy, które porównują ze śpiewnikiem.
  void addSongsDbOption() => argParser.addOption('songs-db', help: 'Ścieżka do all_songs.hrcpsng');

  /// Bez `--push` komenda kończy na liście: mówi, co zrobiłoby `--push`.
  /// `true` = to był dry-run, dalej nie idziemy.
  bool dryRun(String whatPushDoes) {
    if (args['push'] as bool) return false;
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

  /// Katalog przebiegu z argumentu, a bez argumentu — ostatni z `out/`.
  RunDir runDir() {
    if (args.rest.length == 1) {
      final arg = _resolve(args.rest.single);
      if (!FileSystemEntity.isDirectorySync(arg)) {
        usageException('To nie jest katalog przebiegu: $arg');
      }
      return RunDir(arg);
    }
    final latest = RunDir.latest();
    if (latest == null) usageException('Nie ma żadnego przebiegu w out/. Najpierw: ./piosenkomat scan');
    final dir = RunDir(_resolve(latest.path));
    stdout.writeln('Ostatni przebieg: ${dir.path}');
    return dir;
  }

  /// Plan przebiegu z argumentu (albo ostatniego) — chyba że `--all`, wtedy
  /// cała skrzynka i planu nie ma.
  RunPlan? planUnlessAll() {
    if (args['all'] as bool) return null;
    final plan = runDir().readRunPlan();
    stdout.writeln(_planHeader(plan));
    return plan;
  }

  SongBook loadSongBook() {
    final path = args['songs-db'] as String? ?? defaultSongsDbPath();
    final book = loadBook(path);
    stdout.writeln('Śpiewnik: $path (${book.songs.length} tytułów)');
    return book;
  }
}

// ---------------------------------------------------------------------------
// scan
// ---------------------------------------------------------------------------

class _ScanCommand extends _PiosenkomatCommand {
  _ScanCommand(super.connect) {
    argParser
      ..addOption('limit',
          abbr: 'n', help: 'Ile zgłoszeń (wątków) z kolejki, każde w całości (domyślnie wszystkie)')
      ..addFlag('newest', negatable: false, help: 'Najnowsze N zamiast najstarszych')
      ..addOption('out', abbr: 'o', help: 'Katalog przebiegu (domyślnie out/import-<data>)')
      ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');
    addSongsDbOption();
    addGmailOptions();
  }

  @override
  final name = 'scan';
  @override
  final description = 'Kolejka (inbox bez song/*, po wątkach) → katalog out/import-<data>/: '
      'raport, plan, candidates-new.hrcpsng, candidates-correction.hrcpsng '
      '(uwagi przy piosenkach), reviewed-*.hrcpsng. Gmaila tylko czyta — '
      'jako jedyna komenda nie ma --push.';

  @override
  Future<int> execute() async {
    final newest = args['newest'] as bool;
    final limit = this.limit();

    final book = loadSongBook();
    final mailbox = await connect();
    final query = args['query'] as String? ?? kQueueQuery;

    // Cała lista, bo `-n` liczy wątki, a wiadomości jednego wątku bywają
    // rozrzucone po kolejce. Samo listowanie jest tanie — treści nie ciągnie.
    final queueIds = [
      for (final id in await mailbox.listIds(query))
        (id: id, threadId: mailbox.knownThreadOf(id) ?? id),
    ];
    // Odpowiedzi w wątkach z `song/*` odsiewamy przed pobieraniem treści —
    // i przed `-n`, żeby limit liczył prawdziwe zgłoszenia.
    final alive = unlabeledQueue(queueIds, await mailbox.threadsWithSongLabels());
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
    final messages = queue.songs;
    final skipped = fetched.length - messages.length - queue.web;
    if (skipped > 0) {
      stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')} '
          '(już otagowane albo nie o piosence), zostają bez zmian.');
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

    final runDir = switch (args['out'] as String?) {
      final out? => RunDir(out),
      null => RunDir.fresh(),
    };
    final classified = classifyBatch([...messages, ...ours],
        book: book, weRepliedThreads: weRepliedThreads, run: runDir.name);
    final report = formatRunReport(classified);
    stdout
      ..writeln()
      ..write(report);
    _writeRunFiles(runDir, classified, report);

    stdout.writeln('Gmail nietknięty — `scan` tylko czyta. Etykiety jak '
        'w raporcie nada: ./piosenkomat label scanned ${runDir.path} --push');
    return 0;
  }
}

/// Wątki autorów ze starej apki, którym już coś wysłaliśmy — w którymkolwiek
/// wątku. Blok „zaktualizuj apkę” wystarczy dostać raz, a `reply` nie odpisuje
/// w każdym wątku autora, więc w części z nich `SENT` nie ma. Pytamy więc
/// o nadawcę: jedno tanie zapytanie na autora ze starej apki.
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

/// Katalog przebiegu: raport, plan przebiegu i po dwa pliki na rodzaj —
/// kandydaci i puste miejsce na eksport po przeglądzie.
void _writeRunFiles(RunDir runDir, List<Classified> classified, String report) {
  writeText(runDir.report, report);

  assignUniqueIds([for (final c in classified) if (c.goesToFile) c.song!]);
  writePlan(runDir.plan, RunPlan.fromClassified(classified));

  // Dwa pliki, bo to dwie roboty: nowe dodajesz, poprawki porównujesz
  // z tym, co w apce. Uwagi jadą w piosenkach — edytor pokaże je nad każdą.
  var anyWritten = false;
  for (final kind in SubmissionKind.values) {
    final items = [
      for (final c in classified)
        if (c.goesToFile && c.submission.kind == kind) c,
    ];
    if (items.isEmpty) continue;
    anyWritten = true;
    final songs = [for (final c in items) c.song!];
    final path = runDir.candidates(kind);
    writeHrcpsng(path, songs, withPiosenkomatData: true);
    final clean = items.where((c) => c.issues.isEmpty).length;
    stdout.writeln('\n${_kindName(kind)}: ${plural(songs.length, 'piosenka', 'piosenki', 'piosenek')} '
        '→ $path ($clean bez zarzutu, ${songs.length - clean} z uwagami)');
    // Miejsce na eksport: wrzucasz tu plik ze strony, a `label reviewed`
    // z różnicy wyciąga odrzucone. Pusty, nie kopia kandydatów — kopia
    // wyglądałaby jak przegląd, w którym wszystko weszło.
    runDir.writeReviewedPlaceholder(kind);
    stdout.writeln('  po przeglądzie zapisz eksport ze strony w ${runDir.reviewed(kind)} (na razie pusty)');
  }

  stdout.writeln(anyWritten
      ? 'Wczytuj jeden plik naraz na stronie ze śpiewnikiem; '
          'potem: ./piosenkomat label reviewed ${runDir.path}'
      : '\nNic nie poszło do plików.');
  stdout
    ..writeln('Katalog: ${runDir.path}')
    ..writeln('Raport: ${runDir.report}')
    ..writeln('Plan przebiegu: ${runDir.plan}');
}

// ---------------------------------------------------------------------------
// label scanned / reviewed / added, unlabel
// ---------------------------------------------------------------------------

class _LabelCommand extends Command<int> {
  _LabelCommand(MailboxConnector connect) {
    addSubcommand(_LabelScannedCommand(connect));
    addSubcommand(_LabelReviewedCommand(connect));
    addSubcommand(_LabelAddedCommand(connect));
  }

  @override
  final name = 'label';
  @override
  final description = 'Etykiety w Gmailu po kolejnych etapach przebiegu.';
}

class _LabelScannedCommand extends _PiosenkomatCommand {
  _LabelScannedCommand(super.connect) {
    addGmailOptions();
    addPushFlag('Nadaj etykiety (bez tej flagi tylko lista)');
  }

  @override
  final name = 'scanned';
  @override
  final description = 'Werdykty automatu na mejle z plan.json: „${SongLabel.readyToAdd.label}”, '
      '„song/rejected/…”, „${SongLabel.needsReview.label}”, wszystko ze znacznikiem '
      '„${SongLabel.auto.label}”. Mejle, które w międzyczasie dostały etykietę song/*, pomija.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final plan = runDir().readRunPlan();
    stdout.writeln(_planHeader(plan));
    countLines(stdout, tally(plan.labelsByMessage.values.expand((l) => l)));
    if (dryRun('nada powyższe')) return 0;

    final mailbox = await connect();
    stdout.writeln('Sprawdzam aktualne etykiety '
        '${plural(plan.labelsByMessage.length, 'mejla', 'mejli', 'mejli')}…');
    final current = await mailbox.songLabelsByMessage();
    final changes = {
      for (final e in plan.labelsByMessage.entries)
        if (!current.containsKey(e.key)) e.key: withReadOnClose((e.value, const [])),
    };
    await mailbox.ensureToolLabels();
    await _applyChanges(mailbox, changes);
    stdout.writeln('Nadano:');
    countLines(stdout, tally(changes.values.expand((c) => c.$1)));
    final skipped = plan.labelsByMessage.length - changes.length;
    if (skipped > 0) {
      stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')}, '
          'które już miały etykietę song/*.');
    }
    stdout.writeln('Po przeglądzie na stronie zapisz eksporty w reviewed-*.hrcpsng, potem '
        './piosenkomat label reviewed --push');
    return 0;
  }
}

class _UnlabelCommand extends _PiosenkomatCommand {
  _UnlabelCommand(super.connect) {
    argParser.addFlag('force',
        negatable: false, help: 'Zdejmij też z domkniętych („${SongLabel.added.label}”)');
    addAllFlag();
    addGmailOptions();
    addPushFlag('Zdejmij etykiety (bez tej flagi tylko lista)');
  }

  @override
  final name = 'unlabel';
  @override
  final description = 'Cofa wszystko, co nadał automat („${SongLabel.auto.label}”) na mejlach '
      'przebiegu; z --all — w całej skrzynce. Reguły w unlabelChanges.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final plan = planUnlessAll();
    final mailbox = await connect();
    stdout.writeln('Sprawdzam etykiety w skrzynce…');
    final result = unlabelChanges(await mailbox.songLabelsByMessage(),
        plan: plan, force: args['force'] as bool);

    if (result.toRemove.isEmpty) {
      stdout.writeln('Nic do zdjęcia — po automacie nie został ślad.');
      return 0;
    }
    stdout.writeln('Do zdjęcia z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}:');
    countLines(stdout, tally(result.toRemove.values.expand((l) => l)));
    if (result.outsidePlan > 0) {
      stdout.writeln('Poza tym przebiegiem '
          '${plural(result.outsidePlan, 'mejl ma', 'mejle mają', 'mejli ma')} znacznik '
          '„${SongLabel.auto.label}”. Zejdą z `unlabel --all`.');
    }
    if (result.added > 0) {
      stdout.writeln('Pomijam ${plural(result.added, 'domknięty', 'domknięte', 'domkniętych')} '
          '(„${SongLabel.added.label}”) — te piosenki są już w apce; --force, jeśli mimo to '
          'mają zejść.');
    }
    if (dryRun('zdejmie powyższe')) return 0;

    await _applyChanges(mailbox, {
      for (final e in result.toRemove.entries) e.key: (const [], e.value),
    });
    stdout.writeln('Zdjęto z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}. '
        'Wracają do kolejki, więc `scan` weźmie je ponownie.');
    return 0;
  }
}

class _LabelAddedCommand extends _PiosenkomatCommand {
  _LabelAddedCommand(super.connect) {
    addAllFlag();
    addGmailOptions();
    addPushFlag('Zmień etykiety w Gmailu (bez tej flagi lista)');
  }

  @override
  final name = 'added';
  @override
  final description = '„${SongLabel.readyToAdd.label}” + „${SongLabel.auto.label}” → '
      '„${SongLabel.added.label}” + przeczytane. Domyślnie przebieg: „domknij to, co z TEGO '
      'przebiegu wkleiłeś do śpiewnika” — mejle z innego, jeszcze niewklejonego, zostają otwarte.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final plan = planUnlessAll();
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    // Ruszamy tylko to, co automat sam wstawił do pliku. Sam zestaw etykiet
    // wystarczy, żeby wiedzieć, co jest gotowe — bez osobnego zapytania.
    final readyByTool = [
      for (final e in current.entries)
        if (isReadyByTool(e.value)) e.key,
    ];
    final ready = plan == null
        ? readyByTool
        : [for (final id in readyByTool) if (plan.labelsByMessage.containsKey(id)) id];
    final readyOutsideRun = readyByTool.length - ready.length;

    // Tytuł i nadawcę bierzemy z planu przebiegu — leżą w `plan.json` za darmo.
    // Dopytujemy Gmaila tylko o mejle spoza planu (20 jednostek za sztukę).
    final plannedByMessage = plan?.songByMessage ?? const {};
    for (final id in ready) {
      if (plannedByMessage[id] case final song?) {
        stdout.writeln('  ${song.title}  ${song.sender}  [$id]');
      } else {
        final h = await mailbox.headersOf(id);
        stdout.writeln('  ${h.subject}  ${emailFromHeader(h.from) ?? ''}  [$id]');
      }
    }
    stdout.writeln('„${SongLabel.readyToAdd.label}” + „${SongLabel.auto.label}”: '
        '${plural(ready.length, 'mejl', 'mejle', 'mejli')}');
    if (readyOutsideRun > 0) {
      stdout.writeln('  $readyOutsideRun czeka poza tym przebiegiem — domknij je '
          'jego własnym `label added` (albo `--all`, gdy masz wklejone wszystkie).');
    }
    if (dryRun('zmieni na „${SongLabel.added.label}” + przeczytane')) return 0;

    await mailbox.ensureToolLabels();
    await _applyChanges(mailbox, {
      for (final id in ready)
        id: withReadOnClose(([SongLabel.added.label], [SongLabel.readyToAdd.label]),
            current: current[id] ?? const {}),
    });
    stdout.writeln('Zatwierdzono ${plural(ready.length, 'mejl', 'mejle', 'mejli')}.');
    return 0;
  }
}

String _planHeader(RunPlan plan) => 'Plan z ${_minute(plan.createdAt)}: '
    '${plural(plan.labelsByMessage.length, 'mejl', 'mejle', 'mejli')}';

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

class _LabelReviewedCommand extends _PiosenkomatCommand {
  _LabelReviewedCommand(super.connect) {
    argParser.addFlag('force',
        negatable: false, help: 'Pomiń bezpieczniki (pusty plik, odrzucona większość)');
    addGmailOptions();
    addPushFlag('Zmień etykiety odrzuconych (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reviewed';
  @override
  final description = 'Różnica między candidates-* a reviewed-* po id wątku: co jest '
      '→ „${SongLabel.readyToAdd.label}”, czego nie ma → „${SongLabel.rejectedAfterReview.label}”. '
      'Z kandydatów można wywalać i edytować, nie dodawać: obcy wątek, zły rodzaj '
      'w pliku albo dwie poprawki tej samej piosenki → STOP, bez --force.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final runDir = this.runDir();
    final force = args['force'] as bool;
    if (_stopOnMissingExports(runDir)) return 1;
    final plan = runDir.readRunPlan();

    // Także na sucho: bez etykiet automatu `--push` nie ma czego przestawić,
    // a dry-run obiecywałby zmiany, których nie będzie.
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    if (!isRunInGmail(plan, current)) {
      stderr.writeln('Runda ${runDir.name} nie ma jeszcze etykiet w Gmailu. '
          'Najpierw: ./piosenkomat label scanned ${runDir.path} --push');
      return 1;
    }

    final results = <ReviewResult>[];
    for (final kind in SubmissionKind.values) {
      final candidates = collectCandidates(plan, _candidatesOf(runDir, kind), kind);
      if (candidates.isEmpty) continue;
      final reviewedPath = runDir.reviewed(kind);
      final reviewed = readHrcpsng(reviewedPath);
      stdout.writeln('${_kindName(kind)}: ${candidates.length} kandydatów, '
          '${reviewed.length} w $reviewedPath');
      final result = reviewDiff(kind: kind, candidates: candidates, reviewed: reviewed);
      _printReview(result);

      if (result.mustStop) {
        _printStop(result, kind);
        return 1;
      }
      if (!force) {
        final error = reviewSafetyError(result,
            reviewedPath: reviewedPath,
            reviewedCount: reviewed.length,
            candidateCount: candidates.length);
        if (error != null) {
          stderr.writeln(error);
          return 1;
        }
      }
      results.add(result);
    }

    if (results.isEmpty) {
      stdout.writeln('Nic do porównania.');
      return 0;
    }
    writeDecisions(runDir.decisions, results);
    stdout.writeln('Ślad przeglądu: ${runDir.decisions}');

    final changes = reviewLabelChanges(results, plan);
    if (changes.isEmpty) {
      stdout.writeln('\nNic do przestawienia. ${_afterReviewed(runDir)}');
      return 0;
    }
    if (dryRun('przestawi etykiety na '
        '${plural(changes.length, 'mejlu', 'mejlach', 'mejlach')}')) {
      return 0;
    }

    await mailbox.ensureToolLabels();
    // Bezpiecznik jak w `label added`: ruszamy tylko to, co automat sam
    // wstawił do plików przebiegu i co dalej tam czeka.
    final applicable = <String, LabelChange>{
      for (final e in changes.entries)
        if (current[e.key] case final labels? when isInRunFilesByTool(labels))
          e.key: withReadOnClose(
              (e.value.$1, [for (final l in e.value.$2) if (labels.contains(l)) l]),
              current: labels),
    };
    await _applyChanges(mailbox, applicable);
    stdout.writeln('Przestawiono etykiety na '
        '${plural(applicable.length, 'mejlu', 'mejlach', 'mejlach')}.');
    final skipped = changes.length - applicable.length;
    if (skipped > 0) {
      stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')} '
          'spoza plików tego przebiegu.');
    }
    stdout.writeln(_afterReviewed(runDir));
    return 0;
  }
}

/// `label reviewed` i `prepare` ruszają dopiero z kompletem eksportów: pusty
/// albo brakujący plik zwrotny to przegląd, którego jeszcze nie było, a nie
/// „wszystko weszło”. `true` = STOP, dalej nie idziemy.
bool _stopOnMissingExports(RunDir runDir) {
  final missing = runDir.missingExports;
  if (missing.isEmpty) return false;
  for (final path in missing) {
    stderr.writeln('  BRAK EKSPORTU  $path');
  }
  stderr.writeln('STOP. Zapisz tam eksport ze strony i odpal ponownie.');
  return true;
}

/// Co po `label reviewed`: kolejność z README, bez skrótów — `label added`
/// przed wklejeniem piosenek do `all_songs` kłamie (mejl zamknięty, piosenki
/// w apce nie ma).
String _afterReviewed(RunDir runDir) =>
    'Dalej: ./piosenkomat prepare ${runDir.path}, wklej final-*.hrcpsng do all_songs, '
    'a dopiero potem ./piosenkomat label added ${runDir.path} --push';

String _kindName(SubmissionKind k) =>
    k == SubmissionKind.correction ? 'Poprawki' : 'Nowe';

/// Kandydaci danego rodzaju z katalogu przebiegu.
List<SongRaw> _candidatesOf(RunDir runDir, SubmissionKind kind) {
  final path = runDir.candidates(kind);
  return _exists(path) ? readHrcpsng(path) : const [];
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
  stderr.writeln('STOP. Popraw eksport i odpal ponownie.');
}

// ---------------------------------------------------------------------------
// prepare
// ---------------------------------------------------------------------------

class _PrepareCommand extends _PiosenkomatCommand {
  _PrepareCommand(super.connect);

  @override
  final name = 'prepare';
  @override
  final description = 'reviewed-*.hrcpsng → final-*.hrcpsng bez pola `piosenkomat`; poprawki '
      'dostają id poprawianej piosenki i listę „co podmienić”; do tego people.dart '
      'z osób, które naprawdę weszły. Jedyna komenda, która niczego nie rusza w Gmailu — '
      'i nie ostatnia w przebiegu, bo po niej idzie jeszcze `label added` i odpowiedzi.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final runDir = this.runDir();
    if (_stopOnMissingExports(runDir)) return 1;
    final otherEmails = _otherEmailsFromPlan(runDir);
    var anyReviewed = false;
    final sources = <ContributorSource>[];
    for (final kind in SubmissionKind.values) {
      final reviewedPath = runDir.reviewed(kind);
      if (!_exists(reviewedPath)) continue;
      anyReviewed = true;
      final allSongs = readHrcpsng(reviewedPath);
      // Przełącznik „nie wchodzi” z przeglądu. Nieruszony znaczy „wchodzi”,
      // więc milczenie na stronie nie wyrzuca piosenki z pliku.
      final songs = [
        for (final s in allSongs)
          if (s.piosenkomatData?.goesIn ?? true) s,
      ];
      final turnedDownCount = allSongs.length - songs.length;
      // Przed zdjęciem śladu, bo `sender_is_contributor` siedzi w nim.
      sources.addAll(contributorSourcesOf(songs, otherEmailsBySender: otherEmails));
      final correctionTargets = stripPiosenkomat(songs);
      final out = runDir.finalSongs(kind);
      writeHrcpsng(out, songs);
      stdout.writeln('${_kindName(kind)}: '
          '${plural(songs.length, 'piosenka', 'piosenki', 'piosenek')} → $out');
      if (turnedDownCount > 0) {
        stdout.writeln('  pominięto $turnedDownCount z przełącznikiem „nie wchodzi”');
      }
      if (kind == SubmissionKind.correction) {
        for (final t in correctionTargets) {
          stdout.writeln('  podmień ${t.id}  ←  ${t.title}'
              '${t.guessed ? '   (cel ZGADNIĘTY — sprawdź, zanim podmienisz)' : ''}');
        }
        final noTarget = songs.length - correctionTargets.length;
        if (noTarget > 0) {
          stdout.writeln('  $noTarget bez celu (no-target-in-app) — te dodasz jak nowe '
              'albo podmienisz ręcznie');
        }
      }
    }
    if (!anyReviewed) {
      stderr.writeln('Brak plików zwrotnych w ${runDir.path}.');
      return 1;
    }
    _writePeople(runDir, collectPeople(sources));
    return 0;
  }
}

/// Dodatkowe adresy z bloku „Osoba dodająca” trzyma plan przebiegu —
/// piosenka niesie tylko `email_ref`.
Map<String, List<String>> _otherEmailsFromPlan(RunDir runDir) {
  if (!_exists(runDir.plan)) return const {};
  try {
    return otherEmailsBySender(runDir.readRunPlan());
  } on FormatException {
    stdout.writeln('Plan ${runDir.plan} nie do odczytania — '
        'w people.dart same adresy nadawców.');
    return const {};
  }
}

void _writePeople(RunDir runDir, PeopleReport people) {
  writePeopleDart(runDir.people, people);
  stdout.writeln('Osoby dodające: ${people.newContributors.length} nowych → ${runDir.people}'
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
// reply
// ---------------------------------------------------------------------------

enum _ReplyMode { send, draft, undraft }

class _ReplyCommand extends _PiosenkomatCommand {
  _ReplyCommand(super.connect) {
    argParser
      ..addOption('limit', abbr: 'n', help: 'Ilu autorom odpisać w tym przebiegu')
      ..addOption('query', help: 'Własne query Gmaila zamiast kolejki odpowiedzi')
      ..addFlag('draft',
          negatable: false,
          help: 'Przygotuj szkice zamiast wysyłać; wyśle je późniejszy `reply --push`')
      ..addFlag('undraft', negatable: false, help: 'Skasuj szkice przygotowane przez --draft')
      ..addFlag('all', negatable: false, help: 'Cała stojąca kolejka, nie tylko autorzy z przebiegu');
    addGmailOptions();
    addPushFlag('Wyślij (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reply';
  @override
  final description = 'Odpowiedzi do autorów: Twoje teksty z przeglądu i „zaktualizuj apkę”, '
      'jeden mejl na piosenkę, w jej wątku. Kolejką są „${SongLabel.replyOldApp.label}” '
      'i „${SongLabel.replyReviewNote.label}”; po tekście z przeglądu wchodzi '
      '„${SongLabel.waitingForAuthor.label}”. Zakresem jest przebieg, zaległość spoza niego '
      'bierze --all. --draft zostawia szkice w wątkach (kolejka nietknięta) — późniejszy '
      'reply --push wysyła je z Twoimi poprawkami, a --undraft je kasuje.';
  @override
  int? get maxRest => 1;

  @override
  Future<int> execute() async {
    final draft = args['draft'] as bool;
    final undraft = args['undraft'] as bool;
    if (draft && undraft) usageException('--draft i --undraft naraz nie mają sensu.');
    final mode = undraft
        ? _ReplyMode.undraft
        : draft
            ? _ReplyMode.draft
            : _ReplyMode.send;
    final limit = this.limit();

    // Zakres: domyślnie autorzy z przebiegu, bo odpisuje się po imporcie.
    // Zaległa kolejka spoza niego siedzi w skrzynce i czeka na `--all`.
    final wholeQueue = (args['all'] as bool) || args['query'] != null;
    final runDir = wholeQueue ? null : this.runDir();
    final plan = runDir?.readRunPlan();
    // Etykieta dalej mówi, komu nie odpisano; przebieg tylko zawęża do tych,
    // których sam przyniósł. Przecięcie, nie zastąpienie.
    bool inScope(String id) => plan == null || plan.labelsByMessage.containsKey(id);

    final mailbox = await connect();
    // Dwie kolejki, jeden mejl: blok o starej apce i uwagi z przeglądu trafiają
    // do tego samego autora razem, więc bierzemy obie naraz.
    final query = args['query'] as String? ??
        '(label:${labelQueryName(SongLabel.replyOldApp.label)} '
            'OR label:${labelQueryName(SongLabel.replyReviewNote.label)})';
    var ids = await mailbox.listIds(query);
    final draftIdByThread = await mailbox.draftIdByThread();
    if (mode == _ReplyMode.undraft) {
      // Tylko wątki, w których szkic faktycznie czeka.
      ids = [for (final id in ids) if (draftIdByThread.containsKey(mailbox.knownThreadOf(id))) id];
    }
    if (plan != null) {
      final before = ids.length;
      ids = ids.where(inScope).toList();
      stdout.writeln('Zakres: przebieg ${runDir!.path} '
          '(${ids.length} z $before mejli w kolejce; --all bierze wszystkie)');
    }
    if (ids.isEmpty) {
      stdout.writeln(switch (mode) {
        _ReplyMode.undraft => 'Nie ma szkiców do skasowania.',
        _ReplyMode.draft || _ReplyMode.send => 'Nikt nie czeka na odpowiedź.',
      });
      return 0;
    }
    stdout.writeln('Do odpisania: ${plural(ids.length, 'mejl', 'mejle', 'mejli')}, '
        'pobieram nagłówki…');

    final queue = await groupBySender(mailbox, ids, query: query, limit: limit, inScope: inScope);
    // Teksty z pola „Odpowiedź do autora”: ze śladu przeglądu, bo `prepare`
    // zdejmuje je z piosenek na długo przed `reply`.
    final reviewNotes = {
      for (final dir in runDir != null ? [runDir] : RunDir.all())
        ...readReviewNotes(dir.decisions),
    };
    // Kto jest ze starej apki — po tym wiadomo, czy doklejać jej blok.
    final oldAppIds =
        (await mailbox.listIds('label:${labelQueryName(SongLabel.replyOldApp.label)}')).toSet();
    final plans = {
      for (final sender in queue.senders)
        sender: planAuthorReplies(
          sender,
          [
            for (final id in queue.bySender[sender]!)
              (id: id, threadId: queue.replyTargetById[id]!.threadId),
          ],
          reviewNotes: reviewNotes,
          oldAppIds: oldAppIds,
        ),
    };
    printReplyQueue(queue, plans);
    final mails = plans.values.fold(0, (n, a) => n + a.replies.length);
    final queuedDrafts = {
      for (final id in queue.replyTargetById.keys)
        if (draftIdByThread[queue.replyTargetById[id]!.threadId] case final draftId?) draftId,
    };
    if (dryRun(switch (mode) {
      _ReplyMode.undraft => 'skasuje ${plural(queuedDrafts.length, 'szkic', 'szkice', 'szkiców')}',
      _ReplyMode.draft => 'przygotuje ${plural(mails, 'szkic', 'szkice', 'szkiców')}',
      _ReplyMode.send => 'wyśle ${plural(mails, 'mejl', 'mejle', 'mejli')}',
    })) {
      return 0;
    }

    await mailbox.ensureToolLabels();
    final run = ReplyRun(
      mailbox: mailbox,
      queue: queue,
      plans: plans,
      draftIdByThread: draftIdByThread,
    );
    switch (mode) {
      case _ReplyMode.undraft:
        await run.undraftAll(queuedDrafts);
      case _ReplyMode.draft:
        await run.draftAll();
      case _ReplyMode.send:
        await run.sendAll();
    }
    return 0;
  }
}

// ---------------------------------------------------------------------------
// clean / reopen / explain
// ---------------------------------------------------------------------------

class _CleanCommand extends _PiosenkomatCommand {
  _CleanCommand(super.connect) {
    argParser.addFlag('force', negatable: false, help: 'Skasuj mimo niedokończonych spraw');
    addGmailOptions();
    addPushFlag('Skasuj katalog (bez tej flagi tylko lista)');
  }

  @override
  final name = 'clean';
  @override
  final description = 'Kasuje katalog przebiegu, gdy nic już na niego nie czeka — sprawdza '
      'w Gmailu, czy werdykty, odpowiedzi i kolejka starej apki są domknięte. '
      'Runda, która do Gmaila nie trafiła, leci od razu, a Twoja robota z przeglądu — '
      'tylko z --force.';
  @override
  int? get maxRest => 1;

  /// Katalog nie jest śmieciem od razu po wgraniu piosenek. Zanim zniknie,
  /// muszą się domknąć trzy rzeczy — to, co zbiera [pendingLabelsOf]:
  /// werdykty (plan dla `label added` / `label reviewed`), odpowiedzi do
  /// autorów (teksty w `decisions.json`) i kolejka starej apki.
  @override
  Future<int> execute() async {
    final force = args['force'] as bool;
    final runDir = this.runDir();
    final plan = runDir.readRunPlan();

    final mailbox = await connect();
    final labelsByMessage = await mailbox.songLabelsByMessage();
    final pendingByMessage = {
      for (final id in plan.labelsByMessage.keys)
        if (pendingLabelsOf(labelsByMessage[id] ?? const {}) case final pending
            when pending.isNotEmpty)
          id: pending,
    };

    final files = Directory(runDir.path).listSync().length;
    stdout.writeln('Przebieg ${runDir.path}: '
        '${plural(plan.labelsByMessage.length, 'mejl', 'mejle', 'mejli')}, '
        '${plural(files, 'plik', 'pliki', 'plików')}.');

    if (!isRunInGmail(plan, labelsByMessage)) {
      // Bez etykiet w Gmailu „nic nie wisi” znaczy „nic nie zaczęte”, nie
      // „domknięte” — cały stan rundy jest w tym katalogu.
      final work = runDir.localReviewWork;
      if (work.isEmpty) {
        stdout.writeln('Runda ${runDir.name} nie trafiła do Gmaila, ale poza wynikiem scan '
            'nic w niej nie ma — kolejny scan ją odtworzy.');
      } else {
        stdout
          ..writeln('Runda ${runDir.name} nie jest zakończona — nie trafiła do Gmaila, '
              'jest tylko tutaj.')
          ..writeln('Stracisz bezpowrotnie: ${work.join(', ')}.');
        if (!force) {
          stderr.writeln('Usunąć mimo to: ./piosenkomat clean ${runDir.path} --push --force');
          return 1;
        }
        stdout.writeln('--force: kasuję mimo to.');
      }
    } else if (pendingByMessage.isNotEmpty) {
      stdout.writeln('Niedokończone sprawy na '
          '${plural(pendingByMessage.length, 'mejlu', 'mejlach', 'mejlach')}:');
      countLines(stdout, tally(pendingByMessage.values.expand((l) => l)));
      if (!force) {
        stderr.writeln('Katalog zostaje — bez niego te sprawy się nie domkną '
            '(plan przebiegu, teksty odpowiedzi do autorów). --force, jeśli mimo '
            'to ma zniknąć.');
        return 1;
      }
      stdout.writeln('--force: kasuję mimo to.');
    } else {
      stdout.writeln('Wszystko domknięte — ślad został w Gmailu.');
    }

    if (dryRun('skasuje ${runDir.path}')) return 0;
    Directory(runDir.path).deleteSync(recursive: true);
    stdout.writeln('Skasowano ${runDir.path}.');
    return 0;
  }
}

class _ReopenCommand extends _PiosenkomatCommand {
  _ReopenCommand(super.connect) {
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
    // Piosenka już w apce → nie ma czego przesiewać na nowo. „Dzięki” od
    // autora to nie zgłoszenie, a poprawkę przysyła się z apki, jako nową.
    bool isAdded(ThreadSummary t) => t.messageIds
        .any((id) => (labelsByMessage[id] ?? const {}).contains(SongLabel.added.label));
    final reopened = [for (final t in authorReplied) if (!isAdded(t)) t];
    final addedCount = authorReplied.length - reopened.length;
    final changes = <String, LabelChange>{
      for (final t in reopened)
        for (final id in t.messageIds)
          if (labelsByMessage[id] case final labels? when labels.isNotEmpty)
            id: (const [], labels.toList()),
    };

    if (addedCount > 0) {
      stdout.writeln('Pomijam ${plural(addedCount, 'wątek', 'wątki', 'wątków')} '
          'z „${SongLabel.added.label}” — piosenka już w apce, odpowiedź to nie nowe zgłoszenie.');
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
        'Dalej: ./piosenkomat scan');
    return 0;
  }
}

class _ExplainCommand extends _PiosenkomatCommand {
  _ExplainCommand(super.connect) {
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

String _minute(DateTime d) => d.toLocal().toIso8601String().substring(0, 16);
