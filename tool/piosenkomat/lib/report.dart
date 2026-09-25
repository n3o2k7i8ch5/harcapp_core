import 'model.dart';

/// Ile razy wystąpił każdy klucz.
Map<String, int> tally(Iterable<String> keys) {
  final counts = <String, int>{};
  for (final k in keys) {
    counts[k] = (counts[k] ?? 0) + 1;
  }
  return counts;
}

/// Wiersze `  liczba  klucz`, po kluczu; [byCount] daje najliczniejsze pierwsze.
void countLines(StringSink out, Map<String, int> counts, {bool byCount = false}) {
  final rows = counts.entries.toList()
    ..sort((a, b) {
      final c = byCount ? b.value.compareTo(a.value) : 0;
      return c != 0 ? c : a.key.compareTo(b.key);
    });
  for (final e in rows) {
    out.writeln('  ${e.value.toString().padLeft(4)}  ${e.key}');
  }
}

String _day(DateTime d) => d.toLocal().toIso8601String().substring(0, 10);

/// Raport przebiegu (konsola i `report.txt`): liczby, uwagi i ich wiązki,
/// potem lista zgłoszeń z tym, gdzie trafiły i co im automat zarzuca.
String formatRunReport(List<Classified> items) {
  int count(bool Function(Classified) test) => items.where(test).length;
  int to(Destination d) => count((c) => c.destination == d);
  final newInFile = [for (final c in items) if (c.goesToFile && !c.submission.isCorrection) c];
  final correctionsInFile = [for (final c in items) if (c.goesToFile && c.submission.isCorrection) c];

  final buf = StringBuffer()
    ..writeln('ZGŁOSZEŃ        ${items.length}  (wątków)')
    ..writeln('NOWE            ${newInFile.length}  (candidates-new.hrcpsng)')
    ..writeln('  bez zarzutu   ${newInFile.where((c) => c.issues.isEmpty).length}')
    ..writeln('  z uwagami     ${newInFile.where((c) => c.issues.isNotEmpty).length}')
    ..writeln('POPRAWKI        ${correctionsInFile.length}  (candidates-correction.hrcpsng)')
    ..writeln('  bez zarzutu   ${correctionsInFile.where((c) => c.issues.isEmpty).length}')
    ..writeln('  z uwagami     ${correctionsInFile.where((c) => c.issues.isNotEmpty).length}')
    ..writeln('ODRZUĆ          ${count((c) => c.destination.isReject)}')
    ..writeln('  już w apce    ${to(Destination.rejectAlreadyInApp)}')
    ..writeln('  duplikat      ${to(Destination.rejectDuplicate)}')
    ..writeln('  zły załącznik ${to(Destination.rejectCorruptedFile)}')
    ..writeln('  nie do odczytu ${to(Destination.unparsable)}')
    ..writeln('RĘCZNIE         ${to(Destination.multipleSongs)}  (kilka piosenek w jednym mejlu)')
    ..writeln('RZUĆ OKIEM      ${count((c) => c.haveALook)}'
        '  (odrzut, ale autor coś napisał albo mejla nie da się odczytać)')
    ..writeln('STARA APKA      ${count((c) => c.submission.isOldApp)}'
        '  (do odpisania: ./piosenkomat reply)');

  // Rozkład kształtów mejla mówi, kiedy wolno skasować czytniki starych
  // formatów; rozkład wersji apki — jak szybko ludzie aktualizują.
  buf
    ..writeln()
    ..writeln('Kształt mejla:');
  countLines(buf, tally([for (final c in items) c.submission.shape.id]), byCount: true);
  final versions = tally([
    for (final c in items)
      if (c.submission.appVersion case final v?) v,
  ]);
  if (versions.isNotEmpty) {
    buf.writeln('Wersja apki:');
    countLines(buf, versions, byCount: true);
  }

  final issueIdsPerItem = [
    for (final c in items)
      if (c.issues.isNotEmpty) [for (final i in c.issues) i.issue.id],
  ];
  if (issueIdsPerItem.isNotEmpty) {
    buf
      ..writeln()
      ..writeln('Uwagi (jedno zgłoszenie może mieć kilka):');
    countLines(buf, tally(issueIdsPerItem.expand((ids) => ids)), byCount: true);
    final bundles = tally([
      for (final ids in issueIdsPerItem)
        if (ids.length > 1) ids.join(' + '),
    ]);
    if (bundles.isNotEmpty) {
      buf.writeln('Kilka uwag naraz:');
      countLines(buf, bundles, byCount: true);
    }
  }

  final byDate = [...items]..sort((a, b) =>
      (a.submission.sentAt ?? DateTime(0)).compareTo(b.submission.sentAt ?? DateTime(0)));
  buf.writeln();
  for (final c in byDate) {
    final s = c.submission;
    final tag = switch (c.destination) {
      Destination.candidateNew => 'NOWA    ',
      Destination.candidateCorrection => 'POPRAWKA',
      Destination.unparsable => 'NIEPARS ',
      Destination.multipleSongs => 'RĘCZNIE ',
      Destination.rejectAlreadyInApp ||
      Destination.rejectDuplicate ||
      Destination.rejectCorruptedFile =>
        'ODRZUĆ  ',
    };
    final date = s.sentAt == null ? '' : _day(s.sentAt!);
    final messageCountText =
        s.messages.length > 1 ? '  (${s.messages.length} wiadomości)' : '';
    buf
      ..writeln('$tag ${c.title}  ${s.sender ?? ''}  $date  [${s.message.id}]'
          '$messageCountText${s.isOldApp ? '  (stara apka)' : ''}')
      ..writeln('         → ${c.labels.join(', ')}');
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
