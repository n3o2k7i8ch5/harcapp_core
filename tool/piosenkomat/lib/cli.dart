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
  _addWrite(labelScanned, help: 'Nadaj etykiety (bez tej flagi tylko lista)');

  final labelReviewed = label.addCommand('reviewed');
  _reviewedOptions(labelReviewed);
  _addCommon(labelReviewed);
  _addWrite(labelReviewed,
      help: 'Zmień etykiety odrzuconych (bez tej flagi tylko lista)');

  final labelAdded = label.addCommand('added');
  labelAdded.addFlag('all',
      negatable: false,
      help: 'Cała skrzynka, nie tylko przebieg');
  _addCommon(labelAdded);
  _addWrite(labelAdded, help: 'Zmień etykiety w Gmailu (bez tej flagi lista)');

  final unlabel = parser.addCommand('unlabel');
  _unlabelOptions(unlabel);
  _addCommon(unlabel);
  _addWrite(unlabel, help: 'Zdejmij etykiety (bez tej flagi tylko lista)');

  final reply = parser.addCommand('reply');
  _replyOptions(reply);
  _addCommon(reply);
  _addWrite(reply, help: 'Wyślij (bez tej flagi tylko lista)');

  final reopen = parser.addCommand('reopen');
  reopen.addOption('query', help: 'Własne query Gmaila zamiast zapytanych');
  _addCommon(reopen);
  _addWrite(reopen, help: 'Zdejmij etykiety (bez tej flagi tylko lista)');

  final clean = parser.addCommand('clean');
  clean.addFlag('force',
      negatable: false, help: 'Skasuj mimo niedokończonych spraw');
  _addCommon(clean);
  _addWrite(clean, help: 'Skasuj katalog (bez tej flagi tylko lista)');

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

/// Opcje poszczególnych komend.
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
    help: 'Zdejmij też z domkniętych („song/added”)');

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


/// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
/// „wypchnij to, co widzisz na sucho, do skrzynki”.
void _addWrite(ArgParser p, {String? help}) =>
    p.addFlag('push', abbr: 'p', negatable: false, help: help);

bool _write(ArgResults cmd) => cmd['push'] as bool;

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
  stdout.writeln('Kolejka ($scope): ${ids.length} mejli, pobieram…');
  final fetched = await mailbox.getMessages(ids, onProgress: (done, total) {
    if (done % 50 == 0 || done == total) stdout.writeln('  $done/$total');
  });
  // Bezpieczniki na wypadek, gdyby query przepuściło coś już otagowanego
  // albo coś, co nie jest zgłoszeniem piosenki. Takich mejli nie dotykamy.
  // Osobno i tylko te, które inaczej weszłyby do przebiegu — żeby ten sam
  // mejl nie wpadł do dwóch podsumowań.
  final web = fetched.where((m) => !m.isHandled && isWebSubmission(m)).length;
  var messages = fetched
      .where((m) => !m.isHandled && m.isSongSubmission && !isWebSubmission(m))
      .toList();
  if (web > 0) {
    stdout.writeln('Odsiano $web zgłoszeń ze strony — piosenkomat obsługuje '
        'wyłącznie zgłoszenia wysłane z apki. Te ogarnij ręcznie.');
  }
  // Kolejka jest po wątkach: odpowiedź w wątku, który już dostał `song/*`,
  // to nie nowe zgłoszenie. Query tego nie umie (działa na wiadomościach),
  // więc dociągamy wątek — jedno zapytanie na wątek.
  final threads = {for (final m in messages) m.threadId}.toList();
  final labeledThreads = <String>{};
  // Przy okazji: w którym wątku już odpisaliśmy (np. cofniętym przez `reopen`).
  final answeredThreads = <String>{};
  for (final t in threads) {
    final labels = await mailbox.threadLabels(t);
    if (labels.any(isSongLabel)) labeledThreads.add(t);
    if (labels.contains('SENT')) answeredThreads.add(t);
  }
  messages = messages.where((m) => !labeledThreads.contains(m.threadId)).toList();
  // Stara apka: blok „zaktualizuj apkę” idzie raz na autora, nie na wątek —
  // `reply` odpisuje w jego najnowszym wątku, więc w starszych `SENT` nie ma.
  // Pytamy więc o nadawcę: jedno tanie zapytanie na autora ze starej apki.
  final oldAppSenders = {
    for (final m in messages)
      if (m.body.contains(kOldAppMarker))
        if (emailFromHeader(m.from) case final sender?) sender,
  };
  final answeredSenders = <String>{
    for (final sender in oldAppSenders)
      if ((await mailbox.listIds('in:sent to:$sender', limit: 1, newest: true))
          .isNotEmpty)
        sender,
  };
  for (final m in messages) {
    if (answeredSenders.contains(emailFromHeader(m.from))) answeredThreads.add(m.threadId);
  }
  final skipped = fetched.length - messages.length - web;
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli '
        '(już otagowane, w otagowanym wątku albo nie o piosence), zostają bez zmian.');
  }

  final classified =
      classifyBatch(messages, book: book, answeredThreads: answeredThreads);
  final report = formatRunReport(classified);
  stdout.writeln();
  stdout.write(report);

  final outDir = cmd['out'] as String? ?? defaultOutDir();
  final run = p.basename(outDir);
  final planPath = planPathIn(outDir);
  final reportPath = reportPathIn(outDir);
  writeText(reportPath, report);

  // Dwa pliki, bo to dwie roboty: nowe dodajesz, poprawki porównujesz
  // z tym, co w apce. Uwagi jadą w piosenkach — edytor pokaże je nad każdą.
  final candidates = [for (final c in classified) if (c.goesToFile) c.song!];
  assignUniqueIds(candidates);
  for (final c in classified) {
    if (c.song case final song?) {
      song.piosenkomatData = c.piosenkomatData(run: run);
    }
  }
  final plan = LabelPlan.fromClassified(classified);
  writePlan(planPath, plan);

  var wrote = false;
  for (final kind in SubmissionKind.values) {
    final songs = [
      for (final c in classified)
        if (c.goesToFile && c.submission.kind == kind) c.song!,
    ];
    if (songs.isEmpty) continue;
    wrote = true;
    final path = candidatesPathIn(outDir, kind);
    writeHrcpsng(path, songs, withPiosenkomatData: true);
    final clean = classified
        .where((c) => c.goesToFile && c.submission.kind == kind && c.issues.isEmpty)
        .length;
    stdout.writeln('\n${kind == SubmissionKind.correction ? 'Poprawki' : 'Nowe'}: '
        '${songs.length} piosenek → $path ($clean bez zarzutu, ${songs.length - clean} z uwagami)');
    // Miejsce na eksport: wrzucasz tu plik ze strony, a `label reviewed`
    // z różnicy wyciąga odrzucone.
    final reviewedPath = reviewedPathIn(outDir, kind);
    writeHrcpsng(reviewedPath, songs, withPiosenkomatData: true);
    stdout.writeln('  po przeglądzie podmień $reviewedPath eksportem ze strony');
  }

  if (wrote) {
    stdout.writeln('Wczytuj jeden plik naraz na stronie ze śpiewnikiem; '
        'potem: ./piosenkomat label reviewed $outDir');
    // Osoby dodające dopiero przy `prepare`: przed przeglądem nie wiadomo,
    // które piosenki wejdą, a więc kogo w ogóle dopisywać do data.dart.
  } else {
    stdout.writeln('\nNic nie poszło do plików.');
  }

  stdout.writeln('Katalog: $outDir');
  stdout.writeln('Raport: $reportPath');
  stdout.writeln('Plan etykiet: $planPath');
  stdout.writeln('Gmail nietknięty — `scan` tylko czyta. Etykiety jak '
      'w raporcie nada: ./piosenkomat label scanned $outDir --push');
  return 0;
}

