import 'dart:io';

import 'package:args/args.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
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

  final explain = parser.addCommand('explain');
  _addCommon(explain);

  // Stare nazwy: działają po cichu, nie ma ich w pomocy. Dostają `--push`
  // nawet tam, gdzie dzisiejsza komenda go nie ma (`process --apply`), żeby
  // stare notatki nie wywalały się na parserze.
  for (final e in _aliases.entries) {
    final a = parser.addCommand(e.key);
    _optionsOf[e.value]?.call(a);
    _addCommon(a);
    _addWrite(a, hidden: true);
  }

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
    stdout.writeln(_usage(parser));
    return cmd == null && !(opts['help'] as bool) ? 64 : 0;
  }

  var name = _aliases[cmd.name] ?? cmd.name;
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
      case 'explain':
        return _explain(cmd);
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

/// Nazwy sprzed przemianowania → dzisiejsze komendy.
const Map<String, String> _aliases = {
  'process': 'scan',
  'apply': 'label scanned',
  'review': 'label reviewed',
  'commit': 'label added',
  'unapply': 'unlabel',
  'check': 'explain',
};

/// Opcje komend, wspólne dla nazwy dzisiejszej i aliasu.
void _scanOptions(ArgParser p) => p
  ..addOption('limit',
      abbr: 'n', help: 'Ile mejli z kolejki (domyślnie wszystkie)')
  ..addFlag('newest',
      negatable: false, help: 'Najnowsze N zamiast najstarszych')
  ..addOption('out',
      abbr: 'o', help: 'Katalog przebiegu (domyślnie out/import-<data>)')
  ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');

void _reviewedOptions(ArgParser p) => p
  ..addOption('reviewed',
      help: 'Plik po przeglądzie (domyślnie reviewed.hrcpsng w katalogu)')
  // Nazwa sprzed przemianowania pliku.
  ..addOption('approved', hide: true)
  ..addFlag('force',
      negatable: false,
      help: 'Pomiń bezpieczniki (pusty plik, odrzucona większość)');

void _unlabelOptions(ArgParser p) => p.addFlag('force',
    negatable: false,
    help: 'Zdejmij też z domkniętych („song/added”)');

void _replyOptions(ArgParser p) => p
  ..addOption('limit', abbr: 'n', help: 'Ilu autorom odpisać w tym przebiegu')
  ..addOption('query', help: 'Własne query Gmaila zamiast kolejki odpowiedzi');

const Map<String, void Function(ArgParser)> _optionsOf = {
  'scan': _scanOptions,
  'label reviewed': _reviewedOptions,
  'unlabel': _unlabelOptions,
  'reply': _replyOptions,
};

/// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
/// „wypchnij to, co widzisz na sucho, do skrzynki”. `--write` i `--apply`
/// zostają ukrytymi synonimami, żeby stare notatki dalej działały.
void _addWrite(ArgParser p, {String? help, bool hidden = false}) => p
  ..addFlag('push', abbr: 'p', negatable: false, hide: hidden, help: help)
  ..addFlag('write', negatable: false, hide: true)
  ..addFlag('apply', negatable: false, hide: true);

