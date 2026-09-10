import 'dart:io';

import 'package:args/args.dart';
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

  final process = parser.addCommand('process')
    ..addFlag('apply',
        negatable: false,
        help: 'Nadaj etykiety w Gmailu (bez tej flagi tylko raport i plik)')
    ..addOption('limit',
        abbr: 'n', help: 'Ile mejli z kolejki (domyślnie wszystkie)')
    ..addFlag('newest',
        negatable: false, help: 'Najnowsze N zamiast najstarszych')
    ..addOption('out',
        abbr: 'o',
        help: 'Katalog przebiegu (domyślnie out/import-<data>)')
    ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');
  _addCommon(process);

  final commit = parser.addCommand('commit')
    ..addFlag('apply',
        negatable: false, help: 'Zmień etykiety w Gmailu (bez tej flagi lista)');
  _addCommon(commit);

  final review = parser.addCommand('review')
    ..addFlag('apply',
        negatable: false,
        help: 'Zmień etykiety odrzuconych (bez tej flagi tylko lista)')
    ..addOption('approved',
        help: 'Plik z zatwierdzonymi (domyślnie approved.hrcpsng w katalogu)')
    ..addFlag('force',
        negatable: false,
        help: 'Pomiń bezpieczniki (pusty plik, odrzucona większość)');
  _addCommon(review);

  final check = parser.addCommand('check');
  _addCommon(check);

  final apply = parser.addCommand('apply')
    ..addFlag('apply',
        negatable: false, help: 'Nadaj etykiety (bez tej flagi tylko lista)');
  _addCommon(apply);

  ArgResults opts;
  try {
    opts = parser.parse(args);
  } on FormatException catch (e) {
    stderr.writeln(e.message);
    stderr.writeln(_usage(parser));
    return 64;
  }
  final cmd = opts.command;
  if (opts['help'] as bool || cmd == null) {
    stdout.writeln(_usage(parser));
    return cmd == null && !(opts['help'] as bool) ? 64 : 0;
  }

  try {
    switch (cmd.name) {
      case 'process':
        return await _process(cmd);
      case 'commit':
        return await _commit(cmd);
      case 'review':
        return await _review(cmd);
      case 'check':
        return _check(cmd);
      case 'apply':
        return await _apply(cmd);
    }
    return 64;
  } on FileSystemException catch (e) {
    stderr.writeln('${e.message}: ${e.path}');
    return 1;
  }
}

void _addCommon(ArgParser p) => p
  ..addOption('songs-db', help: 'Ścieżka do all_songs.hrcpsng')
  ..addOption('credentials', help: 'Domyślnie secrets/credentials.json')
  ..addOption('token', help: 'Domyślnie secrets/gmail_token.json');

Future<int> _process(ArgResults cmd) async {
  final apply = cmd['apply'] as bool;
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
    // a `review` z różnicy wyciąga odrzucone.
    final approvedPath = approvedPathIn(outDir);
    File(songsPath).copySync(approvedPath);
    stdout.writeln('Po przeglądzie podmień $approvedPath eksportem ze strony '
        'i odpal: ./piosenkomat review $outDir');

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
  if (!apply) {
    stdout.writeln('Dry-run: Gmail nietknięty. Etykiety jak w raporcie nada '
        '--apply teraz albo później: ./piosenkomat apply $planPath --apply');
    return 0;
  }
  await _applyPlan(mailbox, plan, alreadyLabeled: {
    for (final m in messages) if (m.hasSongLabel) m.id,
  });
  return 0;
}

/// `apply <plan.labels.json> [--apply]`: etykiety z zapisanego planu, bez
/// ponownego czytania treści. Mejle, które w międzyczasie dostały już
/// etykietę song/*, są pomijane.
Future<int> _apply(ArgResults cmd) async {
  if (cmd.rest.length != 1) {
    stderr.writeln('Podaj jeden plik planu: ./piosenkomat apply out/import-<data>/labels.json');
    return 64;
  }
  final plan = readPlan(_resolve(cmd.rest.single));
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
  if (!(cmd['apply'] as bool)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --apply nada powyższe.');
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
      './piosenkomat review <katalog> --apply i ./piosenkomat commit --apply');
}

Future<int> _commit(ArgResults cmd) async {
  final apply = cmd['apply'] as bool;
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
  if (!apply) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --apply zmieni na „$kLabelDone” + przeczytane.');
    return 0;
  }
  await mailbox.ensureToolLabels();
  for (final m in ready) {
    await mailbox.commitReady(m.id);
  }
  stdout.writeln('Zatwierdzono ${ready.length} mejli.');
  return 0;
}

