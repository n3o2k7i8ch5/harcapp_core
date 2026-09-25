import 'dart:io';

import 'package:args/args.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:path/path.dart' as p;

import 'classify.dart';
import 'gmail.dart';
import 'hrcpsng.dart';
import 'model.dart';
import 'people.dart';
import 'plan.dart';
import 'report.dart';
import 'review.dart';
import 'similarity.dart';

Future<int> runPiosenkomat(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Pomoc');

  // `scan` do Gmaila nie pisze, więc jako jedyna komenda nie ma `--push`.
  final scan = parser.addCommand('scan');
  _scanOptions(scan);
  _addCommon(scan);

  final label = parser.addCommand('label');
  final labelScanned = label.addCommand('scanned');
  _addCommon(labelScanned);
  _addPushFlag(labelScanned, help: 'Nadaj etykiety (bez tej flagi tylko lista)');

  final labelReviewed = label.addCommand('reviewed');
  _reviewedOptions(labelReviewed);
  _addCommon(labelReviewed);
  _addPushFlag(labelReviewed,
      help: 'Zmień etykiety odrzuconych (bez tej flagi tylko lista)');

  final labelAdded = label.addCommand('added');
  _addAllFlag(labelAdded);
  _addCommon(labelAdded);
  _addPushFlag(labelAdded, help: 'Zmień etykiety w Gmailu (bez tej flagi lista)');

  final unlabel = parser.addCommand('unlabel');
  _unlabelOptions(unlabel);
  _addAllFlag(unlabel);
  _addCommon(unlabel);
  _addPushFlag(unlabel, help: 'Zdejmij etykiety (bez tej flagi tylko lista)');

  final reply = parser.addCommand('reply');
  _replyOptions(reply);
  _addCommon(reply);
  _addPushFlag(reply, help: 'Wyślij (bez tej flagi tylko lista)');

  final reopen = parser.addCommand('reopen');
  reopen.addOption('query', help: 'Własne query Gmaila zamiast czekających na autora');
  _addCommon(reopen);
  _addPushFlag(reopen, help: 'Zdejmij etykiety (bez tej flagi tylko lista)');

  final clean = parser.addCommand('clean');
  clean.addFlag('force',
      negatable: false, help: 'Skasuj mimo niedokończonych spraw');
  _addCommon(clean);
  _addPushFlag(clean, help: 'Skasuj katalog (bez tej flagi tylko lista)');

  final explain = parser.addCommand('explain');
  _addCommon(explain);

  final prepare = parser.addCommand('prepare');
  _addCommon(prepare);

  ArgResults opts;
  try {
    opts = parser.parse(args);
  } on FormatException catch (e) {
    stderr.writeln(e.message);
    stderr.writeln(_usage(parser));
    return 64;
  }
  var cmd = opts.command;
  if (opts['help'] as bool || cmd == null) {
    // Słowo, którego parser nie zna: powiedz to wprost, zamiast pokazywać
    // samą pomoc i kazać się domyślać.
    if (cmd == null && opts.rest.isNotEmpty) {
      stderr.writeln('Nie ma komendy „${opts.rest.first}”.');
    }
    stdout.writeln(_usage(parser));
    return cmd == null && !(opts['help'] as bool) ? 64 : 0;
  }

  var name = cmd.name;
  if (name == 'label') {
    final stage = cmd.command;
    if (stage == null) {
      stderr.writeln('Podaj etap: ./piosenkomat label scanned|reviewed|added');
      stderr.writeln(_usage(parser));
      return 64;
    }
    cmd = stage;
    name = 'label ${stage.name}';
  }

  try {
    switch (name) {
      case 'scan':
        return await _scan(cmd);
      case 'label scanned':
        return await _labelScanned(cmd);
      case 'label reviewed':
        return await _labelReviewed(cmd);
      case 'label added':
        return await _labelAdded(cmd);
      case 'unlabel':
        return await _unlabel(cmd);
      case 'reply':
        return await _reply(cmd);
      case 'reopen':
        return await _reopen(cmd);
      case 'clean':
        return await _clean(cmd);
      case 'explain':
        return _explain(cmd);
      case 'prepare':
        return _prepare(cmd);
    }
    return 64;
  } on FileSystemException catch (e) {
    stderr.writeln('${e.message}: ${e.path}');
    return 1;
  } on _UsageError catch (e) {
    stderr.writeln(e.message);
    return 64;
  }
}

/// Zły argument: komunikat i kod 64, jak przy błędzie parsera.
class _UsageError implements Exception {
  final String message;
  const _UsageError(this.message);
}

// ---------------------------------------------------------------------------
// Opcje
// ---------------------------------------------------------------------------

void _scanOptions(ArgParser p) => p
  ..addOption('limit',
      abbr: 'n', help: 'Ile mejli z kolejki (domyślnie wszystkie)')
  ..addFlag('newest',
      negatable: false, help: 'Najnowsze N zamiast najstarszych')
  ..addOption('out',
      abbr: 'o', help: 'Katalog przebiegu (domyślnie out/import-<data>)')
  ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');

void _reviewedOptions(ArgParser p) => p.addFlag('force',
    negatable: false,
    help: 'Pomiń bezpieczniki (pusty plik, odrzucona większość)');

void _unlabelOptions(ArgParser p) => p.addFlag('force',
    negatable: false,
    help: 'Zdejmij też z domkniętych („$kLabelAdded”)');

void _replyOptions(ArgParser p) => p
  ..addOption('limit', abbr: 'n', help: 'Ilu autorom odpisać w tym przebiegu')
  ..addOption('query', help: 'Własne query Gmaila zamiast kolejki odpowiedzi')
  ..addFlag('draft',
      negatable: false,
      help: 'Przygotuj szkice zamiast wysyłać; wyśle je późniejszy `reply --push`')
  ..addFlag('undraft',
      negatable: false, help: 'Skasuj szkice przygotowane przez --draft')
  ..addFlag('all',
      negatable: false,
      help: 'Cała stojąca kolejka, nie tylko autorzy z przebiegu');

/// Bez katalogu komendy biorą ostatni przebieg; `--all` — całą skrzynkę.
void _addAllFlag(ArgParser p) => p.addFlag('all',
    negatable: false, help: 'Cała skrzynka, nie tylko przebieg');

/// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
/// „wypchnij to, co widzisz na sucho, do skrzynki”.
void _addPushFlag(ArgParser p, {String? help}) =>
    p.addFlag('push', abbr: 'p', negatable: false, help: help);