bool _write(ArgResults cmd) =>
    (cmd['push'] as bool) || (cmd['write'] as bool) || (cmd['apply'] as bool);

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
  final messages = fetched
      .where((m) => !m.hasSongLabel && m.isSongSubmission)
      .toList();
  if (messages.length != fetched.length) {
    stdout.writeln('Pominięto ${fetched.length - messages.length} mejli '
        '(już otagowane albo nie o piosence), zostają bez zmian.');
  }

  final classified = classifyBatch(messages, book: book);
  final report = formatRunReport(classified);
  stdout.writeln();
  stdout.write(report);

  final outDir = cmd['out'] as String? ?? defaultOutDir();
  final run = p.basename(outDir);
  final planPath = planPathIn(outDir);
  final reportPath = reportPathIn(outDir);
  writeText(reportPath, report);

  // Dwa pliki, bo to dwie różne roboty: `auto` przelatujesz, `review`
  // czytasz po kolei. Uwagi jadą w piosenkach, więc edytor pokaże przy każdej,
  // co jest z nią nie tak.
  final auto = [for (final c in classified) if (c.goesToApp) c.song!];
  final review = [for (final c in classified) if (c.goesToReview) c.song!];
  // Razem, bo `reviewed.hrcpsng` też jest jednym plikiem z obu.
  assignUniqueIds([...auto, ...review]);
  for (final c in classified) {
    if (c.song case final song?) {
      song.piosenkomatData = c.piosenkomatData(run: run);
    }
  }

  final files = <RunFile, String>{
    if (auto.isNotEmpty) RunFile.auto: autoPathIn(outDir),
    if (review.isNotEmpty) RunFile.review: reviewPathIn(outDir),
  };
  final plan = LabelPlan.fromClassified(classified, files: files);
  writePlan(planPath, plan);

  if (auto.isNotEmpty) {
    writeHrcpsng(autoPathIn(outDir), auto, withPiosenkomatData: true);
    stdout.writeln('\nBez zarzutu: ${auto.length} piosenek → ${autoPathIn(outDir)}');
  }
  if (review.isNotEmpty) {
    writeHrcpsng(reviewPathIn(outDir), review, withPiosenkomatData: true);
    stdout.writeln('Do przeglądu: ${review.length} piosenek → ${reviewPathIn(outDir)}');
    stdout.writeln('  (każda niesie swoje uwagi — edytor pokaże je nad piosenką)');
  }

  if (auto.isNotEmpty || review.isNotEmpty) {
    stdout.writeln('Wczytaj oba pliki na stronie ze śpiewnikiem.');
    // Miejsce na eksport: wrzucasz tu jeden plik z obu, a `label reviewed`
    // z różnicy wyciąga odrzucone i nieogarnięte.
    final reviewedPath = reviewedPathIn(outDir);
    writeHrcpsng(reviewedPath, [...auto, ...review], withPiosenkomatData: true);
    stdout.writeln('Po przeglądzie podmień $reviewedPath eksportem ze strony '
        'i odpal: ./piosenkomat label reviewed $outDir');

    final people = collectPeople(classified);
    final peoplePath = peoplePathIn(outDir);
    writePeopleDart(peoplePath, people);
    stdout.writeln('Osoby dodające: ${people.newContributors.length} nowych → $peoplePath'
        '${people.knownByEmail.isEmpty ? '' : ', ${people.knownByEmail.length} już w data.dart'}'
        '${people.anonymousByEmail.isEmpty ? '' : ', ${people.anonymousByEmail.length} bez bloku osoby'}');
    if (people.newContributors.isNotEmpty) {
      stdout.writeln('Doklej nowe do lib/values/people/data.dart.');
    }
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
  stdout.writeln('${_planHeader(plan)}, pliki: '
      '${plan.files.values.join(', ')}');
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
  // Znacznik `auto` albo etykieta z wcześniejszej wersji narzędzia — tę drugą
  // trzeba złapać osobno, bo po zdjęciu `auto` nie ma już po czym poznać,
  // że to ślad automatu.
  final byAutomat = {
    for (final e in currentById.entries)
      if (e.value.contains(kLabelAuto) || e.value.any(kLegacyToolLabels.contains))
        e.key: e.value,
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
    // „Odpisano" zostaje: to jedyny ślad, że autor już dostał mejla o starej
    // apce. Bez niego wróciłby do kolejki `to-reply` i dostał drugi.
    toRemove[e.key] = [
      for (final l in [...kToolLabels, ...kLegacyToolLabels])
        if (e.value.contains(l) && (force || l != kLabelOldAppReplied)) l,
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
  if (!force) {
    stdout.writeln('„$kLabelOldAppReplied” zostaje — autor już dostał odpowiedź. '
        '--force, jeśli ma zejść.');
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
  stdout.writeln('Po przeglądzie na stronie podmień reviewed.hrcpsng, potem '
      './piosenkomat label reviewed --push i ./piosenkomat label added --push');
}

/// Piosenki z ostatniego przebiegu, po id mejla. Służą tylko do wypisania
/// tytułu i nadawcy — gdy planu nie ma albo jest niekompletny, `label added`
/// dopyta Gmaila.
Map<String, PlannedSong> _songsFromLatestPlan() {
  final dir = latestOutDir();
  if (dir == null) return const {};
  final path = planPathIn(_resolve(dir));
  if (!_exists(path)) return const {};
  try {
    return {
      for (final e in readPlan(path).songsById.entries)
        if (e.value.isNotEmpty) e.key: e.value.first,
    };
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
    // Werdykt domykający sprawę zdejmuje też „nieprzeczytane”.
    await mailbox.batchModify(ids,
        add: labels,
        remove: labels.any(isClosedLabel) ? const ['UNREAD'] : null);
  }
}

Future<int> _labelAdded(ArgResults cmd) async {
  final write = _write(cmd);
  final mailbox = await _connect(cmd);
  final current = await mailbox.songLabelsByMessage();
  // Bezpiecznik na wypadek, gdyby query przepuściło coś bez „auto”: ruszamy
  // tylko to, co automat sam wstawił do pliku. Sam zestaw etykiet wystarczy,
  // żeby wiedzieć, co jest gotowe — bez osobnego zapytania do Gmaila.
  final ready = [
    for (final e in current.entries)
      if (isReadyByTool(e.value)) e.key,
  ];
  // Tytuł i nadawcę bierzemy z planu przebiegu — leżą w `labels.json` za darmo.
  // Dopytujemy Gmaila tylko o mejle spoza planu (20 jednostek za sztukę).
  final zPlanu = _songsFromLatestPlan();
  for (final id in ready) {
    if (zPlanu[id] case final i?) {
      stdout.writeln('  ${i.title}  ${i.sender}  [$id]');
    } else {
      final h = await mailbox.headersOf(id);
      stdout.writeln('  ${h.subject}  ${emailFromHeader(h.from) ?? ''}  [$id]');
    }
  }
  stdout.writeln('„$kLabelReady” + „$kLabelAuto”: ${ready.length} mejli');
  if (!write) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --push zmieni na „$kLabelDone” + przeczytane.');
    return 0;
  }
  await mailbox.ensureToolLabels();
  await mailbox.batchModify(ready,
      add: [kLabelDone], remove: [kLabelReady, 'UNREAD']);
  stdout.writeln('Zatwierdzono ${ready.length} mejli.');
  return 0;
}

/// `label reviewed [katalog] [--push]`: różnica między tym, co automat
/// wstawił do plików przebiegu, a tym, co zostało po Twoim przeglądzie.
///
/// Piosenka ma trzy stany i każdy znaczy co innego dla mejla:
///  - wróciła bez uwag → „$kLabelReady”, czeka na `label added`,
///  - wróciła z uwagami → z powrotem „$kLabelToReview” plus podkategorie tych
///    uwag, które zostały (zdjęcie uwagi w edytorze to Twoja decyzja),
///  - nie wróciła → „$kLabelRejectedAfterReview”.
///
/// Mejl zmienia stan tylko wtedy, gdy dotyczy go los wszystkich jego piosenek.
Future<int> _labelReviewed(ArgResults cmd) async {
  final outDir = _runDir(cmd);
  if (outDir == null) return 64;
  final force = cmd['force'] as bool;
  final plan = readPlan(planPathIn(outDir));
  final reviewedPath = _resolve(cmd['reviewed'] as String? ??
      // `--approved` i `approved.hrcpsng`: nazwy sprzed przemianowania.
      cmd['approved'] as String? ??
      _pickReviewedFile(outDir));

  final proposed = collectProposed(plan, _runFileSongs(outDir, plan));
  if (proposed.isEmpty) {
    stderr.writeln('Ten przebieg nic nie wstawił do plików, nie ma co porównywać.');
    return 1;
  }
  final reviewed = readHrcpsng(reviewedPath);
  stdout.writeln('Przebieg $outDir: ${proposed.length} w plikach, '
      '${reviewed.length} w $reviewedPath');

  final result = reviewDiff(proposed: proposed, reviewed: reviewed);
  final decisionsPath = decisionsPathIn(outDir);
  writeDecisions(decisionsPath, reviewedPath: reviewedPath, result: result);
  _printReview(result);
  stdout.writeln('Ślad przeglądu: $decisionsPath');

  // Bezpieczniki na zły plik: pusty eksport i „odrzucona większość” prawie
  // zawsze znaczą, że podmieniony został nie ten plik, co trzeba.
  if (!force && reviewed.isEmpty) {
    stderr.writeln('\n$reviewedPath jest pusty — to wygląda na pomyłkę. '
        'Jeśli naprawdę odrzucasz wszystko: --force.');
    return 1;
  }
  if (!force && result.rejected.length * 2 > proposed.length) {
    stderr.writeln('\nOdrzucone to ponad połowa przebiegu '
        '(${result.rejected.length}/${proposed.length}) — sprawdź, czy podmieniłeś '
        'właściwy plik. Jeśli tak ma być: --force.');
    return 1;
  }
  // Zgubione pole to nie to samo, co ogarnięte uwagi: gdyby strona wyrzuciła
  // `piosenkomat` przy eksporcie, wszystko wyglądałoby na załatwione.
  if (!force && result.lostIssues) {
    stderr.writeln('\nŻadna piosenka nie wróciła ze śladem piosenkomatu, choć '
        'jechały z uwagami — eksport prawdopodobnie zgubił pole „piosenkomat”. '
        'Jeśli naprawdę ogarnąłeś wszystko: --force.');
    return 1;
  }

  final changes = _reviewLabelChanges(result, plan);
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
  // Przy garstce taniej zapytać o każdy mejl (20 jednostek), przy większej
  // liczbie — raz o całą skrzynkę (jedno zapytanie na etykietę `song/*`).
  final current = <String, Set<String>>{};
  if (changes.length > 5) {
    current.addAll(await mailbox.songLabelsByMessage());
  } else {
    for (final id in changes.keys) {
      current[id] = await mailbox.labelsOf(id);
    }
  }

  // Mejle o tej samej zmianie idą jedną paczką (`batchModify` bierze do 1000),
  // inaczej każdy kosztuje osobne zapytanie i przy setkach Gmail dławi.
  final groups = <String, (List<String>, List<String>, List<String>)>{};
  var skipped = 0;
  for (final e in changes.entries) {
    final labels = current[e.key] ?? const <String>{};
    if (!isInRunFilesByTool(labels)) {
      skipped++;
      continue;
    }
    final (add, remove) = e.value;
    // Odrzucone i wchodzące do apki są domknięte z Twojej strony;
    // te z niezdjętymi uwagami dalej czekają, więc zostają nieprzeczytane.
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

/// Piosenki z plików przebiegu: `auto` i `review`, a w starszych katalogach
/// jeden `songs.hrcpsng`.
List<SongRaw> _runFileSongs(String outDir, LabelPlan plan) {
  final paths = <String>{
    for (final path in plan.files.values) _resolve(path),
    autoPathIn(outDir),
    reviewPathIn(outDir),
    legacySongsPathIn(outDir),
  };
  return [
    for (final path in paths)
      if (_exists(path)) ...readHrcpsng(path),
  ];
}

/// Co zrobić z etykietami każdego mejla po przeglądzie: `(dodaj, zdejmij)`.
Map<String, (List<String>, List<String>)> _reviewLabelChanges(
  ReviewResult result,
  LabelPlan plan,
) {
  final out = <String, (List<String>, List<String>)>{};

  for (final id in result.rejectedMsgIds) {
    out[id] = ([kLabelRejectedAfterReview], [kLabelReady, ...kReviewLabels]);
  }
  for (final e in result.unresolvedLabels.entries) {
    out[e.key] = (
      e.value,
      [kLabelReady, ...kReviewLabels.where((l) => !e.value.contains(l))],
    );
  }
  for (final id in result.acceptedMsgIds) {
    // Piosenki bez zarzutu już mają „w pliku” — ruszamy tylko te, które
    // wyszły z przeglądu.
    final wasInReview = (plan.labelsById[id] ?? const []).contains(kLabelToReview);
    if (!wasInReview) continue;
    out[id] = ([kLabelReady], kReviewLabels);
  }
  return out;
}

/// Co weszło, co dalej czeka, co wypadło i co rozpoznane inaczej niż po id mejla.
void _printReview(ReviewResult result) {
  stdout.writeln();
  stdout.writeln('WCHODZI      ${result.accepted.length}');
  stdout.writeln('DALEJ CZEKA  ${result.unresolved.length}');
  stdout.writeln('ODRZUCONE    ${result.rejected.length}');
  for (final m in result.unresolved) {
    stdout.writeln('  CZEKA   ${m.reviewedTitle}  [${m.proposed.msgId}]  '
        '${m.remaining.map((i) => i.text).join('; ')}');
  }
  for (final r in result.rejected) {
    stdout.writeln('  ODRZUĆ  ${r.title}  [${r.msgId}]');
  }
  if (result.unknown.isNotEmpty) {
    stdout.writeln('Spoza przebiegu, pomijam: ${result.unknown.length}');
    for (final t in result.unknown) {
      stdout.writeln('  ?       $t');
    }
  }
  // Kto z people.dart został tylko przy odrzuconych piosenkach — jego wpisu
  // nie ma po co doklejać do data.dart.
  final dropped = {for (final r in result.rejected) r.sender}
    ..removeAll({
      for (final m in [...result.accepted, ...result.unresolved]) m.proposed.sender
    })
    ..remove('');
  if (dropped.isNotEmpty) {
    stdout.writeln('Tylko odrzucone piosenki (pomiń w people.dart): '
        '${dropped.join(', ')}');
  }
  final byOther = [
    for (final m in [...result.accepted, ...result.unresolved])
      if (m.kind != MatchKind.emailMsgId) m,
  ];
  if (byOther.isNotEmpty) {
    stdout.writeln('Rozpoznane inaczej niż po id mejla '
        '(tytuł mógł się zmienić przy przeglądzie): ${byOther.length}');
    for (final m in byOther) {
      stdout.writeln('  ${m.kind.text.padRight(12)} ${m.proposed.title}'
          '${m.reviewedTitle == m.proposed.title ? '' : ' → ${m.reviewedTitle}'}');
    }
  }
  for (final e in result.partial.entries) {
    stdout.writeln('UWAGA: z mejla [${e.key}] część piosenek weszła, a część nie '
        '(${e.value.map((s) => s.title).join(', ')}). Etykiety zostawiam Tobie.');
  }
}

/// `reply [--push]`: autorom ze starej apki wiadomość, żeby ją zaktualizowali.
///
/// Kolejką jest sam Gmail: etykieta „$kLabelOldAppToReply”, którą wiesza
/// `label scanned --push`. Wysyłka ją zdejmuje i wiesza „$kLabelOldAppReplied”,
/// więc nikt nie dostanie dwóch odpowiedzi, a przerwany przebieg dokańcza się
/// zwykłym powtórzeniem komendy.
///
/// Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek ze starej
/// apki, dostaje jeden mejl w najnowszym wątku, a etykieta schodzi ze wszystkich.
Future<int> _reply(ArgResults cmd) async {
  final write = _write(cmd);
  final limit = _limit(cmd);

  final mailbox = await _connect(cmd, needsSend: true);
  final query = cmd['query'] as String? ??
      'label:${labelQueryName(kLabelOldAppToReply)}';
  final ids = await mailbox.listIds(query);
  if (ids.isEmpty) {
    stdout.writeln('Nikt nie czeka na odpowiedź.');
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
      bySender[sender] = await mailbox.listIds('($query) from:$sender');
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
    stdout.writeln('\nDry-run: nic nie wysłano. --push wyśle '
        '${planned.length} ${planned.length == 1 ? 'mejl' : 'mejli'}.');
    return 0;
  }

  await mailbox.ensureToolLabels();
  var sent = 0;
  var failed = 0;
  for (final sender in planned) {
    final mejle = bySender[sender]!;
    final najnowszy = mejle.last;
    try {
      final target =
          targets[najnowszy] ?? await mailbox.replyTarget(najnowszy);
      await mailbox.replyTo(target, oldestFormatReplyMessage);
    } catch (e) {
      // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
      stderr.writeln('  ! $sender: $e');
      failed++;
      continue;
    }
    sent++;
    // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
    await mailbox.batchModify(mejle,
        add: [kLabelOldAppReplied], remove: [kLabelOldAppToReply]);
  }
  stdout.writeln('Wysłano $sent '
      '${sent == 1 ? 'odpowiedź' : 'odpowiedzi'}'
      '${failed == 0 ? '' : ', $failed nieudanych (zostają w kolejce)'}.');
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
/// Dla wygody przyjmuje też ścieżkę do pliku w środku (np. `labels.json`),
/// bo tak wyglądały wywołania sprzed przemianowania.
String? _runDir(ArgResults cmd) {
  if (cmd.rest.length > 1) {
    stderr.writeln('Podaj jeden katalog przebiegu albo żaden (weźmie ostatni).');
    return null;
  }
  if (cmd.rest.length == 1) {
    final arg = _resolve(cmd.rest.single);
    return FileSystemEntity.isDirectorySync(arg) ? arg : p.dirname(arg);
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

/// `reviewed.hrcpsng`, a w katalogach sprzed przemianowania `approved.hrcpsng`.
String _pickReviewedFile(String outDir) {
  final now = reviewedPathIn(outDir);
  if (_exists(now)) return now;
  final legacy = legacyReviewedPathIn(outDir);
  return _exists(legacy) ? legacy : now;
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

bool _unparsed(Classified c) => c.has(SongIssue.parseError);

/// Raport przebiegu (konsola i `report.txt`): liczby, uwagi i ich wiązki,
/// potem lista mejli z tym, gdzie trafiły i co im automat zarzuca.
String formatRunReport(List<Classified> items) {
  final auto = items.where((c) => c.goesToApp).toList()
    ..sort((a, b) => (a.message.date ?? DateTime(0))
        .compareTo(b.message.date ?? DateTime(0)));
  final review = [for (final c in items) if (c.goesToReview) c];
  final rejected = [for (final c in items) if (c.isAutoReject) c];
  final unparsed = items.where(_unparsed).length;

  final buf = StringBuffer()
    ..writeln('SKLASYFIKOWANO  ${items.length}')
    ..writeln('SPARSOWANE      ${items.length - unparsed}')
    ..writeln('NIE SPARSOWANE  $unparsed')
    ..writeln('BEZ ZARZUTU     ${auto.length}  (auto.hrcpsng)')
    ..writeln('DO PRZEGLĄDU    ${review.length}  (review.hrcpsng)')
    ..writeln('ODRZUĆ          ${rejected.length}')
    ..writeln('STARA APKA      ${items.where((c) => c.oldApp).length}'
        '  (do odpisania: ./piosenkomat reply)');

  final issuesOf = [
    for (final c in items)
      if (c.toResolve.isNotEmpty && !_unparsed(c))
        [for (final i in c.toResolve) i.issue.text],
  ];
  if (issuesOf.isNotEmpty) {
    buf.writeln();
    buf.writeln('Co automat ma do zarzucenia '
        '(jedno zgłoszenie może mieć kilka uwag):');
    _countLines(buf, _tally(issuesOf.expand((r) => r)), byCount: true);
    final only = _tally([for (final r in issuesOf) if (r.length == 1) r.single]);
    if (only.isNotEmpty) {
      buf.writeln('Jedyna uwaga do zgłoszenia '
          '(zdejmij ją i piosenka wchodzi):');
      _countLines(buf, only, byCount: true);
    }
    final bundles = _tally([for (final r in issuesOf) if (r.length > 1) r.join('; ')]);
    if (bundles.isNotEmpty) {
      buf.writeln('Kilka uwag naraz:');
      _countLines(buf, bundles, byCount: true);
    }
  }

  if (auto.isNotEmpty) buf.writeln();
  for (final c in auto) {
    final date = c.message.date == null ? '' : _day(c.message.date!);
    buf.writeln('APKA     ${c.title}  ${c.sender ?? ''}  $date  [${c.message.id}]'
        '${c.oldApp ? '  (stara apka)' : ''}');
  }

  final rest = [for (final c in items) if (!c.goesToApp) c];
  if (rest.isNotEmpty) buf.writeln();
  for (final c in rest) {
    final tag = c.isAutoReject
        ? 'ODRZUĆ  '
        : c.goesToReview
            ? 'PRZEGLĄD'
            : 'MEJL    ';
    buf.writeln('$tag ${c.title}  [${c.message.id}]  '
        '${c.toResolve.map((i) => i.issue.text).join('; ')}'
        '${c.oldApp ? '  (stara apka)' : ''}');
    final labels = stateLabelsFor(c);
    // Przy przeglądzie sama `needs-review` nic nie mówi — liczą się podkategorie.
    buf.writeln('         → ${(c.isAutoReject ? labels : labels.skip(1)).join(', ')}'
        '${c.oldApp ? ', $kLabelOldAppToReply' : ''}');
    for (final i in c.issues) {
      if (i.detail case final detail?) {
        buf.writeln('         ${i.issue.text}: ${detail.split('\n').first}');
      }
    }
  }
  return buf.toString();
}

String _usage(ArgParser parser) => '''
piosenkomat: sitko mejli z piosenkami na $kInboxEmail.

  ./piosenkomat scan [-n N] [--newest] [-o katalog]
      kolejka (inbox bez song/*) → katalog out/import-<data>/: raport, plan,
      auto.hrcpsng (bez zarzutu), review.hrcpsng (z uwagami przy piosenkach),
      reviewed.hrcpsng, people.dart. Gmaila tylko czyta
  ./piosenkomat label scanned [katalog] --push
      werdykty automatu na mejle: „$kLabelReady”, „song/rejected/…”,
      „$kLabelToReview”, wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat label reviewed [katalog] --push
      co wróciło w reviewed.hrcpsng bez uwag → „$kLabelReady”, z uwagami →
      z powrotem „$kLabelToReview”, czego nie ma → „$kLabelRejectedAfterReview”
  ./piosenkomat label added [katalog] --push
      „$kLabelReady” + „$kLabelAuto” → „$kLabelDone” + przeczytane
  ./piosenkomat unlabel [katalog] --push
      cofa wszystko, co nadał automat („$kLabelAuto”); z katalogiem — tylko
      mejle z jego planu
  ./piosenkomat reply [-n N] --push
      autorom ze starej apki: „zaktualizuj apkę”; kolejką jest etykieta
      „$kLabelOldAppToReply”, wysyłka przestawia ją na „$kLabelOldAppReplied”
  ./piosenkomat explain plik.eml [...]
      klasyfikacja lokalnych plików, bez Gmaila

Bez katalogu komendy biorą ostatni przebieg z out/.
Bez --push nic w Gmailu się nie zmienia.

scan:
${parser.commands['scan']!.usage}

label reviewed:
${parser.commands['label']!.commands['reviewed']!.usage}

unlabel:
${parser.commands['unlabel']!.usage}
''';