/// `label scanned [katalog] [--push]`: etykiety z planu zapisanego przez
/// `scan`, bez ponownego czytania treści. Mejle, które w międzyczasie dostały
/// już etykietę song/*, są pomijane.
Future<int> _labelScanned(ArgResults cmd) async {
  final planPath = _planPath(cmd);
  if (planPath == null) return 64;
  final plan = readPlan(planPath);
  stdout.writeln(_planHeader(plan));
  _countLines(stdout, _tally(plan.labelsById.values.expand((l) => l)));
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push nada powyższe.');
    return 0;
  }
  final mailbox = await _connect(cmd);
  stdout.writeln('Sprawdzam aktualne etykiety ${plan.labelsById.length} mejli…');
  final current = await mailbox.songLabelsByMessage();
  await _applyPlan(mailbox, plan, alreadyLabeled: {
    for (final id in plan.labelsById.keys)
      if (current.containsKey(id)) id,
  });
  return 0;
}

/// `unlabel [katalog] [--push]`: cofa to, co nadał automat. Swoje poznaje po
/// znaczniku `song/auto` — Ty go nie wieszasz, więc Twoje ręczne etykiety
/// (te bez `auto`) zostają nietknięte. Bez argumentu bierze całą skrzynkę,
/// z katalogiem przebiegu — tylko mejle z jego planu.
///
/// Bezpiecznik: mejla domkniętego przez `label added` nie ruszamy — piosenka
/// jest już w apce, a zdjęcie etykiet wepchnęłoby ją z powrotem do kolejki.
/// `--force`, jeśli mimo to ma zejść.
Future<int> _unlabel(ArgResults cmd) async {
  final force = cmd['force'] as bool;
  final dir = cmd.rest.isEmpty ? null : _runDir(cmd);
  if (cmd.rest.isNotEmpty && dir == null) return 64;
  final plan = dir == null ? null : readPlan(planPathIn(dir));
  if (plan != null) stdout.writeln(_planHeader(plan));

  final mailbox = await _connect(cmd);
  stdout.writeln('Sprawdzam etykiety w skrzynce…');
  final currentById = await mailbox.songLabelsByMessage();
  // Ślad automatu to znacznik `auto` — nic innego nie daje prawa zdejmować.
  final byAutomat = {
    for (final e in currentById.entries)
      if (e.value.contains(kLabelAuto)) e.key: e.value,
  };

  final toRemove = <String, List<String>>{};
  var outsidePlan = 0;
  var closed = 0;
  for (final e in byAutomat.entries) {
    if (plan != null && !plan.labelsById.containsKey(e.key)) {
      outsidePlan++;
      continue;
    }
    if (e.value.contains(kLabelDone) && !force) {
      closed++;
      continue;
    }
    toRemove[e.key] = [
      for (final l in kToolLabels)
        if (e.value.contains(l)) l,
    ];
    if (toRemove[e.key]!.isEmpty) toRemove.remove(e.key);
  }

  if (toRemove.isEmpty) {
    stdout.writeln('Nic do zdjęcia — po automacie nie został ślad.');
    return 0;
  }
  stdout.writeln('Do zdjęcia z ${toRemove.length} mejli:');
  _countLines(stdout, _tally(toRemove.values.expand((l) => l)));
  if (outsidePlan > 0) {
    stdout.writeln('Poza tym przebiegiem siedzi jeszcze $outsidePlan mejli '
        'ze znacznikiem „$kLabelAuto”. Zejdą, jeśli odpalisz `unlabel` bez katalogu.');
  }
  if (closed > 0) {
    stdout.writeln('Pomijam $closed domkniętych („$kLabelDone”) — te piosenki są '
        'już w apce; --force, jeśli mimo to mają zejść.');
  }
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push zdejmie powyższe.');
    return 0;
  }
  await _batchByLabels(mailbox, toRemove, add: false);
  stdout.writeln('Zdjęto z ${toRemove.length} mejli. '
      'Wracają do kolejki, więc `scan` weźmie je ponownie.');
  return 0;
}

