import 'dart:io';

import 'package:args/args.dart';
import 'package:harcapp_core/song_book/parse_contrib_email_oldest.dart';
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

  // `scan` do Gmaila nie pisze, więc jako jedyna komenda nie ma `--write`.
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

  // Stare nazwy: działają po cichu, nie ma ich w pomocy. Dostają `--write`
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
    help: 'Zdejmij też z mejli, których stan zmienił się po przebiegu');

void _replyOptions(ArgParser p) => p
  ..addOption('limit', abbr: 'n', help: 'Ilu autorom odpisać w tym przebiegu')
  ..addOption('query', help: 'Własne query Gmaila zamiast kolejki odpowiedzi');

const Map<String, void Function(ArgParser)> _optionsOf = {
  'scan': _scanOptions,
  'label reviewed': _reviewedOptions,
  'unlabel': _unlabelOptions,
  'reply': _replyOptions,
};

/// `--write` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu.
/// `--apply` zostaje ukrytym synonimem, żeby stare notatki dalej działały.
void _addWrite(ArgParser p, {String? help, bool hidden = false}) => p
  ..addFlag('write', negatable: false, hide: hidden, help: help)
  ..addFlag('apply', negatable: false, hide: true);

bool _write(ArgResults cmd) =>
    (cmd['write'] as bool) || (cmd['apply'] as bool);

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
  final fetched = <ContribMessage>[];
  for (final id in ids) {
    fetched.add(await mailbox.getMessage(id));
    if (fetched.length % 50 == 0) stdout.writeln('  ${fetched.length}/${ids.length}');
  }
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

  final imports = [
    for (final c in classified)
      if (c.verdict case Import(:final song)) song,
  ];
  final outDir = cmd['out'] as String? ?? defaultOutDir();
  final songsPath = songsPathIn(outDir);
  final planPath = planPathIn(outDir);
  final reportPath = reportPathIn(outDir);
  final plan = LabelPlan.fromClassified(classified, songsPath);
  writePlan(planPath, plan);
  writeText(reportPath, report);
  if (imports.isNotEmpty) {
    writeHrcpsng(songsPath, imports);
    stdout.writeln('\nZapisano ${imports.length} piosenek → $songsPath');
    stdout.writeln('Wczytaj ten plik na stronie ze śpiewnikiem.');
    // Kopia do podmiany: po przeglądzie wgrywasz tu eksport ze strony,
    // a `label reviewed` z różnicy wyciąga odrzucone.
    final reviewedPath = reviewedPathIn(outDir);
    File(songsPath).copySync(reviewedPath);
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
    stdout.writeln('\nNic do importu.');
  }

  stdout.writeln('Katalog: $outDir');
  stdout.writeln('Raport: $reportPath');
  stdout.writeln('Plan etykiet: $planPath');
  stdout.writeln('Gmail nietknięty — `scan` tylko czyta. Etykiety jak '
      'w raporcie nada: ./piosenkomat label scanned $outDir --write');
  return 0;
}

/// `label scanned [katalog] [--write]`: etykiety z planu zapisanego przez
/// `scan`, bez ponownego czytania treści. Mejle, które w międzyczasie dostały
/// już etykietę song/*, są pomijane.
Future<int> _labelScanned(ArgResults cmd) async {
  final planPath = _planPath(cmd);
  if (planPath == null) return 64;
  final plan = readPlan(planPath);
  stdout.writeln('${_planHeader(plan)}, plik piosenek ${plan.hrcpsngPath}');
  _countLines(stdout, _tally(plan.labelsById.values.expand((l) => l)));
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --write nada powyższe.');
    return 0;
  }
  final mailbox = await _connect(cmd);
  stdout.writeln('Sprawdzam aktualne etykiety ${plan.labelsById.length} mejli…');
  final alreadyLabeled = <String>{};
  for (final id in plan.labelsById.keys) {
    if ((await mailbox.labelsOf(id)).any(isSongLabel)) alreadyLabeled.add(id);
  }
  await _applyPlan(mailbox, plan, alreadyLabeled: alreadyLabeled);
  return 0;
}

