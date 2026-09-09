import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import 'classify.dart';
import 'gmail.dart';
import 'hrcpsng.dart';
import 'model.dart';
import 'people.dart';
import 'plan.dart';
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
        abbr: 'o', help: 'Plik .hrcpsng (domyślnie out/import-<data>.hrcpsng)')
    ..addOption('query', help: 'Własne query Gmaila zamiast kolejki');
  _addCommon(process);

  final commit = parser.addCommand('commit')
    ..addFlag('apply',
        negatable: false, help: 'Zmień etykiety w Gmailu (bez tej flagi lista)');
  _addCommon(commit);

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
  final outPath = cmd['out'] as String? ?? defaultOutPath();
  final planPath = planPathFor(outPath);
  final plan = LabelPlan.fromClassified(classified, outPath);
  writePlan(planPath, plan);
  if (imports.isNotEmpty) {
    writeHrcpsng(outPath, imports);
    stdout.writeln('\nZapisano ${imports.length} piosenek → $outPath');
    stdout.writeln('Wczytaj ten plik na stronie ze śpiewnikiem.');

    final people = collectPeople(classified);
    final peoplePath = peoplePathFor(outPath);
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
    stderr.writeln('Podaj jeden plik planu: ./piosenkomat apply out/import-<data>.labels.json');
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
  stdout.writeln('Odrzucone na stronie przenieś w Gmailu z „$kLabelReady” do '
      '„song/rejected/…”, potem: ./piosenkomat commit --apply');
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
  stdout.write(formatReport(classifyBatch(messages, book: book)));
  return 0;
}

/// Narzędzie działa w `tool/piosenkomat/`, ale użytkownik podaje ścieżki
/// z katalogu, w którym wpisał `./piosenkomat` (przekazany w PIOSENKOMAT_CWD).
String _resolve(String path) {
  if (p.isAbsolute(path) || File(path).existsSync()) return path;
  final cwd = Platform.environment['PIOSENKOMAT_CWD'];
  if (cwd != null) {
    final candidate = p.join(cwd, path);
    if (File(candidate).existsSync()) return candidate;
  }
  return path;
}

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

String formatReport(List<Classified> items) {
  final imports = items.where((c) => c.isImport).toList()
    ..sort((a, b) => (a.message.date ?? DateTime(0))
        .compareTo(b.message.date ?? DateTime(0)));
  final manual = items.where((c) => !c.isImport).toList();

  final buf = StringBuffer()
    ..writeln('IMPORT   ${imports.length}')
    ..writeln('RĘCZNIE  ${manual.length}');

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
      kolejka (inbox bez song/*) → plik .hrcpsng
      kandydaci: „$kLabelReady”, jednoznaczne odrzucenia: „song/rejected/…”,
      reszta: „$kLabelToReview”; wszystko ze znacznikiem „$kLabelAuto”
  ./piosenkomat apply out/import-<data>.labels.json [--apply]
      etykiety z wcześniejszego przebiegu, bez ponownego czytania skrzynki
  ./piosenkomat commit [--apply]
      „$kLabelReady” + „$kLabelAuto” → „$kLabelDone” + przeczytane
  ./piosenkomat check plik.eml [...]
      klasyfikacja lokalnych plików, bez Gmaila

Bez --apply nic w Gmailu się nie zmienia.

process:
${parser.commands['process']!.usage}

commit:
${parser.commands['commit']!.usage}
''';
