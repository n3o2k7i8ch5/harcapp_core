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

  final scan = parser.addCommand('scan')
    ..addOption('limit',
        abbr: 'n', help: 'Ile mejli z kolejki (domyślnie wszystkie)')
    ..addFlag('newest',
        negatable: false, help: 'Najnowsze N zamiast najstarszych')
    ..addOption('out',
        abbr: 'o',
        help: 'Katalog przebiegu (domyślnie out/import-<data>)')
    ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');
  _addCommon(scan);
  // `scan` do Gmaila nie pisze. Flaga siedzi tu wyłącznie dla aliasu
  // `process --apply`, który etykietował od razu po przesiewie.
  _addWrite(scan, hidden: true);

  final label = parser.addCommand('label');
  final labelScanned = label.addCommand('scanned');
  _addCommon(labelScanned);
  _addWrite(labelScanned, help: 'Nadaj etykiety (bez tej flagi tylko lista)');

  final labelReviewed = label.addCommand('reviewed')
    ..addOption('reviewed',
        help: 'Plik po przeglądzie (domyślnie reviewed.hrcpsng w katalogu)')
    // Nazwa sprzed przemianowania pliku.
    ..addOption('approved', hide: true)
    ..addFlag('force',
        negatable: false,
        help: 'Pomiń bezpieczniki (pusty plik, odrzucona większość)');
  _addCommon(labelReviewed);
  _addWrite(labelReviewed,
      help: 'Zmień etykiety odrzuconych (bez tej flagi tylko lista)');

  final labelAdded = label.addCommand('added');
  _addCommon(labelAdded);
  _addWrite(labelAdded, help: 'Zmień etykiety w Gmailu (bez tej flagi lista)');

  final unlabel = parser.addCommand('unlabel')
    ..addFlag('force',
        negatable: false,
        help: 'Zdejmij też z mejli, których stan zmienił się po przebiegu');
  _addCommon(unlabel);
  _addWrite(unlabel, help: 'Zdejmij etykiety (bez tej flagi tylko lista)');

  final reply = parser.addCommand('reply')
    ..addOption('limit',
        abbr: 'n', help: 'Ilu autorom odpisać w tym przebiegu')
    ..addOption('query', help: 'Własne query Gmaila zamiast kolejki odpowiedzi');
  _addCommon(reply);
  _addWrite(reply, help: 'Wyślij (bez tej flagi tylko lista)');

  final explain = parser.addCommand('explain');
  _addCommon(explain);

  // Stare nazwy: działają po cichu, nie ma ich w pomocy.
  for (final old in _aliases.keys) {
    final a = parser.addCommand(old);
    switch (_aliases[old]!) {
      case 'scan':
        a
          ..addOption('limit', abbr: 'n')
          ..addFlag('newest', negatable: false)
          ..addOption('out', abbr: 'o')
          ..addOption('query');
      case 'label reviewed':
        a
          ..addOption('approved')
          ..addOption('reviewed')
          ..addFlag('force', negatable: false);
      case 'unlabel':
        a.addFlag('force', negatable: false);
      case 'reply':
        a
          ..addOption('limit', abbr: 'n')
          ..addOption('query');
    }
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
  }
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

Future<int> _scan(ArgResults cmd) async {
  final write = _write(cmd);
  final newest = cmd['newest'] as bool;
  int? limit;
  if (cmd['limit'] != null) {
    limit = int.tryParse(cmd['limit'] as String);
    if (limit == null || limit <= 0) {
      stderr.writeln('--limit wymaga liczby dodatniej.');
      return 64;
    }
  }

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
  stdout.writeln();
  stdout.write(formatReport(classified));

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
  writeReport(reportPath, formatRunReport(classified));
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
  if (!write) {
    stdout.writeln('Gmail nietknięty — `scan` tylko czyta. Etykiety jak '
        'w raporcie nada: ./piosenkomat label scanned $outDir --write');
    return 0;
  }
  await _applyPlan(mailbox, plan, alreadyLabeled: {
    for (final m in messages) if (m.hasSongLabel) m.id,
  });
  return 0;
}