/// `unlabel [katalog] [--write]`: cofa etykiety nadane przez ten przebieg —
/// na wypadek `label scanned` puszczonego za szybko. Zdejmuje wyłącznie to,
/// co jest w planie, więc Twoje ręczne etykiety zostają.
///
/// Bezpiecznik: mejla, który po przebiegu ruszył dalej (dostał etykietę
/// `song/*` spoza planu, np. przez `label added` albo Twoją rękę), nie ruszamy —
/// cofnięcie zostawiłoby go w połowie drogi. `--force`, jeśli mimo to ma zejść.
Future<int> _unlabel(ArgResults cmd) async {
  final planPath = _planPath(cmd);
  if (planPath == null) return 64;
  final plan = readPlan(planPath);
  final force = cmd['force'] as bool;
  stdout.writeln('${_planHeader(plan)}, sprawdzam aktualne etykiety…');

  final mailbox = await _connect(cmd);
  final toRemove = <String, List<String>>{};
  var untouched = 0;
  var movedOn = 0;
  for (final e in plan.labelsById.entries) {
    final current = await mailbox.labelsOf(e.key);
    final planned = e.value.toSet();
    final moved = current.any((l) => isSongLabel(l) && !planned.contains(l));
    if (moved && !force) {
      movedOn++;
      continue;
    }
    final hit = [for (final l in e.value) if (current.contains(l)) l];
    if (hit.isEmpty) {
      untouched++;
      continue;
    }
    toRemove[e.key] = hit;
  }

  if (toRemove.isEmpty) {
    stdout.writeln('Nic do zdjęcia — po tym przebiegu nie został ślad.');
    return 0;
  }
  stdout.writeln('Do zdjęcia z ${toRemove.length} mejli:');
  _countLines(stdout, _tally(toRemove.values.expand((l) => l)));
  if (untouched > 0) {
    stdout.writeln('${untouched} mejli już bez etykiet z planu.');
  }
  if (movedOn > 0) {
    stdout.writeln('Pomijam $movedOn mejli ze stanem spoza planu '
        '(ruszyły dalej po przebiegu); --force, jeśli mimo to mają zejść.');
  }
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --write zdejmie powyższe.');
    return 0;
  }
  for (final e in toRemove.entries) {
    await mailbox.removeLabels(e.key, e.value);
  }
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
  final applied = <String>[];
  var skipped = 0;
  for (final e in plan.labelsById.entries) {
    if (alreadyLabeled.contains(e.key)) {
      skipped++;
      continue;
    }
    await mailbox.addLabels(e.key, e.value);
    applied.addAll(e.value);
  }
  stdout.writeln('Nadano:');
  _countLines(stdout, _tally(applied));
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli, które już miały etykietę song/*.');
  }
  stdout.writeln('Po przeglądzie na stronie podmień reviewed.hrcpsng, potem '
      './piosenkomat label reviewed --write i ./piosenkomat label added --write');
}

String _planHeader(LabelPlan plan) =>
    'Plan z ${_minute(plan.createdAt)}: ${plan.labelsById.length} mejli';

Future<int> _labelAdded(ArgResults cmd) async {
  final write = _write(cmd);
  final mailbox = await _connect(cmd);
  final ids = await mailbox.listIds(kReadyByToolQuery);
  final ready = <ContribMessage>[];
  for (final id in ids) {
    final m = await mailbox.getMessage(id);
    // Bezpiecznik: tylko to, co automat sam wstawił do pliku.
    if (!isReadyByTool(m.labels)) continue;
    ready.add(m);
    stdout.writeln('  ${m.subject ?? ''}  ${emailFromHeader(m.from) ?? ''}  [$id]');
  }
  stdout.writeln('„$kLabelReady” + „$kLabelAuto”: ${ready.length} mejli');
  if (!write) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --write zmieni na „$kLabelDone” + przeczytane.');
    return 0;
  }
  await mailbox.ensureToolLabels();
  for (final m in ready) {
    await mailbox.commitReady(m.id);
  }
  stdout.writeln('Zatwierdzono ${ready.length} mejli.');
  return 0;
}

/// `label reviewed [katalog] [--write]`: różnica między tym, co automat
/// wstawił do pliku, a tym, co zostało po Twoim przeglądzie na stronie.
/// Mejl traci „w pliku” tylko wtedy, gdy wypadły wszystkie jego piosenki.
Future<int> _labelReviewed(ArgResults cmd) async {
  final outDir = _runDir(cmd);
  if (outDir == null) return 64;
  final force = cmd['force'] as bool;
  final plan = readPlan(planPathIn(outDir));
  final reviewedPath = _resolve(cmd['reviewed'] as String? ??
      // `--approved` i `approved.hrcpsng`: nazwy sprzed przemianowania.
      cmd['approved'] as String? ??
      _pickReviewedFile(outDir));

  final proposed = collectProposed(plan, readHrcpsng(songsPathIn(outDir)));
  if (proposed.isEmpty) {
    stderr.writeln('Ten przebieg nic nie zaproponował do pliku, nie ma co porównywać.');
    return 1;
  }
  final reviewed = readHrcpsng(reviewedPath);
  stdout.writeln('Przebieg $outDir: ${proposed.length} zaproponowanych, '
      '${reviewed.length} w $reviewedPath');

  final result = reviewDiff(proposed: proposed, reviewed: reviewed);
  final reviewPath = reviewPathIn(outDir);
  writeReviewLedger(reviewPath, reviewedPath: reviewedPath, result: result);
  _printReview(result);
  stdout.writeln('Ślad przeglądu: $reviewPath');

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

  final msgIds = result.rejectedMsgIds;
  if (msgIds.isEmpty) {
    stdout.writeln('\nNic do odetykietowania. Dalej: ./piosenkomat label added --write');
    return 0;
  }
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --write zdejmie „$kLabelReady” '
        'i nada „$kLabelRejectedAfterReview” na ${msgIds.length} mejlach.');
    return 0;
  }

  final mailbox = await _connect(cmd);
  await mailbox.ensureToolLabels();
  var done = 0;
  var skipped = 0;
  for (final id in msgIds) {
    // Bezpiecznik jak w `label added`: ruszamy tylko to, co automat sam
    // wstawił do pliku i co dalej tam czeka.
    if (!isReadyByTool(await mailbox.labelsOf(id))) {
      skipped++;
      continue;
    }
    await mailbox.rejectAfterReview(id);
    done++;
  }
  stdout.writeln('Odrzucono po przeglądzie: $done mejli.');
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli bez „$kLabelReady” + „$kLabelAuto”.');
  }
  stdout.writeln('Dalej: ./piosenkomat label added --write');
  return 0;
}

/// Co weszło, co wypadło, co rozpoznane inaczej niż po id mejla.
void _printReview(ReviewResult result) {
  stdout.writeln();
  stdout.writeln('ZOSTAJE   ${result.accepted.length}');
  stdout.writeln('ODRZUCONE ${result.rejected.length}');
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
    ..removeAll({for (final m in result.accepted) m.proposed.sender})
    ..remove('');
  if (dropped.isNotEmpty) {
    stdout.writeln('Tylko odrzucone piosenki (pomiń w people.dart): '
        '${dropped.join(', ')}');
  }
  final byOther = [
    for (final m in result.accepted)
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

/// `reply [--apply]`: autorom ze starej apki wiadomość, żeby ją zaktualizowali.
///
/// Kolejką jest sam Gmail: etykieta „$kLabelOldAppToReply”, którą wiesza
/// `label scanned --write`. Wysyłka ją zdejmuje i wiesza „$kLabelOldAppReplied”,
/// więc nikt nie dostanie dwóch odpowiedzi, a przerwany przebieg dokańcza się
/// zwykłym powtórzeniem komendy.
///
/// Jedna odpowiedź na autora, nie na mejl: kto przysłał pięć piosenek ze starej
/// apki, dostaje jeden mejl w najnowszym wątku, a etykieta schodzi ze wszystkich.
Future<int> _reply(ArgResults cmd) async {
  final write = _write(cmd);
  final limit = _limit(cmd);

  final mailbox = await _connect(cmd);
  final query = cmd['query'] as String? ??
      'label:${labelQueryName(kLabelOldAppToReply)}';
  final ids = await mailbox.listIds(query);
  if (ids.isEmpty) {
    stdout.writeln('Nikt nie czeka na odpowiedź.');
    return 0;
  }
  stdout.writeln('Do odpisania: ${ids.length} mejli, pobieram nagłówki…');

  // Grupujemy po autorze, w każdej grupie odpisujemy na najnowszy wątek.
  final bySender = <String, List<ReplyTarget>>{};
  final unknownSender = <String>[];
  for (final id in ids) {
    final target = await mailbox.replyTarget(id);
    final sender = emailFromHeader(target.to);
    if (sender == null || sender == kInboxEmail) {
      unknownSender.add(id);
      continue;
    }
    bySender.putIfAbsent(sender, () => []).add(target);
  }

  final senders = bySender.keys.toList()..sort();
  final planned = limit == null ? senders : senders.take(limit).toList();
  for (final sender in planned) {
    final targets = bySender[sender]!;
    stdout.writeln('  → $sender  ${targets.length} '
        '${targets.length == 1 ? 'mejl' : 'mejli'}  '
        'wątek [${targets.last.messageId}]');
  }
  if (planned.length < senders.length) {
    stdout.writeln('  (${senders.length - planned.length} autorów poza --limit, '
        'zostają w kolejce)');
  }
  if (unknownSender.isNotEmpty) {
    stdout.writeln('Pomijam ${unknownSender.length} mejli bez czytelnego nadawcy; '
        'etykieta zostaje.');
  }

  if (!write) {
    stdout.writeln('\nDry-run: nic nie wysłano. --write wyśle '
        '${planned.length} ${planned.length == 1 ? 'mejl' : 'mejli'}.');
    return 0;
  }

  await mailbox.ensureToolLabels();
  var sent = 0;
  var failed = 0;
  for (final sender in planned) {
    final targets = bySender[sender]!;
    try {
      await mailbox.replyTo(targets.last, oldestFormatReplyMessage);
    } catch (e) {
      // Etykieta zostaje, więc następny przebieg spróbuje jeszcze raz.
      stderr.writeln('  ! $sender: $e');
      failed++;
      continue;
    }
    sent++;
    // Zaraz po wysyłce, żeby ewentualna wywrotka nie kosztowała drugiego mejla.
    for (final t in targets) {
      await mailbox.markReplied(t.messageId);
    }
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

Future<GmailMailbox> _connect(ArgResults cmd) => GmailMailbox.connect(
      credentialsFile: File(cmd['credentials'] as String? ?? defaultCredentialsPath()),
      tokenFile: File(cmd['token'] as String? ?? defaultTokenPath()),
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

bool _unparsed(Classified c) => switch (c.verdict) {
      Manual(:final reasons) => reasons.contains(SkipReason.parseError),
      _ => false,
    };

/// Raport przebiegu (konsola i `report.txt`): liczby, powody i wiązki
/// sparsowanych, potem lista mejli z werdyktem i etykietami.
String formatRunReport(List<Classified> items) {
  final imports = items.where((c) => c.isImport).toList()
    ..sort((a, b) => (a.message.date ?? DateTime(0))
        .compareTo(b.message.date ?? DateTime(0)));
  final manual = [for (final c in items) if (c.verdict case Manual()) c];
  final unparsed = manual.where(_unparsed).length;
  final rejected =
      manual.where((c) => (c.verdict as Manual).isAutoReject).length;

  final buf = StringBuffer()
    ..writeln('SKLASYFIKOWANO  ${items.length}')
    ..writeln('SPARSOWANE      ${items.length - unparsed}')
    ..writeln('NIE SPARSOWANE  $unparsed')
    ..writeln('IMPORT          ${imports.length}')
    ..writeln('ODRZUĆ          $rejected')
    ..writeln('RĘCZNIE         ${manual.length - rejected}')
    ..writeln('STARA APKA      ${items.where((c) => c.oldApp).length}'
        '  (do odpisania: ./piosenkomat reply)');

  final reasonsOf = [
    for (final c in manual)
      if (!_unparsed(c)) (c.verdict as Manual).reasons.map((r) => r.text).toList(),
  ];
  if (reasonsOf.isNotEmpty) {
    buf.writeln();
    buf.writeln('Powody sparsowanych (mejl może mieć kilka):');
    _countLines(buf, _tally(reasonsOf.expand((r) => r)), byCount: true);
    final only = _tally([for (final r in reasonsOf) if (r.length == 1) r.single]);
    if (only.isNotEmpty) {
      buf.writeln('Tylko ten powód:');
      _countLines(buf, only, byCount: true);
    }
    final bundles = _tally([for (final r in reasonsOf) if (r.length > 1) r.join('; ')]);
    if (bundles.isNotEmpty) {
      buf.writeln('Wiązki (więcej niż jeden powód):');
      _countLines(buf, bundles, byCount: true);
    }
  }

  if (imports.isNotEmpty) buf.writeln();
  for (final c in imports) {
    final v = c.verdict as Import;
    final date = c.message.date == null ? '' : _day(c.message.date!);
    buf.writeln('IMPORT   ${c.title}  ${v.sender}  $date  [${c.message.id}]'
        '${c.oldApp ? '  (stara apka)' : ''}');
  }
  if (manual.isNotEmpty) buf.writeln();
  for (final c in manual) {
    final v = c.verdict as Manual;
    final labels = stateLabelsFor(v);
    final tag = v.isAutoReject ? 'ODRZUĆ  ' : 'RĘCZNIE ';
    buf.writeln('$tag ${c.title}  [${c.message.id}]  '
        '${v.reasons.map((r) => r.text).join('; ')}'
        '${c.oldApp ? '  (stara apka)' : ''}');
    // Przy przeglądzie sama `needs-review` nic nie mówi — liczą się podkategorie.
    buf.writeln('         → ${(v.isAutoReject ? labels : labels.skip(1)).join(', ')}'
        '${c.oldApp ? ', $kLabelOldAppToReply' : ''}');
    if (v.detail != null) {
      buf.writeln('         ${v.detail!.split('\n').first}');
    }
  }
  return buf.toString();
}

String _usage(ArgParser parser) => '''
piosenkomat: sitko mejli z piosenkami na $kInboxEmail.

  ./piosenkomat scan [-n N] [--newest] [-o katalog]
      kolejka (inbox bez song/*) → katalog out/import-<data>/: raport, plan,
      songs.hrcpsng, reviewed.hrcpsng, people.dart. Gmaila tylko czyta
  ./piosenkomat label scanned [katalog] --write
      werdykty automatu na mejle: „$kLabelReady”, „song/rejected/…”,
      „$kLabelToReview”, wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat label reviewed [katalog] --write
      songs.hrcpsng minus reviewed.hrcpsng → „$kLabelRejectedAfterReview”
  ./piosenkomat label added [katalog] --write
      „$kLabelReady” + „$kLabelAuto” → „$kLabelDone” + przeczytane
  ./piosenkomat unlabel [katalog] --write
      cofa etykiety nadane przez ten przebieg
  ./piosenkomat reply [-n N] --write
      autorom ze starej apki: „zaktualizuj apkę”; kolejką jest etykieta
      „$kLabelOldAppToReply”, wysyłka przestawia ją na „$kLabelOldAppReplied”
  ./piosenkomat explain plik.eml [...]
      klasyfikacja lokalnych plików, bez Gmaila

Bez katalogu komendy biorą ostatni przebieg z out/.
Bez --write nic w Gmailu się nie zmienia.

scan:
${parser.commands['scan']!.usage}

label reviewed:
${parser.commands['label']!.commands['reviewed']!.usage}

unlabel:
${parser.commands['unlabel']!.usage}
''';