bool _isPush(ArgResults cmd) => cmd['push'] as bool;

/// Bez `--push` komenda kończy na liście: mówi, co zrobiłoby `--push`.
/// `true` = to był dry-run, dalej nie idziemy.
bool _dryRun(ArgResults cmd, String whatPushDoes) {
  if (_isPush(cmd)) return false;
  stdout.writeln('\nDry-run: nic nie zmieniono. --push $whatPushDoes.');
  return true;
}

void _addCommon(ArgParser p) => p
  ..addOption('songs-db', help: 'Ścieżka do all_songs.hrcpsng')
  ..addOption('credentials', help: 'Domyślnie secrets/credentials.json')
  ..addOption('token', help: 'Domyślnie secrets/gmail_token.json');

/// `-n`: liczba dodatnia albo brak.
int? _limit(ArgResults cmd) {
  final raw = cmd['limit'] as String?;
  if (raw == null) return null;
  final limit = int.tryParse(raw);
  if (limit == null || limit <= 0) {
    throw const _UsageError('--limit wymaga liczby dodatniej.');
  }
  return limit;
}

// ---------------------------------------------------------------------------
// scan
// ---------------------------------------------------------------------------

Future<int> _scan(ArgResults cmd) async {
  final newest = cmd['newest'] as bool;
  final limit = _limit(cmd);

  final book = _loadBook(cmd);
  final mailbox = await _connect(cmd);
  final query = cmd['query'] as String? ?? kQueueQuery;

  final ids = await mailbox.listIds(query, limit: limit, newest: newest);
  final scope = limit == null
      ? 'cała kolejka'
      : '${newest ? 'najnowsze' : 'najstarsze'} $limit';
  stdout.writeln('Kolejka ($scope): ${plural(ids.length, 'mejl', 'mejle', 'mejli')}, pobieram…');
  final fetched = await mailbox.getMessages(ids, onProgress: (done, total) {
    if (done % 50 == 0 || done == total) stdout.writeln('  $done/$total');
  });
  final queue = partitionQueue(fetched);
  if (queue.web > 0) {
    stdout.writeln('Odsiano ${plural(queue.web, 'zgłoszenie', 'zgłoszenia', 'zgłoszeń')} '
        'ze strony — piosenkomat obsługuje wyłącznie zgłoszenia wysłane z apki. '
        'Te ogarnij ręcznie.');
  }
  final (messages, weRepliedThreads) = await _unlabeledThreads(mailbox, queue.songs);
  final skipped = fetched.length - messages.length - queue.web;
  if (skipped > 0) {
    stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')} '
        '(już otagowane, w otagowanym wątku albo nie o piosence), zostają bez zmian.');
  }

  final runDir = cmd['out'] as String? ?? defaultRunDir();
  final classified = classifyBatch(messages,
      book: book, weRepliedThreads: weRepliedThreads, run: p.basename(runDir));
  final report = formatRunReport(classified);
  stdout
    ..writeln()
    ..write(report);
  _writeRunFiles(runDir, classified, report);

  stdout.writeln('Gmail nietknięty — `scan` tylko czyta. Etykiety jak '
      'w raporcie nada: ./piosenkomat label scanned $runDir --push');
  return 0;
}

/// Kolejka jest po wątkach: odpowiedź w wątku, który już dostał `song/*`,
/// to nie nowe zgłoszenie. Query tego nie umie (działa na wiadomościach),
/// więc dociągamy wątek — jedno zapytanie na wątek. Przy okazji zbieramy
/// wątki, których autor dostał już od nas odpowiedź.
Future<(List<ContribMessage>, Set<String>)> _unlabeledThreads(
  GmailMailbox mailbox,
  List<ContribMessage> messages,
) async {
  final labeledThreads = <String>{};
  final weRepliedThreads = <String>{};
  for (final t in {for (final m in messages) m.threadId}) {
    final labels = await mailbox.labelsOfThread(t);
    if (labels.any(isSongLabel)) labeledThreads.add(t);
    // Np. wątek cofnięty przez `reopen`.
    if (labels.contains('SENT')) weRepliedThreads.add(t);
  }
  final unlabeled = [for (final m in messages) if (!labeledThreads.contains(m.threadId)) m];

  // Stara apka: blok „zaktualizuj apkę” idzie raz na autora, nie na wątek —
  // `reply` odpisuje w jego najnowszym wątku, więc w starszych `SENT` nie ma.
  // Pytamy więc o nadawcę: jedno tanie zapytanie na autora ze starej apki.
  final oldAppSenders = {
    for (final m in unlabeled)
      if (m.body.contains(kOldAppMarker))
        if (emailFromHeader(m.from) case final sender?) sender,
  };
  final weRepliedSenders = {
    for (final sender in oldAppSenders)
      if ((await mailbox.listIds('in:sent to:$sender', limit: 1, newest: true))
          .isNotEmpty)
        sender,
  };
  for (final m in unlabeled) {
    if (weRepliedSenders.contains(emailFromHeader(m.from))) {
      weRepliedThreads.add(m.threadId);
    }
  }
  return (unlabeled, weRepliedThreads);
}

/// Katalog przebiegu: raport, plan przebiegu i po dwa pliki na rodzaj —
/// kandydaci i ich kopia na eksport po przeglądzie.
void _writeRunFiles(String runDir, List<Classified> classified, String report) {
  final reportPath = reportPathIn(runDir);
  writeText(reportPath, report);

  assignUniqueIds([for (final c in classified) if (c.goesToFile) c.song!]);
  final planPath = planPathIn(runDir);
  writePlan(planPath, RunPlan.fromClassified(classified));

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
    final path = candidatesPathIn(runDir, kind);
    writeHrcpsng(path, songs, withPiosenkomatData: true);
    final clean = items.where((c) => c.issues.isEmpty).length;
    stdout.writeln('\n${_kindName(kind)}: ${plural(songs.length, 'piosenka', 'piosenki', 'piosenek')} '
        '→ $path ($clean bez zarzutu, ${songs.length - clean} z uwagami)');
    // Miejsce na eksport: wrzucasz tu plik ze strony, a `label reviewed`
    // z różnicy wyciąga odrzucone.
    final reviewedPath = reviewedPathIn(runDir, kind);
    writeHrcpsng(reviewedPath, songs, withPiosenkomatData: true);
    stdout.writeln('  po przeglądzie podmień $reviewedPath eksportem ze strony');
  }

  stdout.writeln(anyWritten
      ? 'Wczytuj jeden plik naraz na stronie ze śpiewnikiem; '
          'potem: ./piosenkomat label reviewed $runDir'
      : '\nNic nie poszło do plików.');
  stdout
    ..writeln('Katalog: $runDir')
    ..writeln('Raport: $reportPath')
    ..writeln('Plan przebiegu: $planPath');
}