/// `label scanned [katalog] [--write]`: etykiety z planu zapisanego przez
/// `scan`, bez ponownego czytania treści. Mejle, które w międzyczasie dostały
/// już etykietę song/*, są pomijane.
Future<int> _labelScanned(ArgResults cmd) async {
  final planPath = _planPath(cmd);
  if (planPath == null) return 64;
  final plan = readPlan(planPath);
  stdout.writeln('Plan z ${plan.createdAt.toLocal().toIso8601String().substring(0, 16)}: '
      '${plan.labelsById.length} mejli, plik piosenek ${plan.hrcpsngPath}');
  final counts = <String, int>{};
  for (final labels in plan.labelsById.values) {
    for (final l in labels) {
      counts[l] = (counts[l] ?? 0) + 1;
    }
  }
  for (final e in counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key))) {
    stdout.writeln('  ${e.value.toString().padLeft(4)}  ${e.key}');
  }
  if (!_write(cmd)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --write nada powyższe.');
    return 0;
  }
  final mailbox = await _connect(cmd);
  stdout.writeln('Sprawdzam aktualne etykiety ${plan.labelsById.length} mejli…');
  final alreadyLabeled = <String>{};
  for (final id in plan.labelsById.keys) {
    if (await mailbox.hasAnyLabel(id, prefix: 'song')) alreadyLabeled.add(id);
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
  stdout.writeln('Plan z ${plan.createdAt.toLocal().toIso8601String().substring(0, 16)}: '
      '${plan.labelsById.length} mejli, sprawdzam aktualne etykiety…');

  final mailbox = await _connect(cmd);
  final toRemove = <String, List<String>>{};
  final counts = <String, int>{};
  var untouched = 0;
  var movedOn = 0;
  for (final e in plan.labelsById.entries) {
    final current = await mailbox.labelsOf(e.key);
    final planned = e.value.toSet();
    final moved = current.any((l) =>
        (l == 'song' || l.startsWith('song/')) && !planned.contains(l));
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
    for (final l in hit) {
      counts[l] = (counts[l] ?? 0) + 1;
    }
  }

  if (toRemove.isEmpty) {
    stdout.writeln('Nic do zdjęcia — po tym przebiegu nie został ślad.');
    return 0;
  }
  stdout.writeln('Do zdjęcia z ${toRemove.length} mejli:');
  for (final c in counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key))) {
    stdout.writeln('  ${c.value.toString().padLeft(4)}  ${c.key}');
  }
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
  final counts = <String, int>{};
  var skipped = 0;
  for (final e in plan.labelsById.entries) {
    if (alreadyLabeled.contains(e.key)) {
      skipped++;
      continue;
    }
    await mailbox.addLabels(e.key, e.value);
    for (final l in e.value) {
      counts[l] = (counts[l] ?? 0) + 1;
    }
  }
  stdout.writeln('Nadano:');
  for (final c in counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key))) {
    stdout.writeln('  ${c.value.toString().padLeft(4)}  ${c.key}');
  }
  if (skipped > 0) {
    stdout.writeln('Pominięto $skipped mejli, które już miały etykietę song/*.');
  }
  stdout.writeln('Po przeglądzie na stronie podmień approved.hrcpsng, potem '
      './piosenkomat label reviewed --write i ./piosenkomat label added --write');
}