Future<void> _applyPlan(
  GmailMailbox mailbox,
  LabelPlan plan, {
  required Set<String> alreadyLabeled,
}) async {
  await mailbox.ensureToolLabels();
  final toAdd = <String, List<String>>{};
  var skipped = 0;
  for (final e in plan.labelsById.entries) {
    if (alreadyLabeled.contains(e.key)) {
      skipped++;
      continue;
    }
    toAdd[e.key] = e.value;
  }
  await _batchByLabels(mailbox, toAdd, add: true);
  stdout.writeln('Nadano:');
  _countLines(stdout, _tally(toAdd.values.expand((l) => l)));
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli, które już miały etykietę song/*.');
  }
  stdout.writeln('Po przeglądzie na stronie podmień reviewed-*.hrcpsng, potem '
      './piosenkomat label reviewed --push i ./piosenkomat label added --push');
}

/// Piosenki przebiegu po id mejla — do wypisania tytułu i nadawcy.
Map<String, PlannedSong> _songsOf(LabelPlan plan) => {
      for (final e in plan.songsByThread.entries)
        if (e.value.isNotEmpty)
          for (final msgId in plan.messagesOf(e.key)) msgId: e.value.first,
    };

/// To samo z ostatniego przebiegu, dla `label added --all`: mejle spoza
/// planu i tak trzeba dopytać Gmaila, a uszkodzony plan niczego nie blokuje.
Map<String, PlannedSong> _songsFromLatestPlan() {
  final dir = latestOutDir();
  if (dir == null) return const {};
  final path = planPathIn(_resolve(dir));
  if (!_exists(path)) return const {};
  try {
    return _songsOf(readPlan(path));
  } catch (_) {
    // Plan tylko ładniej podpisuje wiersze; uszkodzony (zły JSON, stary
    // kształt) niczego nie blokuje — dopytamy Gmaila.
    return const {};
  }
}

String _planHeader(LabelPlan plan) =>
    'Plan z ${_minute(plan.createdAt)}: ${plan.labelsById.length} mejli';

/// Mejle o identycznym zestawie etykiet idą jedną paczką: `batchModify`
/// bierze do 1000 naraz, więc przebieg to kilkanaście strzałów, nie kilkaset.
Future<void> _batchByLabels(
  GmailMailbox mailbox,
  Map<String, List<String>> labelsById, {
  required bool add,
}) async {
  final groups = <String, (List<String>, List<String>)>{};
  for (final e in labelsById.entries) {
    groups.putIfAbsent(e.value.join('\u0000'), () => (e.value, <String>[])).$2
        .add(e.key);
  }
  for (final (labels, ids) in groups.values) {
    if (!add) {
      await mailbox.batchModify(ids, remove: labels);
      continue;
    }
    // Werdykt domykający sprawę zdejmuje „nieprzeczytane”.
    await mailbox.batchModify(ids,
        add: labels,
        remove: labels.any(isClosedLabel) ? const ['UNREAD'] : null);
  }
}

Future<int> _labelAdded(ArgResults cmd) async {
  final write = _write(cmd);
  // Domyślnie przebieg, jak w każdej komendzie na katalogu: `label added`
  // znaczy „domknij to, co z TEGO przebiegu wkleiłeś do śpiewnika”. Mejle
  // z innego przebiegu, którego jeszcze nie wkleiłeś, mają zostać otwarte.
  final all = cmd['all'] as bool;
  final dir = all ? null : _runDir(cmd);
  if (!all && dir == null) return 64;
  final plan = dir == null ? null : readPlan(planPathIn(dir));
  if (plan != null) stdout.writeln(_planHeader(plan));

  final mailbox = await _connect(cmd);
  final current = await mailbox.songLabelsByMessage();
  // Bezpiecznik na wypadek, gdyby query przepuściło coś bez „auto”: ruszamy
  // tylko to, co automat sam wstawił do pliku. Sam zestaw etykiet wystarczy,
  // żeby wiedzieć, co jest gotowe — bez osobnego zapytania do Gmaila.
  final gotowe = [
    for (final e in current.entries)
      if (isReadyByTool(e.value)) e.key,
  ];
  final ready = plan == null
      ? gotowe
      : [for (final id in gotowe) if (plan.labelsById.containsKey(id)) id];
  final pozaPrzebiegiem = gotowe.length - ready.length;

  // Tytuł i nadawcę bierzemy z planu przebiegu — leżą w `plan.json` za darmo.
  // Dopytujemy Gmaila tylko o mejle spoza planu (20 jednostek za sztukę).
  final zPlanu = plan == null ? _songsFromLatestPlan() : _songsOf(plan);
  for (final id in ready) {
    if (zPlanu[id] case final i?) {
      stdout.writeln('  ${i.title}  ${i.sender}  [$id]');
    } else {
      final h = await mailbox.headersOf(id);
      stdout.writeln('  ${h.subject}  ${emailFromHeader(h.from) ?? ''}  [$id]');
    }
  }
  stdout.writeln('„$kLabelReady” + „$kLabelAuto”: ${ready.length} mejli');
  if (pozaPrzebiegiem > 0) {
    stdout.writeln('  $pozaPrzebiegiem czeka poza tym przebiegiem — domknij je '
        'jego własnym `label added` (albo `--all`, gdy masz wklejone wszystkie).');
  }
  if (!write) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push zmieni na „$kLabelDone” + przeczytane.');
    return 0;
  }
  await mailbox.ensureToolLabels();
  // Przeczytane tylko tam, gdzie nic już nie wisi: mejl z pytaniem do osoby
  // dodającej czeka jeszcze na wysyłkę, więc zostaje nieprzeczytany.
  final withQuestion = [
    for (final id in ready)
      if ((current[id] ?? const <String>{}).contains(kLabelReplyReviewNote)) id,
  ];
  final withoutQuestion = [for (final id in ready) if (!withQuestion.contains(id)) id];
  if (withoutQuestion.isNotEmpty) {
    await mailbox.batchModify(withoutQuestion,
        add: [kLabelDone], remove: [kLabelReady, 'UNREAD']);
  }
  if (withQuestion.isNotEmpty) {
    await mailbox.batchModify(withQuestion, add: [kLabelDone], remove: [kLabelReady]);
  }
  stdout.writeln('Zatwierdzono ${ready.length} mejli.');
  return 0;
}

/// `label reviewed [katalog] [--push]`: różnica między tym, co automat
/// wstawił do plików kandydatów, a tym, co wróciło po Twoim przeglądzie.
///
/// Dwa stany, po id wątku: piosenka **jest** w `reviewed-*` → „$kLabelReady”,
/// **nie ma** → „$kLabelRejectedAfterReview”. Uwagi w piosence nie mają
/// znaczenia — pastylki są dla Ciebie, nie dla narzędzia. Osobno dla nowych
/// i dla poprawek; brak pliku zwrotnego = tej części jeszcze nie przeglądałeś.
///
/// Z kandydatów można wywalać i edytować, nie dodawać: obcy wątek, zły
/// rodzaj w pliku albo dwie poprawki tej samej piosenki → STOP, bez `--force`.
Future<int> _labelReviewed(ArgResults cmd) async {
  final outDir = _runDir(cmd);
  if (outDir == null) return 64;
  final force = cmd['force'] as bool;
  final plan = readPlan(planPathIn(outDir));

  final results = <ReviewResult>[];
  for (final kind in SubmissionKind.values) {
    final candidates = _candidatesOf(outDir, kind);
    final proposed = collectProposed(plan, candidates, kind);
    if (proposed.isEmpty) continue;
    final reviewedPath = _reviewedFileOf(outDir, kind);
    if (reviewedPath == null) {
      stdout.writeln('${_kindName(kind)}: brak pliku zwrotnego — tej części '
          'jeszcze nie przeglądałeś, pomijam.');
      continue;
    }
    final reviewed = readHrcpsng(reviewedPath);
    stdout.writeln('${_kindName(kind)}: ${proposed.length} kandydatów, '
        '${reviewed.length} w $reviewedPath');
    final result = reviewDiff(kind: kind, proposed: proposed, reviewed: reviewed);
    _printReview(result);

    if (result.mustStop) {
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
      return 1;
    }
    // Bezpieczniki na zły plik: pusty eksport i „odrzucona większość” prawie
    // zawsze znaczą, że podmieniony został nie ten plik, co trzeba.
    if (!force && reviewed.isEmpty) {
      stderr.writeln('$reviewedPath jest pusty — to wygląda na pomyłkę. '
          'Jeśli naprawdę odrzucasz wszystko: --force.');
      return 1;
    }
    final rejectedCount = result.allRejected.length;
    if (!force && rejectedCount * 2 > proposed.length) {
      stderr.writeln('Odrzucone to ponad połowa '
          '($rejectedCount/${proposed.length}) — sprawdź, czy podmieniłeś właściwy '
          'plik i czy nie zgasiłeś przełącznika hurtem. Jeśli tak ma być: '
          '--force.');
      return 1;
    }
    results.add(result);
  }

  if (results.isEmpty) {
    stdout.writeln('Nic do porównania.');
    return 0;
  }
  final decisionsPath = decisionsPathIn(outDir);
  writeDecisions(decisionsPath, results);
  stdout.writeln('Ślad przeglądu: $decisionsPath');

  final changes = reviewLabelChanges(results, plan);
  if (changes.isEmpty) {
    stdout.writeln('\nNic do przestawienia. Dalej: ./piosenkomat label added --push');
    return 0;
  }
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push przestawi etykiety '
        'na ${changes.length} mejlach.');
    return 0;
  }

  final mailbox = await _connect(cmd);
  await mailbox.ensureToolLabels();
  // Bezpiecznik jak w `label added`: ruszamy tylko to, co automat sam
  // wstawił do plików przebiegu i co dalej tam czeka.
  final current = <String, Set<String>>{};
  if (changes.length > 5) {
    current.addAll(await mailbox.songLabelsByMessage());
  } else {
    for (final id in changes.keys) {
      current[id] = await mailbox.labelsOf(id);
    }
  }

  // Mejle o tej samej zmianie idą jedną paczką (`batchModify` bierze do 1000).
  final groups = <String, (List<String>, List<String>, List<String>)>{};
  var skipped = 0;
  for (final e in changes.entries) {
    final labels = current[e.key] ?? const <String>{};
    if (!isInRunFilesByTool(labels)) {
      skipped++;
      continue;
    }
    final (add, remove) = e.value;
    final effectiveRemove = [
      ...remove.where(labels.contains),
      if (add.any(isClosedLabel)) 'UNREAD',
    ];
    final key = '${add.join('\u0000')}\u0001${effectiveRemove.join('\u0000')}';
    groups.putIfAbsent(key, () => (add, effectiveRemove, <String>[])).$3.add(e.key);
  }
  var done = 0;
  for (final (add, remove, ids) in groups.values) {
    await mailbox.batchModify(ids,
        add: add.isEmpty ? null : add, remove: remove.isEmpty ? null : remove);
    done += ids.length;
  }
  stdout.writeln('Przestawiono etykiety na $done mejlach.');
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli spoza plików tego przebiegu.');
  }
  stdout.writeln('Dalej: ./piosenkomat label added --push');
  return 0;
}

String _kindName(SubmissionKind k) =>
    k == SubmissionKind.correction ? 'Poprawki' : 'Nowe';

/// Kandydaci danego rodzaju z katalogu przebiegu.
List<SongRaw> _candidatesOf(String outDir, SubmissionKind kind) {
  final path = candidatesPathIn(outDir, kind);
  return _exists(path) ? readHrcpsng(path) : const [];
}

/// Plik zwrotny danego rodzaju, o ile jest.
String? _reviewedFileOf(String outDir, SubmissionKind kind) {
  final path = reviewedPathIn(outDir, kind);
  return _exists(path) ? path : null;
}

/// Co zrobić z etykietami każdej wiadomości po przeglądzie: `(dodaj, zdejmij)`.
/// Etykiety idą na wszystkie wiadomości wątku.
/// Co po przeglądzie dochodzi i co schodzi z każdej wiadomości wątku.
Map<String, (List<String>, List<String>)> reviewLabelChanges(
  List<ReviewResult> results,
  LabelPlan plan,
) {
  final out = <String, (List<String>, List<String>)>{};
  for (final r in results) {
    for (final threadId in r.rejectedThreads) {
      // Odrzucona z wyjaśnieniem to nie koniec sprawy, tylko pytanie do
      // autora: bez „rejected”, bo piosenka może jeszcze wrócić z chwytami.
      final hasQuestion = r.replies.containsKey(threadId);
      for (final id in plan.messagesOf(threadId)) {
        out[id] = hasQuestion
            ? ([kLabelReplyReviewNote], [kLabelReady, ...kReviewLabels])
            : ([kLabelRejectedAfterReview], [kLabelReady, ...kReviewLabels]);
      }
    }
    for (final threadId in r.acceptedThreads) {
      final hasQuestion = r.replies.containsKey(threadId);
      for (final id in plan.messagesOf(threadId)) {
        // Bez zarzutu już miały „w pliku” — ruszamy tylko te po przeglądzie
        // albo takie, którym dopisałeś odpowiedź.
        if (!hasQuestion &&
            !(plan.labelsById[id] ?? const []).contains(kLabelToReview)) continue;
        out[id] = ([kLabelReady, if (hasQuestion) kLabelReplyReviewNote], kReviewLabels);
      }
    }
  }
  return out;
}

/// Co weszło, co wypadło, co rozpoznane inaczej niż po id wątku.
void _printReview(ReviewResult result) {
  stdout.writeln('  WCHODZI    ${result.accepted.length}');
  stdout.writeln('  ODRZUCONE  ${result.allRejected.length}');
  for (final r in result.rejected) {
    stdout.writeln('    ODRZUĆ  ${r.title}  [${r.threadId}]');
  }
  for (final m in result.turnedDown) {
    final hasQuestion = result.replies.containsKey(m.proposed.threadId);
    stdout.writeln('    ODRZUĆ  ${m.reviewed.title}  [${m.proposed.threadId}]'
        '  (przełącznik${hasQuestion ? ', z odpowiedzią' : ''})');
  }
  final byOther = [
    for (final m in result.accepted)
      if (m.kind != MatchKind.threadId) m,
  ];
  if (byOther.isNotEmpty) {
    stdout.writeln('  Rozpoznane inaczej niż po id wątku '
        '(tytuł mógł się zmienić przy przeglądzie): ${byOther.length}');
    for (final m in byOther) {
      stdout.writeln('    ${m.kind.text.padRight(12)} ${m.proposed.title}'
          '${m.reviewed.title == m.proposed.title ? '' : ' → ${m.reviewed.title}'}');
    }
  }
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
  final outDir = _runDir(cmd);
  if (outDir == null) return 64;
  var any = false;
  final entering = <SongRaw>[];
  final sources = <ContributorSource>[];
  for (final kind in SubmissionKind.values) {
    final reviewedPath = _reviewedFileOf(outDir, kind);
    if (reviewedPath == null) continue;
    any = true;
    final allSongs = readHrcpsng(reviewedPath);
    // Przełącznik „nie wchodzi” z przeglądu. Nieruszony znaczy „wchodzi”,
    // więc milczenie na stronie nie wyrzuca piosenki z pliku.
    final songs = [
      for (final s in allSongs)
        if (s.piosenkomatData?.goesIn ?? true) s,
    ];
    final turnedDownCount = allSongs.length - songs.length;
    // Przed `strip`, bo `sender_is_contributor` niesie ślad piosenkomatu.
    sources.addAll(contributorSourcesOf(songs));
    final targets = stripPiosenkomat(songs);
    entering.addAll(songs);
    final out = finalPathIn(outDir, kind);
    writeHrcpsng(out, songs);
    stdout.writeln('${_kindName(kind)}: ${songs.length} piosenek → $out');
    if (turnedDownCount > 0) {
      stdout.writeln('  pominięto $turnedDownCount z przełącznikiem „nie wchodzi”');
    }
    if (kind == SubmissionKind.correction) {
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
  }
  if (!any) {
    stderr.writeln('Brak plików zwrotnych w $outDir — najpierw przegląd na stronie.');
    return 1;
  }
  _writePeople(outDir, sources);
  return 0;
}

/// `people.dart` z piosenek, które wchodzą. Dodatkowe adresy z bloku „Osoba
/// dodająca” dokłada plan przebiegu — piosenka niesie tylko `email_ref`.
void _writePeople(String outDir, List<ContributorSource> sources) {
  final planPath = planPathIn(outDir);
  var otherEmails = const <String, List<String>>{};
  if (_exists(planPath)) {
    try {
      otherEmails = otherEmailsBySender(readPlan(planPath));
    } on FormatException {
      stdout.writeln('Plan $planPath nie do odczytania — '
          'w people.dart same adresy nadawców.');
    }
  }
  final people = collectPeople(withOtherEmails(sources, otherEmails));
  final peoplePath = peoplePathIn(outDir);
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

/// `reply [--draft] [--push]`: odpowiedzi do autorów — blok „zaktualizuj
/// apkę” i Twoje teksty z przeglądu, razem w jednym mejlu.
///
/// Kolejką jest sam Gmail: etykiety „$kLabelReplyOldApp” (wiesza
/// `label scanned`) i „$kLabelReplyReviewNote” (wiesza `label reviewed`).
/// Wysyłka je zdejmuje, więc nikt nie dostanie dwóch odpowiedzi, a przerwany
/// przebieg dokańcza się zwykłym powtórzeniem komendy.
///
/// Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek ze starej
/// apki, dostaje jeden mejl w najnowszym wątku, a etykieta schodzi ze wszystkich.
///
/// `--draft` rozrywa to na dwa kroki: najpierw szkic w wątku (etykiety
/// zostają — nikt nic nie dostał). Późniejszy `reply --push` wysyła gotowy
/// szkic zamiast składać mejl od nowa, więc Twoje poprawki idą w świat. Który
/// autor ma szkic, mówi sam Gmail — bez osobnej etykiety. Szkic skasowany albo wysłany
/// ręcznie z Gmaila: jeśli w wątku jest już nasza wysłana wiadomość, uznajemy
/// za odpisane i tylko przestawiamy etykiety; jeśli nie ma — składamy mejl
/// normalnie.
Future<int> _reply(ArgResults cmd) async {
  final write = _write(cmd);
  final draft = cmd['draft'] as bool;
  final undraft = cmd['undraft'] as bool;
  final limit = _limit(cmd);
  if (draft && undraft) {
    throw const _UsageError('--draft i --undraft naraz nie mają sensu.');
  }

  // Zakres: domyślnie autorzy z przebiegu, bo odpisuje się po imporcie.
  // Zaległa kolejka spoza niego siedzi w skrzynce i czeka na `--all`.
  final wholeQueue = (cmd['all'] as bool) || cmd['query'] != null;
  String? runDir;
  if (!wholeQueue) {
    runDir = _runDir(cmd);
    if (runDir == null) return 1;
  }

  // Szkic i jego kasowanie potrzebują tylko `modify`; `send` dopiero wysyłka.
  final mailbox = await _connect(cmd, needsSend: !draft && !undraft);
  // Dwie kolejki, jeden mejl: blok o starej apce i uwagi z przeglądu trafiają
  // do tego samego autora razem, więc bierzemy obie naraz.
  final queueQuery = 'label:${labelQueryName(kLabelReplyOldApp)} '
      'OR label:${labelQueryName(kLabelReplyReviewNote)}';
  final query = cmd['query'] as String? ?? '($queueQuery)';
  var ids = await mailbox.listIds(query);
  // Szkice po wątku: jedno zapytanie zamiast jednego na autora.
  final drafts = await mailbox.draftIdsByThread();
  // `--undraft` bierze tylko wątki, w których szkic faktycznie czeka.
  if (undraft) {
    ids = ids.where((id) => drafts.containsKey(mailbox.knownThreadOf(id))).toList();
  }

  // Teksty z pola „Odpowiedź do autora”: ze śladu przeglądu, bo `prepare`
  // zdejmuje je z piosenek na długo przed `reply`.
  final replies = <String, String>{};
  for (final dir in runDir != null ? [runDir] : allOutDirs()) {
    replies.addAll(readReplies(decisionsPathIn(dir)));
  }

  // Etykieta dalej mówi, komu nie odpisano; przebieg tylko zawęża do tych,
  // których sam przyniósł. Przecięcie, nie zastąpienie.
  final plan = runDir == null ? null : readPlan(planPathIn(runDir));
  bool inScope(String id) => plan == null || plan.labelsById.containsKey(id);
  if (plan != null) {
    final before = ids.length;
    ids = ids.where(inScope).toList();
    stdout.writeln('Zakres: przebieg $runDir '
        '(${ids.length} z $before mejli w kolejce; --all bierze wszystkie)');
  }

  // Kto jest ze starej apki — po tym wiadomo, czy doklejać jej blok.
  final oldAppIds =
      (await mailbox.listIds('label:${labelQueryName(kLabelReplyOldApp)}'))
          .toSet();
  if (ids.isEmpty) {
    stdout.writeln(undraft
        ? 'Nie ma szkiców do skasowania.'
        : draft
            ? 'Nikt nie czeka na szkic — kolejka pusta albo wszyscy już go mają.'
            : 'Nikt nie czeka na odpowiedź.');
    return 0;
  }
  stdout.writeln('Do odpisania: ${ids.length} mejli, pobieram nagłówki…');

  // Grupujemy po autorze, w każdej grupie odpisujemy na najnowszy wątek.
  // Nadawcy nie da się poznać bez nagłówka, a ten kosztuje 20 jednostek, więc
  // przy `-n` przestajemy czytać, gdy mamy już tylu autorów, ilu obsłużymy.
  final bySender = <String, List<String>>{};
  final targets = <String, ReplyTarget>{};
  final unknownSender = <String>[];
  var urwane = false;
  for (final id in ids) {
    if (limit != null && bySender.length >= limit) {
      urwane = true;
      break;
    }
    final target = await mailbox.replyTarget(id);
    targets[id] = target;
    final sender = emailFromHeader(target.to);
    if (sender == null || sender == kInboxEmail) {
      unknownSender.add(id);
      continue;
    }
    bySender.putIfAbsent(sender, () => []).add(id);
  }
  // Urwany przegląd zna tylko część mejli wybranych autorów, a etykieta musi
  // zejść ze wszystkich. Reszta to jedno zapytanie na autora zamiast czytania
  // nagłówków całej kolejki.
  if (urwane) {
    for (final sender in bySender.keys.toList()) {
      // Nawiasy, bo `--query` z `OR` bez nich łapałby cudze mejle:
      // `a OR b from:x` to dla Gmaila `a OR (b from:x)`.
      // Zakres jak na starcie: bez tego mejl autora z innego przebiegu
      // straciłby etykietę, a uwaga do niego (w cudzym `decisions.json`)
      // nigdy by nie wyszła.
      bySender[sender] = [
        for (final id in await mailbox.listIds('($query) from:$sender'))
          if (inScope(id)) id,
      ];
      // Dopełnione mejle nie mają jeszcze nagłówków, a po id wątku szukamy
      // odpowiedzi z przeglądu — bez tego uwaga do dopełnionego mejla by
      // przepadła, a etykieta i tak by zeszła.
      for (final id in bySender[sender]!) {
        targets[id] ??= await mailbox.replyTarget(id);
      }
    }
  }

  final senders = bySender.keys.toList()..sort();
  final planned = limit == null ? senders : senders.take(limit).toList();
  for (final sender in planned) {
    final mejle = bySender[sender]!;
    stdout.writeln('  → $sender  ${mejle.length} '
        '${mejle.length == 1 ? 'mejl' : 'mejli'}  '
        'wątek [${mejle.last}]');
  }
  if (urwane) {
    stdout.writeln('  (w kolejce czekają kolejni autorzy — `-n` bierze '
        'najstarszych)');
  } else if (planned.length < senders.length) {
    stdout.writeln('  (${senders.length - planned.length} autorów poza --limit, '
        'zostają w kolejce)');
  }
  if (unknownSender.isNotEmpty) {
    stdout.writeln('Pomijam ${unknownSender.length} mejli bez czytelnego nadawcy; '
        'etykieta zostaje.');
  }

  if (!write) {
    final counts = '${planned.length} '
        '${planned.length == 1 ? 'szkic' : 'szkiców'}';
    stdout.writeln(undraft
        ? '\nDry-run: nic nie skasowano. --push skasuje $counts.'
        : draft
            ? '\nDry-run: nic nie przygotowano. --push utworzy $counts.'
            : '\nDry-run: nic nie wysłano. --push wyśle '
                '${planned.length} ${planned.length == 1 ? 'mejl' : 'mejli'}.');
    return 0;
  }

  await mailbox.ensureToolLabels();

  /// Mejl dla autora: jego uwagi z przeglądu plus blok o starej apce, jeśli
  /// któreś z jego zgłoszeń z niej przyszło. `null` = nie ma o czym pisać.
  String? messageFor(List<String> mejle) => composeContribReply(
        notes: [
          for (final id in mejle)
            if (targets[id]?.threadId case final threadId?)
              if (replies[threadId] case final note?) note,
        ].toSet(),
        oldApp: mejle.any(oldAppIds.contains),
        // Odpowiedź zaprasza do odpisania, a piosenka dosłana w tym wątku
        // przepada: wątek ma już etykietę.
        oneSongPerMail: true,
      );

  /// Etykiety po odpowiedzi: schodzą obie kolejki, wchodzi to, co się należy.
  /// Tekst z przeglądu zdejmuje też UNREAD — mejl poszedł, z Twojej strony
  /// nic już nie wisi.
  (List<String>, List<String>) labelsFor(List<String> mejle) => labelsAfterReply(
        sentReviewNote:
            mejle.any((id) => replies.containsKey(targets[id]?.threadId)),
      );

  /// Szkic autora i wątek, w którym czeka. Szukamy we wszystkich jego
  /// wątkach, nie tylko w najnowszym: mejl mógł dojść już po szkicu, a drugi
  /// szkic w innym wątku to dwa mejle do jednej osoby.
  Future<(String, ReplyTarget)?> draftOf(List<String> mejle) async {
    for (final id in mejle.reversed) {
      final target = targets[id] ?? await mailbox.replyTarget(id);
      targets[id] = target;
      if (drafts[target.threadId] case final draftId?) return (draftId, target);
    }
    return null;
  }

  if (undraft) {
    var removedCount = 0;
    var failed = 0;
    for (final sender in planned) {
      try {
        final found = await draftOf(bySender[sender]!);
        if (found == null) continue;
        await mailbox.deleteDraft(found.$1);
      } catch (e) {
        stderr.writeln('  ! $sender: $e');
        failed++;
        continue;
      }
      removedCount++;
    }
    stdout.writeln('Sprzątnięto $removedCount '
        '${removedCount == 1 ? 'szkic' : 'szkiców'}'
        '${failed == 0 ? '' : ', $failed nieudanych'}.');
    stdout.writeln('Nikt nic nie dostał — autorzy zostają w kolejce `reply`.');
    return 0;
  }

  if (draft) {
    var made = 0;
    var updated = 0;
    var already = 0;
    var nothingToSay = 0;
    var failed = 0;
    for (final sender in planned) {
      final mejle = bySender[sender]!;
      final najnowszy = mejle.last;
      final text = messageFor(mejle);
      if (text == null) {
        // Ani starej apki, ani uwagi — nie ma o czym pisać.
        nothingToSay++;
        continue;
      }
      try {
        final found = await draftOf(mejle);
        if (found case (final draftId, final target)) {
          // Szkic już jest. Doszła kolejna sprawa? Przeliczamy mejl od nowa —
          // ale tylko szkic **w naszym kształcie** (powitanie na początku,
          // „Czuwaj!” na końcu). Co innego to Twoja ręczna robota w Gmailu:
          // zostaje, a Ty dowiadujesz się, że została. Nieczytelna treść też
          // jest „nie nasza” — lepiej nic nie ruszyć, niż ruszyć w ciemno.
          final body = await mailbox.draftBody(draftId);
          if (body != null && body.trim() == text.trim()) {
            already++;
          } else if (body != null && isToolShapedReply(body)) {
            // Akapity, których w nowej treści nie będzie, wypisujemy — to
            // Twoja jedyna szansa, żeby zobaczyć, co wypadło.
            final dropped = paragraphsDroppedBy(body, text);
            await mailbox.updateDraft(draftId, target, text);
            updated++;
            for (final paragraph in dropped) {
              stdout.writeln('  ~ $sender: ze szkicu wypadło: '
                  '„${paragraph.split('\n').first}”');
            }
          } else {
            stdout.writeln('  ~ $sender: szkic '
                '${body == null ? 'nieczytelny' : 'ruszony ręcznie'} — '
                'zostawiam jak jest');
            already++;
          }
          continue;
        }
        final target =
            targets[najnowszy] ?? await mailbox.replyTarget(najnowszy);
        await mailbox.draftReplyTo(target, text);
      } catch (e) {
        // Bez szkicu, więc następny przebieg spróbuje jeszcze raz.
        stderr.writeln('  ! $sender: $e');
        failed++;
        continue;
      }
      made++;
    }
    stdout.writeln('Przygotowano $made '
        '${made == 1 ? 'szkic' : 'szkiców'}'
        '${updated == 0 ? '' : ', $updated zaktualizowanych'}'
        '${already == 0 ? '' : ', $already bez zmian'}'
        '${nothingToSay == 0 ? '' : ', $nothingToSay bez treści (pominięte)'}'
        '${failed == 0 ? '' : ', $failed nieudanych (zostają w kolejce)'}.');
    if (made > 0 || updated > 0 || already > 0) {
      stdout.writeln('Przejrzyj i popraw w Gmailu, potem: '
          './piosenkomat reply --push');
    }
    return 0;
  }

  var sent = 0;
  var skipped = 0;
  var nothingToSay = 0;
  var failed = 0;
  for (final sender in planned) {
    final mejle = bySender[sender]!;
    final najnowszy = mejle.last;
    final (add, remove) = labelsFor(mejle);
    try {
      final target =
          targets[najnowszy] ?? await mailbox.replyTarget(najnowszy);
      if (await draftOf(mejle) case (final draftId, _)) {
        // Z Twoimi poprawkami, jeśli jakieś zrobiłeś.
        await mailbox.sendDraft(draftId);
      } else if (await mailbox.ourReplyIsLatest(target.threadId)) {
        // Szkic zniknął, a ostatnie słowo w wątku jest nasze — wysłany
        // ręcznie z Gmaila. Drugiego mejla autor dostać nie może. Jeśli od
        // tamtej pory autor odpisał, to nowa sprawa: składamy mejl normalnie.
        await mailbox.batchModify(mejle, add: add, remove: remove);
        skipped++;
        continue;
      } else {
        final text = messageFor(mejle);
        if (text == null) {
          // Nic do napisania — etykiety zostają, żeby nie zgubić sprawy.
          nothingToSay++;
          continue;
        }
        await mailbox.replyTo(target, text);
      }
    } catch (e) {
      // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
      stderr.writeln('  ! $sender: $e');
      failed++;
      continue;
    }
    sent++;
    // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
    await mailbox.batchModify(mejle, add: add, remove: remove);
  }
  stdout.writeln('Wysłano $sent '
      '${sent == 1 ? 'odpowiedź' : 'odpowiedzi'}'
      '${skipped == 0 ? '' : ', $skipped już odpisanych ręcznie'}'
      '${nothingToSay == 0 ? '' : ', $nothingToSay bez treści (pominięte)'}'
      '${failed == 0 ? '' : ', $failed nieudanych (zostają w kolejce)'}.');
  return 0;
}

/// `clean [katalog] [--push]`: kasuje katalog przebiegu, gdy nie jest już
/// do niczego potrzebny.
///
/// Katalog nie jest śmieciem od razu po wgraniu piosenek. Zanim zniknie,
/// muszą się domknąć trzy rzeczy, których pilnuje ta komenda:
///
/// - **Werdykty.** Dopóki mejle przebiegu wiszą w `$kLabelReady` albo
///   `$kLabelToReview`, `label added` i `label reviewed` potrzebują planu.
/// - **Odpowiedzi do autorów.** Teksty z przeglądu żyją w `decisions.json`
///   i czyta je `reply` — czasem długo później. Katalog skasowany przed
///   wysyłką = mejl bez Twojego tekstu.
/// - **Kolejka starej apki.** `$kLabelReplyOldApp` z tego przebiegu.
///
/// Kiedy wszystko jest domknięte, zostaje sam ślad w Gmailu — a ten wystarczy.
Future<int> _clean(ArgResults cmd) async {
  final write = _write(cmd);
  final force = cmd['force'] as bool;
  final outDir = _runDir(cmd);
  if (outDir == null) return 64;
  final plan = readPlan(planPathIn(outDir));

  final mailbox = await _connect(cmd);
  final labelsById = await mailbox.songLabelsByMessage();

  // Mejle przebiegu, które wciąż na coś czekają.
  final pendingByMessage = <String, Set<String>>{};
  for (final id in plan.labelsById.keys) {
    final labels = labelsById[id] ?? const <String>{};
    final pendingLabels = {
      for (final l in labels)
        if (l == kLabelReady ||
            l == kLabelToReview ||
            l == kLabelReplyOldApp ||
            l == kLabelReplyReviewNote ||
            l.startsWith('${kLabelToReview}/'))
          l,
    };
    if (pendingLabels.isNotEmpty) pendingByMessage[id] = pendingLabels;
  }

  final files = Directory(outDir).existsSync()
      ? Directory(outDir).listSync().length
      : 0;
  stdout.writeln('Przebieg $outDir: ${plan.labelsById.length} mejli, '
      '$files plików.');

  if (pendingByMessage.isNotEmpty) {
    final counts = <String, int>{};
    for (final labels in pendingByMessage.values) {
      for (final l in labels) {
        counts[l] = (counts[l] ?? 0) + 1;
      }
    }
    stdout.writeln('Niedokończone sprawy na ${pendingByMessage.length} mejlach:');
    for (final e in (counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key)))) {
      stdout.writeln('  ${e.value.toString().padLeft(5)}  ${e.key}');
    }
    if (!force) {
      stderr.writeln('Katalog zostaje — bez niego te sprawy się nie domkną '
          '(plan etykiet, teksty odpowiedzi do autorów). --force, jeśli mimo '
          'to ma zniknąć.');
      return 1;
    }
    stdout.writeln('--force: kasuję mimo to.');
  } else {
    stdout.writeln('Wszystko domknięte — ślad został w Gmailu.');
  }

  if (!write) {
    stdout.writeln('\nDry-run: nic nie skasowano. --push skasuje $outDir.');
    return 0;
  }
  Directory(outDir).deleteSync(recursive: true);
  stdout.writeln('Skasowano $outDir.');
  return 0;
}

/// `reopen [--push]`: autorzy, którzy odpisali na Twoje pytanie.
///
/// Kolejka to „inbox bez `song/*`, **po wątkach**”, więc odpowiedź autora
/// wpada do wątku, który etykiety już ma — i `scan` jej nie widzi. Ta komenda
/// zdejmuje z takiego wątku wszystkie `song/*`, żeby wrócił do kolejki jako
/// zwykłe zgłoszenie i przeszedł normalny przesiew z nowymi chwytami.
///
/// Bierze wątki z „$kLabelWaitingForAuthor”, w których po naszej ostatniej
/// wiadomości pojawiła się przychodząca.
Future<int> _reopen(ArgResults cmd) async {
  final write = _write(cmd);
  final mailbox = await _connect(cmd);
  final query = cmd['query'] as String? ??
      'label:${labelQueryName(kLabelWaitingForAuthor)}';
  final ids = await mailbox.listIds(query);
  if (ids.isEmpty) {
    stdout.writeln('Nikogo nie pytaliśmy albo nikt jeszcze nie odpisał.');
    return 0;
  }
  stdout.writeln('Zapytanych: ${ids.length} mejli, sprawdzam wątki…');

  final threads = <String>{};
  for (final id in ids) {
    threads.add((await mailbox.replyTarget(id)).threadId);
  }
  final answered = <String>[];
  for (final threadId in threads) {
    if (await mailbox.hasIncomingAfterOurReply(threadId)) {
      answered.add(threadId);
    }
  }
  if (answered.isEmpty) {
    stdout.writeln('Nikt jeszcze nie odpisał (${threads.length} wątków czeka).');
    return 0;
  }

  final labelsById = await mailbox.songLabelsByMessage();
  final labelsToRemove = <String, List<String>>{};
  final firstMessageOf = <String, String>{};
  var closedCount = 0;
  for (final threadId in answered.toList()) {
    final ids = await mailbox.threadMessageIds(threadId);
    // Piosenka już w apce → nie ma czego przesiewać na nowo. „Dzięki” od
    // autora to nie zgłoszenie, a poprawkę przysyła się z apki, jako nową.
    final inApp = ids.any((id) =>
        (labelsById[id] ?? const <String>{}).contains(kLabelDone));
    if (inApp) {
      answered.remove(threadId);
      closedCount++;
      continue;
    }
    firstMessageOf[threadId] = ids.first;
    for (final id in ids) {
      // Zdejmujemy wszystkie `song/*`. Bloku o starej apce `scan` drugi raz
      // nie zapyta: autor dostał już od nas odpowiedź.
      final labels = [...?labelsById[id]?.where(isSongLabel)];
      if (labels.isNotEmpty) labelsToRemove[id] = labels;
    }
  }
  if (closedCount > 0) {
    stdout.writeln('Pomijam $closedCount '
        '${closedCount == 1 ? 'wątek' : 'wątków'} z „$kLabelDone” — piosenka '
        'już w apce, odpowiedź to nie nowe zgłoszenie.');
  }
  if (answered.isEmpty) {
    stdout.writeln('Nic do cofnięcia do kolejki.');
    return 0;
  }
  stdout.writeln('Odpisali w ${answered.length} '
      '${answered.length == 1 ? 'wątku' : 'wątkach'} — '
      '${labelsToRemove.length} mejli wróci do kolejki:');
  for (final threadId in answered) {
    final headers = await mailbox.headersOf(firstMessageOf[threadId]!);
    stdout.writeln('  ${headers.subject}  ${headers.from}  [$threadId]');
  }
  if (!write) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push zdejmie etykiety '
        '„song/*”, żeby `scan` zobaczył te wątki na nowo.');
    return 0;
  }
  for (final e in labelsToRemove.entries) {
    await mailbox.batchModify([e.key], remove: e.value);
  }
  stdout.writeln('Zdjęto etykiety z ${labelsToRemove.length} mejli. '
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

/// Narzędzie działa w `tool/piosenkomat/`, ale użytkownik podaje ścieżki
/// z katalogu, w którym wpisał `./piosenkomat` (przekazany w PIOSENKOMAT_CWD).
/// Katalog przebiegu z argumentu, a bez argumentu — ostatni z `out/`.
String? _runDir(ArgResults cmd) {
  if (cmd.rest.length > 1) {
    stderr.writeln('Podaj jeden katalog przebiegu albo żaden (weźmie ostatni).');
    return null;
  }
  if (cmd.rest.length == 1) {
    final arg = _resolve(cmd.rest.single);
    if (!FileSystemEntity.isDirectorySync(arg)) {
      stderr.writeln('To nie jest katalog przebiegu: $arg');
      return null;
    }
    return arg;
  }
  final latest = latestOutDir();
  if (latest == null) {
    stderr.writeln('Nie ma żadnego przebiegu w out/. Najpierw: ./piosenkomat scan');
    return null;
  }
  final dir = _resolve(latest);
  stdout.writeln('Ostatni przebieg: $dir');
  return dir;
}

String? _planPath(ArgResults cmd) {
  final dir = _runDir(cmd);
  return dir == null ? null : planPathIn(dir);
}

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
String _day(DateTime d) => d.toLocal().toIso8601String().substring(0, 10);

Map<String, int> _tally(Iterable<String> keys) {
  final counts = <String, int>{};
  for (final k in keys) {
    counts[k] = (counts[k] ?? 0) + 1;
  }
  return counts;
}

/// Wiersze `  liczba  klucz`, po kluczu; [byCount] daje najliczniejsze pierwsze.
void _countLines(StringSink out, Map<String, int> counts, {bool byCount = false}) {
  final rows = counts.entries.toList()
    ..sort((a, b) {
      final c = byCount ? b.value.compareTo(a.value) : 0;
      return c != 0 ? c : a.key.compareTo(b.key);
    });
  for (final e in rows) {
    out.writeln('  ${e.value.toString().padLeft(4)}  ${e.key}');
  }
}

/// Raport przebiegu (konsola i `report.txt`): liczby, uwagi i ich wiązki,
/// potem lista zgłoszeń z tym, gdzie trafiły i co im automat zarzuca.
String formatRunReport(List<Classified> items) {
  int count(bool Function(Classified) test) => items.where(test).length;
  final unparsed = count((c) => c.target == Target.unparsable);
  final newFile = [for (final c in items) if (c.goesToFile && !c.submission.isCorrection) c];
  final corrFile = [for (final c in items) if (c.goesToFile && c.submission.isCorrection) c];

  final buf = StringBuffer()
    ..writeln('ZGŁOSZEŃ        ${items.length}  (wątków)')
    ..writeln('NIE SPARSOWANE  $unparsed')
    ..writeln('NOWE            ${newFile.length}  (candidates-new.hrcpsng)')
    ..writeln('  bez zarzutu   ${newFile.where((c) => c.issues.isEmpty).length}')
    ..writeln('  z uwagami     ${newFile.where((c) => c.issues.isNotEmpty).length}')
    ..writeln('POPRAWKI        ${corrFile.length}  (candidates-correction.hrcpsng)')
    ..writeln('  bez zarzutu   ${corrFile.where((c) => c.issues.isEmpty).length}')
    ..writeln('  z uwagami     ${corrFile.where((c) => c.issues.isNotEmpty).length}')
    ..writeln('ODRZUĆ          ${count((c) => c.target.isReject)}')
    ..writeln('  już w apce    ${count((c) => c.target == Target.rejectAlreadyInApp)}')
    ..writeln('  duplikat      ${count((c) => c.target == Target.rejectDuplicate)}')
    ..writeln('  zły załącznik ${count((c) => c.target == Target.rejectBrokenFile)}')
    ..writeln('RZUĆ OKIEM      ${count((c) => c.haveALook)}'
        '  (odrzut, ale autor coś napisał albo mejla nie da się odczytać)')
    ..writeln('STARA APKA      ${count((c) => c.submission.isOldApp)}'
        '  (do odpisania: ./piosenkomat reply)');

  // Rozkład kształtów mejla mówi, kiedy wolno skasować czytniki starych
  // formatów; rozkład wersji apki — jak szybko ludzie aktualizują.
  buf.writeln();
  buf.writeln('Kształt mejla:');
  _countLines(buf, _tally([for (final c in items) c.submission.shape.id]), byCount: true);
  final versions = _tally([
    for (final c in items)
      if (c.submission.appVersion case final v?) v,
  ]);
  if (versions.isNotEmpty) {
    buf.writeln('Wersja apki:');
    _countLines(buf, versions, byCount: true);
  }

  final issuesOf = [
    for (final c in items)
      if (c.issues.isNotEmpty) [for (final i in c.issues) i.issue.id],
  ];
  if (issuesOf.isNotEmpty) {
    buf.writeln();
    buf.writeln('Uwagi (jedno zgłoszenie może mieć kilka):');
    _countLines(buf, _tally(issuesOf.expand((r) => r)), byCount: true);
    final bundles = _tally([for (final r in issuesOf) if (r.length > 1) r.join(' + ')]);
    if (bundles.isNotEmpty) {
      buf.writeln('Kilka uwag naraz:');
      _countLines(buf, bundles, byCount: true);
    }
  }

  final byDate = [...items]..sort((a, b) =>
      (a.submission.sentAt ?? DateTime(0)).compareTo(b.submission.sentAt ?? DateTime(0)));
  buf.writeln();
  for (final c in byDate) {
    final s = c.submission;
    final tag = switch (c.target) {
      Target.candidateNew => 'NOWA    ',
      Target.candidateCorrection => 'POPRAWKA',
      Target.rejectAlreadyInApp ||
      Target.rejectDuplicate ||
      Target.rejectBrokenFile =>
        'ODRZUĆ  ',
      Target.unparsable => 'NIEPARS ',
    };
    final date = s.sentAt == null ? '' : _day(s.sentAt!);
    final threads = s.messages.length > 1 ? '  (${s.messages.length} wiadomości)' : '';
    buf.writeln('$tag ${c.title}  ${s.sender ?? ''}  $date  [${s.message.id}]$threads'
        '${s.isOldApp ? '  (stara apka)' : ''}');
    buf.writeln('         → ${c.labels.join(', ')}');
    if (c.decision.detail case final d?) buf.writeln('         $d');
    for (final i in c.issues) {
      buf.writeln('         ${i.issue.id}'
          '${i.detail == null ? '' : ': ${i.detail!.split('\n').first}'}');
    }
    if (s.hasUserMessage) {
      buf.writeln('         dopisek: ${s.userMessage!.split('\n').first}');
    }
    if (s.correctionMessage case final m?) {
      buf.writeln('         poprawka: ${m.split('\n').first}');
    }
  }
  return buf.toString();
}

String _usage(ArgParser parser) => '''
piosenkomat: sitko mejli z piosenkami na $kInboxEmail.

  ./piosenkomat scan [-n N] [--newest] [-o katalog]
      kolejka (inbox bez song/*, po wątkach) → katalog out/import-<data>/:
      raport, plan, candidates-new.hrcpsng, candidates-correction.hrcpsng
      (uwagi przy piosenkach), reviewed-*.hrcpsng. Gmaila tylko czyta
  ./piosenkomat label scanned [katalog] --push
      werdykty automatu na mejle: „$kLabelReady”, „song/rejected/…”,
      „$kLabelToReview”, wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat label reviewed [katalog] --push
      co jest w reviewed-*.hrcpsng → „$kLabelReady”, czego nie ma →
      „$kLabelRejectedAfterReview”; obce piosenki i dwie poprawki tego samego → STOP
  ./piosenkomat label added [katalog] --push
      „$kLabelReady” + „$kLabelAuto” → „$kLabelDone” + przeczytane
  ./piosenkomat unlabel [katalog] --push
      cofa wszystko, co nadał automat („$kLabelAuto”); z katalogiem — tylko
      mejle z jego planu
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