// ---------------------------------------------------------------------------
// label scanned / unlabel / label added
// ---------------------------------------------------------------------------

/// `label scanned [katalog] [--push]`: etykiety z planu zapisanego przez
/// `scan`, bez ponownego czytania treści. Mejle, które w międzyczasie dostały
/// już etykietę song/*, są pomijane.
Future<int> _labelScanned(ArgResults cmd) async {
  final plan = readPlan(planPathIn(_runDir(cmd)));
  stdout.writeln(_planHeader(plan));
  countLines(stdout, tally(plan.labelsByMessage.values.expand((l) => l)));
  if (_dryRun(cmd, 'nada powyższe')) return 0;

  final mailbox = await _connect(cmd);
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
  stdout.writeln('Po przeglądzie na stronie podmień reviewed-*.hrcpsng, potem '
      './piosenkomat label reviewed --push i ./piosenkomat label added --push');
  return 0;
}

/// `unlabel [katalog|--all] [--push]`: cofa to, co nadał automat — z mejli
/// przebiegu, a z `--all` z całej skrzynki. Reguły w [unlabelChanges].
Future<int> _unlabel(ArgResults cmd) async {
  final plan = _planUnlessAll(cmd);
  final mailbox = await _connect(cmd);
  stdout.writeln('Sprawdzam etykiety w skrzynce…');
  final result = unlabelChanges(await mailbox.songLabelsByMessage(),
      plan: plan, force: cmd['force'] as bool);

  if (result.toRemove.isEmpty) {
    stdout.writeln('Nic do zdjęcia — po automacie nie został ślad.');
    return 0;
  }
  stdout.writeln('Do zdjęcia z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}:');
  countLines(stdout, tally(result.toRemove.values.expand((l) => l)));
  if (result.outsidePlan > 0) {
    stdout.writeln('Poza tym przebiegiem '
        '${plural(result.outsidePlan, 'mejl ma', 'mejle mają', 'mejli ma')} znacznik '
        '„$kLabelAuto”. Zejdą z `unlabel --all`.');
  }
  if (result.added > 0) {
    stdout.writeln('Pomijam ${plural(result.added, 'domknięty', 'domknięte', 'domkniętych')} '
        '(„$kLabelAdded”) — te piosenki są już w apce; --force, jeśli mimo to '
        'mają zejść.');
  }
  if (_dryRun(cmd, 'zdejmie powyższe')) return 0;

  await _applyChanges(mailbox, {
    for (final e in result.toRemove.entries) e.key: (const [], e.value),
  });
  stdout.writeln('Zdjęto z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}. '
      'Wracają do kolejki, więc `scan` weźmie je ponownie.');
  return 0;
}

/// `label added [katalog|--all] [--push]`: [kLabelReadyToAdd] od automatu
/// → [kLabelAdded]. Domyślnie przebieg: „domknij to, co z TEGO przebiegu
/// wkleiłeś do śpiewnika” — mejle z innego, jeszcze niewklejonego, mają
/// zostać otwarte.
Future<int> _labelAdded(ArgResults cmd) async {
  final plan = _planUnlessAll(cmd);
  final mailbox = await _connect(cmd);
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
  stdout.writeln('„$kLabelReadyToAdd” + „$kLabelAuto”: '
      '${plural(ready.length, 'mejl', 'mejle', 'mejli')}');
  if (readyOutsideRun > 0) {
    stdout.writeln('  $readyOutsideRun czeka poza tym przebiegiem — domknij je '
        'jego własnym `label added` (albo `--all`, gdy masz wklejone wszystkie).');
  }
  if (_dryRun(cmd, 'zmieni na „$kLabelAdded” + przeczytane')) return 0;

  await mailbox.ensureToolLabels();
  await _applyChanges(mailbox, {
    for (final id in ready)
      id: (
        [kLabelAdded],
        [
          kLabelReadyToAdd,
          // Przeczytane tylko tam, gdzie nic już nie wisi: mejl z tekstem do
          // autora czeka jeszcze na wysyłkę, więc zostaje nieprzeczytany.
          if (!(current[id] ?? const {}).contains(kLabelReplyReviewNote)) 'UNREAD',
        ],
      ),
  });
  stdout.writeln('Zatwierdzono ${plural(ready.length, 'mejl', 'mejle', 'mejli')}.');
  return 0;
}

/// Plan przebiegu z argumentu (albo ostatniego) — chyba że `--all`, wtedy
/// cała skrzynka i planu nie ma.
RunPlan? _planUnlessAll(ArgResults cmd) {
  if (cmd['all'] as bool) return null;
  final plan = readPlan(planPathIn(_runDir(cmd)));
  stdout.writeln(_planHeader(plan));
  return plan;
}

String _planHeader(RunPlan plan) => 'Plan z ${_minute(plan.createdAt)}: '
    '${plural(plan.labelsByMessage.length, 'mejl', 'mejle', 'mejli')}';