Future<int> _labelAdded(ArgResults cmd) async {
  final write = _write(cmd);
  final mailbox = await _connect(cmd);
  final ids = await mailbox.listIds(kReadyByToolQuery);
  final ready = <ContribMessage>[];
  for (final id in ids) {
    final m = await mailbox.getMessage(id);
    // Bezpiecznik: tylko to, co automat sam wstawił do pliku.
    if (!m.labels.contains(kLabelReady) || !m.labels.contains(kLabelAuto)) continue;
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
    // Bezpiecznik jak w `commit`: ruszamy tylko to, co automat sam wstawił
    // do pliku i co dalej tam czeka.
    final labels = await mailbox.labelsOf(id);
    if (!labels.contains(kLabelReady) || !labels.contains(kLabelAuto)) {
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
  int? limit;
  if (cmd['limit'] != null) {
    limit = int.tryParse(cmd['limit'] as String);
    if (limit == null || limit <= 0) {
      stderr.writeln('--limit wymaga liczby dodatniej.');
      return 64;
    }
  }

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

void writeReport(String path, String text) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(text);
}

bool _unparsed(Classified c) =>
    c.verdict is Manual &&
    (c.verdict as Manual).reasons.contains(SkipReason.parseError);

bool _autoReject(Classified c) =>
    c.verdict is Manual && stateLabelsFor(c.verdict).first != kLabelToReview;

/// Raport przebiegu: sparsowane vs nie, powody, wiązki, potem lista jak w konsoli.
String formatRunReport(List<Classified> items) {
  final imports = items.where((c) => c.isImport).toList();
  final manual = items.where((c) => !c.isImport).toList();
  final unparsed = [for (final c in manual) if (_unparsed(c)) c];
  final parsedSkip = [for (final c in manual) if (!_unparsed(c)) c];
  final rejected = [for (final c in manual) if (_autoReject(c)) c];
  final review = manual.length - rejected.length;

  final buf = StringBuffer()
    ..writeln('SKLASYFIKOWANO  ${items.length}')
    ..writeln('SPARSOWANE      ${items.length - unparsed.length}')
    ..writeln('NIE SPARSOWANE  ${unparsed.length}')
    ..writeln('IMPORT          ${imports.length}')
    ..writeln('ODRZUĆ          ${rejected.length}')
    ..writeln('RĘCZNIE         $review')
    ..writeln('STARA APKA      ${items.where((c) => c.oldApp).length}'
        '  (do odpisania: ./piosenkomat reply)');

  if (parsedSkip.isNotEmpty) {
    final any = <SkipReason, int>{};
    final only = <SkipReason, int>{};
    final bundles = <String, int>{};
    for (final c in parsedSkip) {
      final reasons = (c.verdict as Manual).reasons;
      for (final r in reasons) {
        any[r] = (any[r] ?? 0) + 1;
      }
      if (reasons.length == 1) {
        only[reasons.single] = (only[reasons.single] ?? 0) + 1;
      } else {
        final key = reasons.map((r) => r.text).join('; ');
        bundles[key] = (bundles[key] ?? 0) + 1;
      }
    }
    buf.writeln();
    buf.writeln('Powody sparsowanych (mejl może mieć kilka):');
    _countLines(buf, {
      for (final e in any.entries) e.key.text: e.value,
    });
    if (only.isNotEmpty) {
      buf.writeln('Tylko ten powód:');
      _countLines(buf, {
        for (final e in only.entries) e.key.text: e.value,
      });
    }
    if (bundles.isNotEmpty) {
      buf.writeln('Wiązki (więcej niż jeden powód):');
      _countLines(buf, bundles);
    }
  }

  buf.write(formatReport(items, summary: false));
  return buf.toString();
}

void _countLines(StringBuffer buf, Map<String, int> counts) {
  final rows = counts.entries.toList()
    ..sort((a, b) {
      final byCount = b.value.compareTo(a.value);
      return byCount != 0 ? byCount : a.key.compareTo(b.key);
    });
  for (final e in rows) {
    buf.writeln('  ${e.value.toString().padLeft(4)}  ${e.key}');
  }
}

/// `summary: false` pomija nagłówek IMPORT/RĘCZNIE — [formatRunReport] ma
/// własny, liczony inaczej (bez auto-odrzuconych), więc dwa naraz kłamią.
String formatReport(List<Classified> items, {bool summary = true}) {
  final imports = items.where((c) => c.isImport).toList()
    ..sort((a, b) => (a.message.date ?? DateTime(0))
        .compareTo(b.message.date ?? DateTime(0)));
  final manual = items.where((c) => !c.isImport).toList();

  final buf = StringBuffer();
  if (summary) {
    buf
      ..writeln('IMPORT   ${imports.length}')
      ..writeln('RĘCZNIE  ${manual.length}');
  }

  final counts = <SkipReason, int>{};
  for (final c in manual) {
    for (final r in (c.verdict as Manual).reasons) {
      counts[r] = (counts[r] ?? 0) + 1;
    }
  }
  final rows = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  for (final e in rows) {
    buf.writeln('  ${e.value.toString().padLeft(4)}  ${e.key.text}');
  }

  if (imports.isNotEmpty) buf.writeln();
  for (final c in imports) {
    final v = c.verdict as Import;
    final date = c.message.date?.toLocal().toIso8601String().substring(0, 10) ?? '';
    buf.writeln('IMPORT   ${c.title}  ${v.sender}  $date  [${c.message.id}]'
        '${c.oldApp ? '  (stara apka)' : ''}');
  }
  if (manual.isNotEmpty) buf.writeln();
  for (final c in manual) {
    final v = c.verdict as Manual;
    final labels = stateLabelsFor(v);
    final review = labels.first == kLabelToReview;
    final tag = review ? 'RĘCZNIE ' : 'ODRZUĆ  ';
    buf.writeln('$tag ${c.title}  [${c.message.id}]  '
        '${v.reasons.map((r) => r.text).join('; ')}'
        '${c.oldApp ? '  (stara apka)' : ''}');
    buf.writeln('         → ${(review ? labels.skip(1) : labels).join(', ')}'
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
