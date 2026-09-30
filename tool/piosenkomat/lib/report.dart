import 'package:harcapp_core/song_book/piosenkomat/file_names.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';

import 'model.dart';
import 'plan.dart';
import 'review.dart';

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

/// `2026-09-28 10:15`, czas lokalny.
String formatMinute(DateTime d) => d.toLocal().toIso8601String().substring(0, 16).replaceFirst('T', ' ');

/// Raport przebiegu (konsola i `report.txt`): liczby, uwagi i ich wiązki,
/// potem lista zgłoszeń z tym, gdzie trafiły i co im automat zarzuca.
String formatRunReport(List<Classified> items) {
  int count(bool Function(Classified) test) => items.where(test).length;
  int to(Destination d) => count((c) => c.destination == d);
  final buf = StringBuffer()..writeln('ZGŁOSZEŃ        ${items.length}  (wątków)');
  for (final kind in SubmissionKind.values) {
    final inFile = [for (final c in items) if (c.goesToFile && c.submission.kind == kind) c];
    buf
      ..writeln('${kind.groupName.toUpperCase().padRight(16)}${inFile.length}  (${candidatesFileName(kind)})')
      ..writeln('  bez zarzutu   ${inFile.where((c) => c.issues.isEmpty).length}')
      ..writeln('  z uwagami     ${inFile.where((c) => c.issues.isNotEmpty).length}');
  }
  buf
    ..writeln('ODRZUĆ          ${count((c) => c.destination.isReject)}')
    ..writeln('  już w apce    ${to(Destination.rejectAlreadyInApp)}')
    ..writeln('  duplikat      ${to(Destination.rejectDuplicate)}')
    ..writeln('  zły załącznik ${to(Destination.rejectCorruptedFile)}')
    ..writeln('  nowszy format ${to(Destination.rejectUnknownFormat)}')
    ..writeln('  nie do odczytu ${to(Destination.rejectUnparsable)}')
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
  countLines(buf, tally([for (final c in items) c.submission.shape?.id ?? 'unknown']), byCount: true);
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
      Destination.candidate => s.isCorrection ? 'POPRAWKA' : 'NOWA    ',
      Destination.rejectUnparsable => 'NIEPARS ',
      Destination.multipleSongs => 'RĘCZNIE ',
      _ => 'ODRZUĆ  ',
    };
    final date = s.sentAt == null ? '' : _day(s.sentAt!);
    final messageCountText =
        s.messages.length > 1 ? '  (${s.messages.length} wiadomości)' : '';
    buf
      ..writeln('$tag ${c.title}  ${s.sender ?? ''}  $date  [${s.threadId}]'
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

/// Ślad domkniętego przebiegu (`summary.md` w archiwum): co weszło, co
/// odpadło przy przeglądzie i jakie odpowiedzi jeszcze czekały. Decyzje
/// automatu (odrzuty, uwagi, kształty mejli) są obok, w `report.txt`.
/// Cel poprawki czyta ze śladu piosenkomatu w [results] — w `final-*` go już nie ma.
String formatRunSummary({
  required RunPlan plan,
  required List<ReviewResult> results,
  required List<String> repliesWaiting,
  required DateTime finalizedAt,
}) {
  String who(String thread) => '${plan.threads[thread]?.sender ?? ''} [$thread]';
  String accepted(Matched m) {
    final song = '„${m.reviewed.title}” — ${who(m.candidate.threadId)}';
    final data = m.reviewed.piosenkomatData;
    if (data == null || !data.isCorrection) return '- `${m.reviewed.id}` $song';
    return switch (data.correctionTarget) {
      final target? => '- `$target` ← $song${data.correctionTargetGuessed ? ' (cel zgadnięty)' : ''}',
      null => '- $song — bez celu w apce',
    };
  }

  final buf = StringBuffer()
    ..writeln('# Przebieg ${plan.id}')
    ..writeln()
    ..writeln('Zeskanowany ${formatMinute(plan.createdAt)}, domknięty ${formatMinute(finalizedAt)}.')
    ..writeln('Decyzje automatu (odrzuty, uwagi, kształty mejli): `report.txt`.');
  void section(String title, List<String> lines) {
    buf
      ..writeln()
      ..writeln('## $title (${lines.length})');
    if (lines.isEmpty) buf.writeln('—');
    for (final l in lines) {
      buf.writeln(l);
    }
  }

  List<String> acceptedOf(SubmissionKind kind) => [
        for (final r in results)
          if (r.kind == kind)
            for (final m in r.accepted) accepted(m),
      ];
  for (final kind in SubmissionKind.values) {
    section(kind.groupName, acceptedOf(kind));
  }
  section('Odrzucone przy przeglądzie', [
    for (final r in results)
      for (final c in r.rejected)
        '- „${c.title}” — ${who(c.threadId)}'
            '${r.reviewNotes.containsKey(c.threadId) ? ' (z odpowiedzią do autora)' : ''}',
  ]);
  section('Czekały na odpowiedź (reply/*)', [for (final t in repliesWaiting) '- ${who(t)}']);
  return buf.toString();
}