/// Mejle o tej samej zmianie idą jedną paczką: `batchModify` bierze do 1000
/// naraz, więc przebieg to kilkanaście strzałów, nie kilkaset.
Future<void> _applyChanges(
  GmailMailbox mailbox,
  Map<String, LabelChange> changes,
) async {
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

// ---------------------------------------------------------------------------
// label reviewed / prepare
// ---------------------------------------------------------------------------

/// `label reviewed [katalog] [--push]`: różnica między tym, co automat
/// wstawił do plików kandydatów, a tym, co wróciło po Twoim przeglądzie.
///
/// Dwa stany, po id wątku: piosenka **jest** w `reviewed-*` →
/// [kLabelReadyToAdd], **nie ma** → [kLabelRejectedAfterReview]. Uwagi
/// w piosence nie mają znaczenia — pastylki są dla Ciebie, nie dla narzędzia.
/// Osobno dla nowych i dla poprawek.
///
/// Z kandydatów można wywalać i edytować, nie dodawać: obcy wątek, zły
/// rodzaj w pliku albo dwie poprawki tej samej piosenki → STOP, bez `--force`.
Future<int> _labelReviewed(ArgResults cmd) async {
  final runDir = _runDir(cmd);
  final force = cmd['force'] as bool;
  final plan = readPlan(planPathIn(runDir));

  final results = <ReviewResult>[];
  for (final kind in SubmissionKind.values) {
    final candidates = collectCandidates(plan, _candidatesOf(runDir, kind), kind);
    if (candidates.isEmpty) continue;
    final reviewedPath = reviewedPathIn(runDir, kind);
    if (!_exists(reviewedPath)) {
      stdout.writeln('${_kindName(kind)}: nie ma $reviewedPath — pomijam.');
      continue;
    }
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
  final decisionsPath = decisionsPathIn(runDir);
  writeDecisions(decisionsPath, results);
  stdout.writeln('Ślad przeglądu: $decisionsPath');

  final changes = reviewLabelChanges(results, plan);
  if (changes.isEmpty) {
    stdout.writeln('\nNic do przestawienia. Dalej: ./piosenkomat label added --push');
    return 0;
  }
  if (_dryRun(cmd, 'przestawi etykiety na '
      '${plural(changes.length, 'mejlu', 'mejlach', 'mejlach')}')) {
    return 0;
  }

  final mailbox = await _connect(cmd);
  await mailbox.ensureToolLabels();
  // Bezpiecznik jak w `label added`: ruszamy tylko to, co automat sam
  // wstawił do plików przebiegu i co dalej tam czeka.
  final current = await mailbox.songLabelsByMessage();
  final applicable = <String, LabelChange>{
    for (final e in changes.entries)
      if (current[e.key] case final labels? when isInRunFilesByTool(labels))
        e.key: withReadOnClose(
            (e.value.$1, [for (final l in e.value.$2) if (labels.contains(l)) l])),
  };
  await _applyChanges(mailbox, applicable);
  stdout.writeln('Przestawiono etykiety na '
      '${plural(applicable.length, 'mejlu', 'mejlach', 'mejlach')}.');
  final skipped = changes.length - applicable.length;
  if (skipped > 0) {
    stdout.writeln('Pominięto ${plural(skipped, 'mejl', 'mejle', 'mejli')} '
        'spoza plików tego przebiegu.');
  }
  stdout.writeln('Dalej: ./piosenkomat label added --push');
  return 0;
}

String _kindName(SubmissionKind k) =>
    k == SubmissionKind.correction ? 'Poprawki' : 'Nowe';

/// Kandydaci danego rodzaju z katalogu przebiegu.
List<SongRaw> _candidatesOf(String runDir, SubmissionKind kind) {
  final path = candidatesPathIn(runDir, kind);
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

/// `prepare [katalog]`: składa z przeglądu materiał dla repo. Zdejmuje ślad
/// piosenkomatu z plików zwrotnych → `final-*.hrcpsng`, gotowe do wklejenia
/// w `all_songs`. Przy poprawkach `id = correction_target`, żeby apka nie
/// zgubiła powiązań użytkowników. Nie patrzy na uwagi — przegląd był Twój.
///
/// Tu też powstaje `people.dart`: dopiero teraz wiadomo, które piosenki
/// naprawdę wchodzą, a osoby czyta z nich samych, więc łapią się Twoje
/// poprawki kart z przeglądu.
///
/// Jedyna komenda, która niczego nie rusza w Gmailu — i nie ostatnia
/// w przebiegu, bo po niej idzie jeszcze `label added` i odpowiedzi.
int _prepare(ArgResults cmd) {
  final runDir = _runDir(cmd);
  final otherEmails = _otherEmailsFromPlan(runDir);
  var anyReviewed = false;
  final sources = <ContributorSource>[];
  for (final kind in SubmissionKind.values) {
    final reviewedPath = reviewedPathIn(runDir, kind);
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
    final out = finalPathIn(runDir, kind);
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
    stderr.writeln('Brak plików zwrotnych w $runDir.');
    return 1;
  }
  _writePeople(runDir, collectPeople(sources));
  return 0;
}

/// Dodatkowe adresy z bloku „Osoba dodająca” trzyma plan przebiegu —
/// piosenka niesie tylko `email_ref`.
Map<String, List<String>> _otherEmailsFromPlan(String runDir) {
  final planPath = planPathIn(runDir);
  if (!_exists(planPath)) return const {};
  try {
    return otherEmailsBySender(readPlan(planPath));
  } on FormatException {
    stdout.writeln('Plan $planPath nie do odczytania — '
        'w people.dart same adresy nadawców.');
    return const {};
  }
}

void _writePeople(String runDir, PeopleReport people) {
  final peoplePath = peoplePathIn(runDir);
  writePeopleDart(peoplePath, people);
  stdout.writeln('Osoby dodające: ${people.newContributors.length} nowych → $peoplePath'
      '${people.knownByEmail.isEmpty ? '' : ', ${people.knownByEmail.length} już w data.dart'}'
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

/// `reply [--draft|--undraft] [--push]`: odpowiedzi do autorów — blok
/// „zaktualizuj apkę” i Twoje teksty z przeglądu, razem w jednym mejlu.
///
/// Kolejką jest sam Gmail: etykiety [kLabelReplyOldApp] (wiesza
/// `label scanned`) i [kLabelReplyReviewNote] (wiesza `label reviewed`).
/// Wysyłka je zdejmuje, więc nikt nie dostanie dwóch odpowiedzi, a przerwany
/// przebieg dokańcza się zwykłym powtórzeniem komendy.
///
/// Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek ze starej
/// apki, dostaje jeden mejl w najnowszym wątku, a etykieta schodzi ze wszystkich.
///
/// `--draft` rozrywa to na dwa kroki: najpierw szkic w wątku (etykiety
/// zostają — nikt nic nie dostał). Późniejszy `reply --push` wysyła gotowy
/// szkic zamiast składać mejl od nowa, więc Twoje poprawki idą w świat. Który
/// autor ma szkic, mówi sam Gmail. Szkic skasowany albo wysłany ręcznie
/// z Gmaila: jeśli ostatnia w wątku jest nasza wysłana wiadomość, uznajemy za
/// odpisane i tylko przestawiamy etykiety; jeśli nie — składamy mejl normalnie.
Future<int> _reply(ArgResults cmd) async {
  final draft = cmd['draft'] as bool;
  final undraft = cmd['undraft'] as bool;
  if (draft && undraft) {
    throw const _UsageError('--draft i --undraft naraz nie mają sensu.');
  }
  final mode = undraft
      ? _ReplyMode.undraft
      : draft
          ? _ReplyMode.draft
          : _ReplyMode.send;
  final limit = _limit(cmd);

  // Zakres: domyślnie autorzy z przebiegu, bo odpisuje się po imporcie.
  // Zaległa kolejka spoza niego siedzi w skrzynce i czeka na `--all`.
  final wholeQueue = (cmd['all'] as bool) || cmd['query'] != null;
  final runDir = wholeQueue ? null : _runDir(cmd);
  final plan = runDir == null ? null : readPlan(planPathIn(runDir));
  // Etykieta dalej mówi, komu nie odpisano; przebieg tylko zawęża do tych,
  // których sam przyniósł. Przecięcie, nie zastąpienie.
  bool inScope(String id) => plan == null || plan.labelsByMessage.containsKey(id);

  // Szkic i jego kasowanie potrzebują tylko `modify`; `send` dopiero wysyłka.
  final mailbox = await _connect(cmd, needsSend: mode == _ReplyMode.send);
  // Dwie kolejki, jeden mejl: blok o starej apce i uwagi z przeglądu trafiają
  // do tego samego autora razem, więc bierzemy obie naraz.
  final query = cmd['query'] as String? ??
      '(label:${labelQueryName(kLabelReplyOldApp)} '
          'OR label:${labelQueryName(kLabelReplyReviewNote)})';
  var ids = await mailbox.listIds(query);
  final draftIdByThread = await mailbox.draftIdByThread();
  if (mode == _ReplyMode.undraft) {
    // Tylko wątki, w których szkic faktycznie czeka.
    ids = [for (final id in ids) if (draftIdByThread.containsKey(mailbox.knownThreadOf(id))) id];
  }
  if (plan != null) {
    final before = ids.length;
    ids = ids.where(inScope).toList();
    stdout.writeln('Zakres: przebieg $runDir '
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

  final queue = await _groupBySender(mailbox, ids, query: query, limit: limit, inScope: inScope);
  _printReplyQueue(queue);
  final authors = queue.bySender.length;
  if (_dryRun(cmd, switch (mode) {
    _ReplyMode.undraft => 'skasuje ${plural(authors, 'szkic', 'szkice', 'szkiców')}',
    _ReplyMode.draft => 'przygotuje ${plural(authors, 'szkic', 'szkice', 'szkiców')}',
    _ReplyMode.send => 'wyśle ${plural(authors, 'mejl', 'mejle', 'mejli')}',
  })) {
    return 0;
  }

  await mailbox.ensureToolLabels();
  final run = _ReplyRun(
    mailbox: mailbox,
    queue: queue,
    // Teksty z pola „Odpowiedź do autora”: ze śladu przeglądu, bo `prepare`
    // zdejmuje je z piosenek na długo przed `reply`.
    reviewNotes: {
      for (final dir in runDir != null ? [runDir] : allRunDirs())
        ...readReviewNotes(decisionsPathIn(dir)),
    },
    // Kto jest ze starej apki — po tym wiadomo, czy doklejać jej blok.
    oldAppIds: (await mailbox.listIds('label:${labelQueryName(kLabelReplyOldApp)}')).toSet(),
    draftIdByThread: draftIdByThread,
  );
  switch (mode) {
    case _ReplyMode.undraft:
      await run.undraftAll();
    case _ReplyMode.draft:
      await run.draftAll();
    case _ReplyMode.send:
      await run.sendAll();
  }
  return 0;
}

/// Kolejka `reply` pogrupowana po autorze.
class _ReplyQueue {
  /// Mejle każdego autora, od najstarszego — odpisujemy w ostatnim.
  final Map<String, List<String>> bySender;
  final Map<String, ReplyTarget> replyTargetById;
  final int unknownSenderCount;
  /// `-n` uciął kolejkę: czekają kolejni autorzy.
  final bool truncated;

  const _ReplyQueue(this.bySender, this.replyTargetById,
      {required this.unknownSenderCount, required this.truncated});

  List<String> get senders => bySender.keys.toList()..sort();
}

/// Nadawcy nie da się poznać bez nagłówka, a ten kosztuje 20 jednostek, więc
/// przy `-n` przestajemy czytać, gdy mamy już tylu autorów, ilu obsłużymy.
Future<_ReplyQueue> _groupBySender(
  GmailMailbox mailbox,
  List<String> ids, {
  required String query,
  required int? limit,
  required bool Function(String) inScope,
}) async {
  final bySender = <String, List<String>>{};
  final replyTargetById = <String, ReplyTarget>{};
  var unknownSenderCount = 0;
  var truncated = false;
  for (final id in ids) {
    if (limit != null && bySender.length >= limit) {
      truncated = true;
      break;
    }
    final target = await mailbox.replyTarget(id);
    replyTargetById[id] = target;
    final sender = emailFromHeader(target.to);
    if (sender == null || sender == kInboxEmail) {
      unknownSenderCount++;
      continue;
    }
    bySender.putIfAbsent(sender, () => []).add(id);
  }
  // Urwany przegląd zna tylko część mejli wybranych autorów, a etykieta musi
  // zejść ze wszystkich. Reszta to jedno zapytanie na autora zamiast czytania
  // nagłówków całej kolejki.
  if (truncated) {
    for (final sender in bySender.keys.toList()) {
      // Nawiasy, bo `--query` z `OR` bez nich łapałby cudze mejle:
      // `a OR b from:x` to dla Gmaila `a OR (b from:x)`. Zakres jak na
      // starcie: bez tego mejl autora z innego przebiegu straciłby etykietę,
      // a uwaga do niego (w cudzym `decisions.json`) nigdy by nie wyszła.
      bySender[sender] = [
        for (final id in await mailbox.listIds('($query) from:$sender'))
          if (inScope(id)) id,
      ];
      for (final id in bySender[sender]!) {
        replyTargetById[id] ??= await mailbox.replyTarget(id);
      }
    }
  }
  return _ReplyQueue(bySender, replyTargetById,
      unknownSenderCount: unknownSenderCount, truncated: truncated);
}

void _printReplyQueue(_ReplyQueue queue) {
  for (final sender in queue.senders) {
    final ids = queue.bySender[sender]!;
    stdout.writeln('  → $sender  ${plural(ids.length, 'mejl', 'mejle', 'mejli')}  '
        'wątek [${ids.last}]');
  }
  if (queue.truncated) {
    stdout.writeln('  (w kolejce czekają kolejni autorzy — `-n` bierze najstarszych)');
  }
  if (queue.unknownSenderCount > 0) {
    stdout.writeln('Pomijam ${plural(queue.unknownSenderCount, 'mejl', 'mejle', 'mejli')} '
        'bez czytelnego nadawcy; etykieta zostaje.');
  }
}

/// Jedno odpalenie `reply --push`: kolejka plus to, z czego składamy mejle.
class _ReplyRun {
  final GmailMailbox mailbox;
  final _ReplyQueue queue;
  /// Id wątku → Twój tekst z przeglądu.
  final Map<String, String> reviewNotes;
  final Set<String> oldAppIds;
  final Map<String, String> draftIdByThread;

  _ReplyRun({
    required this.mailbox,
    required this.queue,
    required this.reviewNotes,
    required this.oldAppIds,
    required this.draftIdByThread,
  });

  ReplyTarget _targetOf(String id) => queue.replyTargetById[id]!;

  /// Mejl dla autora: jego uwagi z przeglądu plus blok o starej apce, jeśli
  /// któreś z jego zgłoszeń z niej przyszło. `null` = nie ma o czym pisać.
  String? replyTextFor(List<String> ids) => composeContribReply(
        reviewNotes: {
          for (final id in ids)
            if (reviewNotes[_targetOf(id).threadId] case final note?) note,
        },
        oldApp: ids.any(oldAppIds.contains),
        // Odpowiedź zaprasza do odpisania, a piosenka dosłana w tym wątku
        // przepada: wątek ma już etykietę.
        oneSongPerMail: true,
      );

  LabelChange labelsAfterReplyTo(List<String> ids) => labelsAfterReply(
      sentReviewNote: ids.any((id) => reviewNotes.containsKey(_targetOf(id).threadId)));

  /// Szkic autora i wątek, w którym czeka. Szukamy we wszystkich jego
  /// wątkach, nie tylko w najnowszym: mejl mógł dojść już po szkicu, a drugi
  /// szkic w innym wątku to dwa mejle do jednej osoby.
  (String, ReplyTarget)? draftOf(List<String> ids) {
    for (final id in ids.reversed) {
      final target = _targetOf(id);
      if (draftIdByThread[target.threadId] case final draftId?) return (draftId, target);
    }
    return null;
  }

  Future<void> undraftAll() async {
    var removed = 0;
    var failed = 0;
    for (final sender in queue.senders) {
      try {
        final found = draftOf(queue.bySender[sender]!);
        if (found == null) continue;
        await mailbox.deleteDraft(found.$1);
      } catch (e) {
        stderr.writeln('  ! $sender: $e');
        failed++;
        continue;
      }
      removed++;
    }
    stdout
      ..writeln(_sentence([
        'Sprzątnięto ${plural(removed, 'szkic', 'szkice', 'szkiców')}',
        if (failed > 0) plural(failed, 'nieudany', 'nieudane', 'nieudanych'),
      ]))
      ..writeln('Nikt nic nie dostał — autorzy zostają w kolejce `reply`.');
  }

  Future<void> draftAll() async {
    var created = 0;
    var updated = 0;
    var unchanged = 0;
    var nothingToSay = 0;
    var failed = 0;
    for (final sender in queue.senders) {
      final ids = queue.bySender[sender]!;
      final text = replyTextFor(ids);
      if (text == null) {
        // Ani starej apki, ani uwagi — nie ma o czym pisać.
        nothingToSay++;
        continue;
      }
      try {
        if (draftOf(ids) case (final draftId, final target)) {
          // Szkic już jest. Doszła kolejna sprawa? Przeliczamy mejl od nowa —
          // ale tylko szkic w naszym kształcie; Twoją ręczną robotę zostawiamy.
          final body = await mailbox.draftBody(draftId);
          switch (draftActionFor(body, text)) {
            case DraftAction.unchanged:
              unchanged++;
            case DraftAction.rewrite:
              // Akapity, których w nowej treści nie będzie, wypisujemy — to
              // Twoja jedyna szansa, żeby zobaczyć, co wypadło.
              final dropped = paragraphsDroppedBy(body!, text);
              await mailbox.updateDraft(draftId, target, text);
              updated++;
              for (final paragraph in dropped) {
                stdout.writeln('  ~ $sender: ze szkicu wypadło: '
                    '„${paragraph.split('\n').first}”');
              }
            case DraftAction.leaveManual:
              stdout.writeln('  ~ $sender: szkic '
                  '${body == null ? 'nieczytelny' : 'ruszony ręcznie'} — zostawiam jak jest');
              unchanged++;
          }
          continue;
        }
        await mailbox.draftReplyTo(_targetOf(ids.last), text);
      } catch (e) {
        // Bez szkicu, więc następny przebieg spróbuje jeszcze raz.
        stderr.writeln('  ! $sender: $e');
        failed++;
        continue;
      }
      created++;
    }
    stdout.writeln(_sentence([
      'Przygotowano ${plural(created, 'szkic', 'szkice', 'szkiców')}',
      if (updated > 0) plural(updated, 'zaktualizowany', 'zaktualizowane', 'zaktualizowanych'),
      if (unchanged > 0) '$unchanged bez zmian',
      if (nothingToSay > 0) '$nothingToSay bez treści (pominięte)',
      if (failed > 0)
        '${plural(failed, 'nieudany', 'nieudane', 'nieudanych')} (zostają w kolejce)',
    ]));
    if (created + updated + unchanged > 0) {
      stdout.writeln('Przejrzyj i popraw w Gmailu, potem: ./piosenkomat reply --push');
    }
  }

  Future<void> sendAll() async {
    var sent = 0;
    var repliedByHand = 0;
    var nothingToSay = 0;
    var failed = 0;
    for (final sender in queue.senders) {
      final ids = queue.bySender[sender]!;
      final latest = _targetOf(ids.last);
      final (add, remove) = labelsAfterReplyTo(ids);
      try {
        if (draftOf(ids) case (final draftId, _)) {
          // Z Twoimi poprawkami, jeśli jakieś zrobiłeś.
          await mailbox.sendDraft(draftId);
        } else if (await mailbox.ourReplyIsLatest(latest.threadId)) {
          // Szkic zniknął, a ostatnie słowo w wątku jest nasze — wysłany
          // ręcznie z Gmaila. Drugiego mejla autor dostać nie może. Jeśli od
          // tamtej pory autor odpisał, to nowa sprawa: składamy mejl normalnie.
          await mailbox.batchModify(ids, add: add, remove: remove);
          repliedByHand++;
          continue;
        } else {
          final text = replyTextFor(ids);
          if (text == null) {
            // Nic do napisania — etykiety zostają, żeby nie zgubić sprawy.
            nothingToSay++;
            continue;
          }
          await mailbox.replyTo(latest, text);
        }
      } catch (e) {
        // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
        stderr.writeln('  ! $sender: $e');
        failed++;
        continue;
      }
      sent++;
      // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
      await mailbox.batchModify(ids, add: add, remove: remove);
    }
    stdout.writeln(_sentence([
      'Wysłano ${plural(sent, 'odpowiedź', 'odpowiedzi', 'odpowiedzi')}',
      if (repliedByHand > 0)
        plural(repliedByHand, 'już odpisany ręcznie', 'już odpisane ręcznie',
            'już odpisanych ręcznie'),
      if (nothingToSay > 0) '$nothingToSay bez treści (pominięte)',
      if (failed > 0)
        '${plural(failed, 'nieudany', 'nieudane', 'nieudanych')} (zostają w kolejce)',
    ]));
  }
}

/// Podsumowanie: pierwsza część i niezerowe dodatki po przecinku.
String _sentence(List<String> parts) => '${parts.join(', ')}.';

// ---------------------------------------------------------------------------
// clean / reopen / explain
// ---------------------------------------------------------------------------

/// `clean [katalog] [--push]`: kasuje katalog przebiegu, gdy nie jest już
/// do niczego potrzebny.
///
/// Katalog nie jest śmieciem od razu po wgraniu piosenek. Zanim zniknie,
/// muszą się domknąć trzy rzeczy — to, co zbiera [pendingLabelsOf]:
///
/// - **Werdykty.** Dopóki mejle przebiegu wiszą w [kLabelReadyToAdd] albo
///   [kLabelNeedsReview], `label added` i `label reviewed` potrzebują planu.
/// - **Odpowiedzi do autorów.** Teksty z przeglądu żyją w `decisions.json`
///   i czyta je `reply` — czasem długo później. Katalog skasowany przed
///   wysyłką = mejl bez Twojego tekstu.
/// - **Kolejka starej apki.** [kLabelReplyOldApp] z tego przebiegu.
///
/// Kiedy wszystko jest domknięte, zostaje sam ślad w Gmailu — a ten wystarczy.
Future<int> _clean(ArgResults cmd) async {
  final force = cmd['force'] as bool;
  final runDir = _runDir(cmd);
  final plan = readPlan(planPathIn(runDir));

  final mailbox = await _connect(cmd);
  final labelsByMessage = await mailbox.songLabelsByMessage();
  final pendingByMessage = {
    for (final id in plan.labelsByMessage.keys)
      if (pendingLabelsOf(labelsByMessage[id] ?? const {}) case final pending
          when pending.isNotEmpty)
        id: pending,
  };

  final files = Directory(runDir).listSync().length;
  stdout.writeln('Przebieg $runDir: '
      '${plural(plan.labelsByMessage.length, 'mejl', 'mejle', 'mejli')}, '
      '${plural(files, 'plik', 'pliki', 'plików')}.');

  if (pendingByMessage.isNotEmpty) {
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

  if (_dryRun(cmd, 'skasuje $runDir')) return 0;
  Directory(runDir).deleteSync(recursive: true);
  stdout.writeln('Skasowano $runDir.');
  return 0;
}

/// `reopen [--push]`: autorzy, którzy odpisali na Twój tekst z przeglądu.
///
/// Kolejka to „inbox bez `song/*`, **po wątkach**”, więc odpowiedź autora
/// wpada do wątku, który etykiety już ma — i `scan` jej nie widzi. Ta komenda
/// zdejmuje z takiego wątku wszystkie `song/*`, żeby wrócił do kolejki jako
/// zwykłe zgłoszenie i przeszedł normalny przesiew z nowymi chwytami. Bloku
/// o starej apce `scan` drugi raz nie zapyta: autor dostał już od nas odpowiedź.
///
/// Bierze wątki z [kLabelWaitingForAuthor], w których po naszej ostatniej
/// wiadomości pojawiła się przychodząca.
Future<int> _reopen(ArgResults cmd) async {
  final mailbox = await _connect(cmd);
  final query = cmd['query'] as String? ??
      'label:${labelQueryName(kLabelWaitingForAuthor)}';
  final ids = await mailbox.listIds(query);
  if (ids.isEmpty) {
    stdout.writeln('Nikt nie czeka na autora.');
    return 0;
  }
  stdout.writeln('Czeka na autora: ${plural(ids.length, 'mejl', 'mejle', 'mejli')}, '
      'sprawdzam wątki…');

  final threads = {for (final id in ids) mailbox.knownThreadOf(id)!};
  final authorReplied = [
    for (final t in threads)
      if (await mailbox.hasIncomingAfterOurReply(t)) t,
  ];
  if (authorReplied.isEmpty) {
    stdout.writeln('Nikt jeszcze nie odpisał '
        '(${plural(threads.length, 'wątek czeka', 'wątki czekają', 'wątków czeka')}).');
    return 0;
  }

  final labelsByMessage = await mailbox.songLabelsByMessage();
  final messagesOf = {
    for (final t in authorReplied) t: await mailbox.threadMessageIds(t),
  };
  // Piosenka już w apce → nie ma czego przesiewać na nowo. „Dzięki” od
  // autora to nie zgłoszenie, a poprawkę przysyła się z apki, jako nową.
  bool isAdded(String thread) => messagesOf[thread]!
      .any((id) => (labelsByMessage[id] ?? const {}).contains(kLabelAdded));
  final reopened = [for (final t in authorReplied) if (!isAdded(t)) t];
  final addedCount = authorReplied.length - reopened.length;
  final changes = <String, LabelChange>{
    for (final t in reopened)
      for (final id in messagesOf[t]!)
        if (labelsByMessage[id] case final labels? when labels.isNotEmpty)
          id: (const [], labels.toList()),
  };

  if (addedCount > 0) {
    stdout.writeln('Pomijam ${plural(addedCount, 'wątek', 'wątki', 'wątków')} '
        'z „$kLabelAdded” — piosenka już w apce, odpowiedź to nie nowe zgłoszenie.');
  }
  if (reopened.isEmpty) {
    stdout.writeln('Nic do cofnięcia do kolejki.');
    return 0;
  }
  stdout.writeln('Odpisali w ${plural(reopened.length, 'wątku', 'wątkach', 'wątkach')} — '
      '${plural(changes.length, 'mejl wróci', 'mejle wrócą', 'mejli wróci')} do kolejki:');
  for (final t in reopened) {
    final headers = await mailbox.headersOf(messagesOf[t]!.first);
    stdout.writeln('  ${headers.subject}  ${headers.from}  [$t]');
  }
  if (_dryRun(cmd, 'zdejmie etykiety „song/*”, żeby `scan` zobaczył te wątki na nowo')) {
    return 0;
  }
  await _applyChanges(mailbox, changes);
  stdout.writeln('Zdjęto etykiety z ${plural(changes.length, 'mejla', 'mejli', 'mejli')}. '
      'Dalej: ./piosenkomat scan');
  return 0;
}

int _explain(ArgResults cmd) {
  if (cmd.rest.isEmpty) {
    stderr.writeln('Podaj pliki .eml: ./piosenkomat explain plik.eml');
    return 64;
  }
  final book = _loadBook(cmd);
  final messages = [
    for (final path in cmd.rest)
      ContribMessage.fromEml(File(_resolve(path)).readAsStringSync(), id: p.basename(path)),
  ];
  stdout.write(formatRunReport(classifyBatch(messages, book: book)));
  return 0;
}

// ---------------------------------------------------------------------------
// Pomocnicze
// ---------------------------------------------------------------------------

/// Katalog przebiegu z argumentu, a bez argumentu — ostatni z `out/`.
String _runDir(ArgResults cmd) {
  if (cmd.rest.length > 1) {
    throw const _UsageError('Podaj jeden katalog przebiegu albo żaden (weźmie ostatni).');
  }
  if (cmd.rest.length == 1) {
    final arg = _resolve(cmd.rest.single);
    if (!FileSystemEntity.isDirectorySync(arg)) {
      throw _UsageError('To nie jest katalog przebiegu: $arg');
    }
    return arg;
  }
  final latest = latestRunDir();
  if (latest == null) {
    throw const _UsageError('Nie ma żadnego przebiegu w out/. Najpierw: ./piosenkomat scan');
  }
  final dir = _resolve(latest);
  stdout.writeln('Ostatni przebieg: $dir');
  return dir;
}

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

SongBook _loadBook(ArgResults cmd) {
  final path = cmd['songs-db'] as String? ?? defaultSongsDbPath();
  final book = loadBook(path);
  stdout.writeln('Śpiewnik: $path (${book.songs.length} tytułów)');
  return book;
}

Future<GmailMailbox> _connect(ArgResults cmd, {bool needsSend = false}) =>
    GmailMailbox.connect(
      credentialsFile: File(cmd['credentials'] as String? ?? defaultCredentialsPath()),
      tokenFile: File(cmd['token'] as String? ?? defaultTokenPath()),
      needsSend: needsSend,
    );

String _minute(DateTime d) => d.toLocal().toIso8601String().substring(0, 16);

String _usage(ArgParser parser) => '''
piosenkomat: sitko mejli z piosenkami na $kInboxEmail.

  ./piosenkomat scan [-n N] [--newest] [-o katalog]
      kolejka (inbox bez song/*, po wątkach) → katalog out/import-<data>/:
      raport, plan, candidates-new.hrcpsng, candidates-correction.hrcpsng
      (uwagi przy piosenkach), reviewed-*.hrcpsng. Gmaila tylko czyta
  ./piosenkomat label scanned [katalog] --push
      werdykty automatu na mejle: „$kLabelReadyToAdd”, „song/rejected/…”,
      „$kLabelNeedsReview”, wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat label reviewed [katalog] --push
      co jest w reviewed-*.hrcpsng → „$kLabelReadyToAdd”, czego nie ma →
      „$kLabelRejectedAfterReview”; obce piosenki i dwie poprawki tego samego → STOP
  ./piosenkomat label added [katalog|--all] --push
      „$kLabelReadyToAdd” + „$kLabelAuto” → „$kLabelAdded” + przeczytane
  ./piosenkomat unlabel [katalog|--all] --push
      cofa wszystko, co nadał automat („$kLabelAuto”) na mejlach przebiegu;
      z --all — w całej skrzynce
  ./piosenkomat reply [katalog] [-n N] [--draft] --push
      odpowiedzi do autorów: „zaktualizuj apkę” i Twoje teksty z przeglądu,
      jeden mejl na autora; kolejką są „$kLabelReplyOldApp”
      i „$kLabelReplyReviewNote”, po tekście z przeglądu wchodzi
      „$kLabelWaitingForAuthor”. Zakresem jest przebieg; zaległość spoza niego
      bierze --all
      --draft zostawia szkice w wątkach (kolejka nietknięta) — późniejszy
      reply --push wysyła je z Twoimi poprawkami, a --undraft je kasuje,
      nikomu nic nie wysyłając
  ./piosenkomat reopen --push
      autorzy, którzy odpisali na Twój tekst („$kLabelWaitingForAuthor”):
      zdejmuje z ich wątków „song/*”, żeby wróciły do kolejki i przeszły scan
  ./piosenkomat clean [katalog] --push
      kasuje katalog przebiegu, gdy nic już na niego nie czeka — sprawdza
      w Gmailu, czy werdykty, odpowiedzi i kolejka starej apki są domknięte
  ./piosenkomat explain plik.eml [...]
      klasyfikacja lokalnych plików, bez Gmaila
  ./piosenkomat prepare [katalog]
      reviewed-*.hrcpsng → final-*.hrcpsng bez pola `piosenkomat`; poprawki
      dostają id poprawianej piosenki i listę „co podmienić”; do tego
      people.dart z osób, które naprawdę weszły

Bez katalogu komendy biorą ostatni przebieg z out/.
Bez --push nic w Gmailu się nie zmienia.

scan:
${parser.commands['scan']!.usage}

label reviewed:
${parser.commands['label']!.commands['reviewed']!.usage}

unlabel:
${parser.commands['unlabel']!.usage}
''';
