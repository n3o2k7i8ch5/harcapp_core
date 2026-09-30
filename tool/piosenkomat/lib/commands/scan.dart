import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';

import '../classify.dart';
import '../hrcpsng.dart';
import '../mailbox.dart';
import '../model.dart';
import '../plan.dart';
import '../report.dart';
import '../reply.dart';
import '../run_dir.dart';
import 'command.dart';

class ScanCommand extends PiosenkomatCommand {
  ScanCommand(super.connectMailbox, super.root) {
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
        throw Stop('Otwarty przebieg ${plan.id} — najpierw go domknij. Co czeka: ./piosenkomat status');
      }
      if (!push) throw Stop(interruptedMessage(plan));
      stdout.writeln('Dokańczam przerwany scan --push przebiegu ${plan.id}.');
      return _push(await connect(), run, plan);
    }

    final limit = this.limit();
    final book = loadSongBook();
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    // Przebieg otwarty gdzie indziej — inny komputer albo skasowany katalog.
    // Gmail to jedyny wspólny stan, więc to on rozstrzyga.
    final open = openVerdicts(current);
    if (open.isNotEmpty) throw Stop(openElsewhereMessage(open.length));

    final messages = await _fetchQueue(mailbox, current, limit: limit);
    if (messages.isEmpty) {
      stdout.writeln('Nic do przesiania.');
      return 0;
    }
    // Nasze wysłane z tych wątków: czy blok o starej apce już w wątku poszedł
    // i — do rozmowy w edytorze — co autorowi napisaliśmy. W kolejce ich nie
    // ma (leżą w `SENT`), a bez nich po `reopen` widać odpowiedź autora bez
    // pytania.
    final sentByThread = await mailbox.sentIdsByThread();
    final threads = {for (final m in messages) m.threadId};
    final ours = await mailbox.getMessages([
      for (final t in threads) ...?sentByThread[t],
    ]);

    final id = newRunId(DateTime.now());
    final classified = classifyBatch([...messages, ...ours], book: book, run: id);
    final report = formatRunReport(classified);
    stdout
      ..writeln()
      ..write(report);
    if (dryRun('otworzy przebieg: etykiety, szkice z blokiem o starej apce i ${run.path}')) return 0;

    assignUniqueIds([for (final c in classified) if (c.goesToFile) c.song!]);
    final plan = RunPlan.fromClassified(classified, id: id);
    _writeRun(run, plan, classified, report);
    return _push(mailbox, run, plan);
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
        (id: id, threadId: mailbox.threadOf(id)),
    ];
    // Odpowiedzi w wątkach z `song/*` odsiewamy przed pobieraniem treści —
    // i przed `-n`, żeby limit liczył prawdziwe zgłoszenia.
    final labeledThreads = {for (final id in current.keys) mailbox.threadOf(id)};
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
      stdout.writeln('Pominięto ${emailCount(inTagged)} w wątkach, '
          'które mają już etykietę song/* — to odpowiedzi po zgłoszeniu, nie zgłoszenia.');
    }
    stdout.writeln('Kolejka ($scope): ${emailCount(ids.length)} '
        'w ${plural(threadCount, 'wątku', 'wątkach', 'wątkach')}, pobieram…');
    final fetched = await mailbox.getMessages(ids, onProgress: (done, total) {
      if (done % 50 == 0 || done == total) stdout.writeln('  $done/$total');
    });
    final unreadable = fetched.where((m) => m.readError != null).length;
    if (unreadable > 0) {
      stdout.writeln('${emailCount(unreadable)} nie do rozebrania — '
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
      stdout.writeln('Pominięto ${emailCount(skipped)} '
          '(już otagowane albo nie o piosence), zostają bez zmian.');
    }
    return queue.songs;
  }
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
    stdout.writeln('\n${kind.groupName}: ${plural(items.length, 'piosenka', 'piosenki', 'piosenek')} '
        '→ ${run.candidates(kind)} ($clean bez zarzutu, ${items.length - clean} z uwagami)');
  }
  Directory(staging.path).renameSync(run.path);
}

/// Druga połowa `scan --push`, którą da się powtórzyć: etykiety z planu
/// (mejle, które mają już `song/*`, zostają jak są), szkice z blokiem o starej
/// apce, znacznik „w Gmailu” w planie. Etykiety bierze świeże, tuż przed
/// nadaniem: pobieranie kolejki trwa, a w tym czasie mogłeś coś otagować.
Future<int> _push(Mailbox mailbox, RunDir run, RunPlan plan) async {
  final current = await mailbox.songLabelsByMessage();
  final changes = {
    for (final e in plan.labelsByMessage.entries)
      if (!current.containsKey(e.key)) e.key: withReadOnClose((e.value, const [])),
  };
  await mailbox.ensureToolLabels();
  await applyLabelChanges(mailbox, changes);
  stdout.writeln('\nNadano:');
  countLines(stdout, tally(changes.values.expand((c) => c.$1)));
  final skipped = plan.labelsByMessage.length - changes.length;
  if (skipped > 0) {
    stdout.writeln('Pominięto ${emailCount(skipped)}, '
        'które w międzyczasie dostały etykietę song/*.');
  }
  final written = run.readDrafts();
  await syncDrafts(mailbox, replyThreadsOf(plan, labelsAfter(current, changes)), push: true, written: written);
  run.writeDrafts(written);
  writePlan(run.plan, plan.pushed(DateTime.now()));

  stdout.writeln('\nPrzebieg ${plan.id} otwarty: ${run.path}');
  stdout.writeln(run.kinds.isEmpty
      ? 'Nic nie poszło do przeglądu — domknij od razu: ./piosenkomat finalize --push'
      : 'Wczytuj jeden plik naraz na stronie ze śpiewnikiem, eksport zapisz w reviewed-*.hrcpsng, '
          'potem: ./piosenkomat review --push');
  return 0;
}