/// `review <katalog przebiegu> [--apply]`: różnica między tym, co automat
/// wstawił do pliku, a tym, co zostało po Twoim przeglądzie na stronie.
/// Mejl traci „w pliku” tylko wtedy, gdy wypadły wszystkie jego piosenki.
Future<int> _review(ArgResults cmd) async {
  if (cmd.rest.length != 1) {
    stderr.writeln('Podaj katalog przebiegu: ./piosenkomat review out/import-<data>');
    return 64;
  }
  final outDir = _resolve(cmd.rest.single);
  final force = cmd['force'] as bool;
  final plan = readPlan(planPathIn(outDir));
  final approvedPath =
      _resolve(cmd['approved'] as String? ?? approvedPathIn(outDir));

  final proposed = collectProposed(plan, readHrcpsng(songsPathIn(outDir)));
  if (proposed.isEmpty) {
    stderr.writeln('Ten przebieg nic nie zaproponował do pliku, nie ma co porównywać.');
    return 1;
  }
  final approved = readHrcpsng(approvedPath);
  stdout.writeln('Przebieg $outDir: ${proposed.length} zaproponowanych, '
      '${approved.length} w $approvedPath');

  final result = reviewDiff(proposed: proposed, approved: approved);
  final reviewPath = reviewPathIn(outDir);
  writeReviewLedger(reviewPath, approvedPath: approvedPath, result: result);

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
          '${m.approvedTitle == m.proposed.title ? '' : ' → ${m.approvedTitle}'}');
    }
  }
  for (final e in result.partial.entries) {
    stdout.writeln('UWAGA: z mejla [${e.key}] część piosenek weszła, a część nie '
        '(${e.value.map((s) => s.title).join(', ')}). Etykiety zostawiam Tobie.');
  }
  stdout.writeln('Ślad przeglądu: $reviewPath');

  // Bezpieczniki na zły plik: pusty eksport i „odrzucona większość” prawie
  // zawsze znaczą, że podmieniony został nie ten plik, co trzeba.
  if (!force && approved.isEmpty) {
    stderr.writeln('\n$approvedPath jest pusty — to wygląda na pomyłkę. '
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
    stdout.writeln('\nNic do odetykietowania. Dalej: ./piosenkomat commit --apply');
    return 0;
  }
  if (!(cmd['apply'] as bool)) {
    stdout.writeln('\nDry-run: Gmail nietknięty. --apply zdejmie „$kLabelReady” '
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
  stdout.writeln('Dalej: ./piosenkomat commit --apply');
  return 0;
}

int _check(ArgResults cmd) {
  if (cmd.rest.isEmpty) {
    stderr.writeln('Podaj pliki .eml do sprawdzenia.');
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
    ..writeln('RĘCZNIE         $review');

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
    buf.writeln('IMPORT   ${c.title}  ${v.sender}  $date  [${c.message.id}]');
  }
  if (manual.isNotEmpty) buf.writeln();
  for (final c in manual) {
    final v = c.verdict as Manual;
    final labels = stateLabelsFor(v);
    final review = labels.first == kLabelToReview;
    final tag = review ? 'RĘCZNIE ' : 'ODRZUĆ  ';
    buf.writeln('$tag ${c.title}  [${c.message.id}]  '
        '${v.reasons.map((r) => r.text).join('; ')}');
    buf.writeln('         → ${(review ? labels.skip(1) : labels).join(', ')}');
    if (v.detail != null) {
      buf.writeln('         ${v.detail!.split('\n').first}');
    }
  }
  return buf.toString();
}

String _usage(ArgParser parser) => '''
piosenkomat: sitko mejli z piosenkami na $kInboxEmail.

  ./piosenkomat process [-n N] [--newest] [--apply]
      kolejka (inbox bez song/*) → katalog out/import-<data>/
      kandydaci: „$kLabelReady”, jednoznaczne odrzucenia: „song/rejected/…”,
      reszta: „$kLabelToReview”; wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat apply out/import-<data>/labels.json [--apply]
      etykiety z wcześniejszego przebiegu, bez ponownego czytania skrzynki
  ./piosenkomat review out/import-<data> [--apply]
      songs.hrcpsng minus approved.hrcpsng → „$kLabelRejectedAfterReview”
  ./piosenkomat commit [--apply]
      „$kLabelReady” + „$kLabelAuto” → „$kLabelDone” + przeczytane
  ./piosenkomat check plik.eml [...]
      klasyfikacja lokalnych plików, bez Gmaila

Bez --apply nic w Gmailu się nie zmienia.

process:
${parser.commands['process']!.usage}

review:
${parser.commands['review']!.usage}

commit:
${parser.commands['commit']!.usage}
''';
