import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'hrcpsng.dart';
import 'model.dart';

/// Piosenka, którą automat wstawił do pliku kandydatów. Wiąże wpis
/// w `.hrcpsng` ze zgłoszeniem (wątkiem), nawet gdy strona zgubi
/// `thread_id` przy eksporcie.
class PlannedSong {
  final String songId;
  final String title;
  /// Pozostałe adresy z bloku „Osoba dodająca”. Piosenka niesie tylko jeden
  /// (`email_ref`), a `people.dart` powstaje dopiero po przeglądzie, więc
  /// reszta musi tu przeczekać.
  final List<String> otherEmails;
  final SubmissionKind kind;

  const PlannedSong({
    required this.songId,
    required this.title,
    this.kind = SubmissionKind.newSong,
    this.otherEmails = const [],
  });

  Map<String, dynamic> toJson() => {
        'song_id': songId,
        'title': title,
        'kind': kind.id,
        if (otherEmails.isNotEmpty) 'other_emails': otherEmails,
      };

  factory PlannedSong.fromJson(Map<String, dynamic> json) => PlannedSong(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        kind: SubmissionKind.byId(json['kind'] as String?),
        otherEmails:
            ((json['other_emails'] ?? const []) as List).cast<String>(),
      );
}

/// Nazwa przebiegu: data i godzina `scan --push`, np. `import-2026-09-28T101500`.
/// Tak nazywa się też jego katalog w archiwum i pole `run` w piosenkach.
String newRunId(DateTime at) =>
    'import-${at.toIso8601String().substring(0, 19).replaceAll(':', '')}';

/// Plan przebiegu (`plan.json`), czyli zapisany wynik `scan`: które etykiety
/// automat nadaje któremu mejlowi, co z którego wątku poszło do pliku i kto
/// zgłaszał. Po nim `review` i `finalize` wiedzą, które mejle są ich —
/// bez ponownego czytania skrzynki.
class RunPlan {
  final String id;
  final DateTime createdAt;
  /// Kiedy `scan --push` skończył: etykiety i szkice są w Gmailu. `null` —
  /// przerwany w połowie; kolejny `scan --push` go dokończy.
  final DateTime? pushedAt;
  /// Etykiety po **wiadomości** — wątek dostaje je na wszystkich.
  final Map<String, List<String>> labelsByMessage;
  /// Piosenka po **wątku** — jeden wątek to jedna piosenka.
  final Map<String, PlannedSong> songByThread;
  /// Wiadomości każdego wątku, od najstarszej — etykiety idą na cały wątek.
  final Map<String, List<String>> messagesByThread;
  /// Nadawca każdego wątku — po nim szkice odpowiedzi liczą się per autor,
  /// a `people.dart` dokłada adresy z planu. Wątki bez czytelnego nadawcy nie
  /// mają wpisu.
  final Map<String, String> senderByThread;

  const RunPlan({
    required this.id,
    required this.createdAt,
    required this.labelsByMessage,
    required this.songByThread,
    required this.messagesByThread,
    this.senderByThread = const {},
    this.pushedAt,
  });

  factory RunPlan.fromClassified(List<Classified> items, {required String id}) => RunPlan(
        id: id,
        createdAt: DateTime.now(),
        labelsByMessage: {
          for (final c in items)
            for (final m in c.submission.messages)
              m.id: [...c.labels, SongLabel.auto.label],
        },
        songByThread: {
          for (final c in items)
            if (c.goesToFile)
              c.submission.threadId: PlannedSong(
                songId: c.song!.id,
                title: c.song!.title,
                kind: c.submission.kind,
                otherEmails: _otherEmailsOf(c),
              ),
        },
        messagesByThread: {
          for (final c in items)
            c.submission.threadId: [for (final m in c.submission.messages) m.id],
        },
        senderByThread: {
          for (final c in items)
            if (c.submission.sender case final sender?) c.submission.threadId: sender,
        },
      );

  /// Ten sam plan po skończonym `scan --push`.
  RunPlan pushed(DateTime at) => RunPlan(
        id: id,
        createdAt: createdAt,
        pushedAt: at,
        labelsByMessage: labelsByMessage,
        songByThread: songByThread,
        messagesByThread: messagesByThread,
        senderByThread: senderByThread,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        if (pushedAt != null) 'pushed_at': pushedAt!.toIso8601String(),
        'labels': labelsByMessage,
        'songs': {
          for (final e in songByThread.entries) e.key: e.value.toJson(),
        },
        'threads': messagesByThread,
        'senders': senderByThread,
      };

  factory RunPlan.fromJson(Map<String, dynamic> json) => RunPlan(
        id: json['id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        pushedAt: switch (json['pushed_at']) { final String at => DateTime.parse(at), _ => null },
        labelsByMessage: {
          for (final e in (json['labels'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
        songByThread: {
          for (final e in (json['songs'] as Map<String, dynamic>).entries)
            e.key: PlannedSong.fromJson(e.value as Map<String, dynamic>),
        },
        messagesByThread: {
          for (final e in (json['threads'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
        senderByThread: (json['senders'] as Map<String, dynamic>).cast<String, String>(),
      );

  /// Wiadomości wątku. Plan zna wszystkie wątki przebiegu, więc pusta lista
  /// znaczy, że pytasz o wątek spoza niego.
  List<String> messagesOf(String threadId) =>
      messagesByThread[threadId] ?? const [];
}

/// Adresy z bloku „Osoba dodająca” poza adresem nadawcy — ten jest już
/// w `email_ref` piosenki.
List<String> _otherEmailsOf(Classified c) {
  final sender = normalizedEmail(c.submission.sender ?? '');
  return [
    for (final e in c.submission.registered?.emails ?? const <String>[])
      if (normalizedEmail(e) case final n when n.isNotEmpty && n != sender) e.trim(),
  ];
}

/// Dodatkowe adresy z przebiegu, po nadawcy — tyle, ile `people.dart`
/// potrzebuje od planu.
Map<String, List<String>> otherEmailsBySender(RunPlan plan) {
  final out = <String, List<String>>{};
  for (final MapEntry(key: thread, value: s) in plan.songByThread.entries) {
    final sender = normalizedEmail(plan.senderByThread[thread] ?? '');
    if (sender.isEmpty || s.otherEmails.isEmpty) continue;
    final into = out.putIfAbsent(sender, () => []);
    for (final e in s.otherEmails) {
      if (!into.contains(e)) into.add(e);
    }
  }
  return out;
}

/// Czy przebieg jest w Gmailu: choć jeden jego mejl ma znacznik automatu.
/// Stawia go `scan --push`, zdejmuje `unlabel`.
bool isRunInGmail(RunPlan plan, Map<String, Set<String>> labelsByMessage) =>
    plan.labelsByMessage.keys
        .any((id) => labelsByMessage[id]?.contains(SongLabel.auto.label) ?? false);

/// Co `unlabel` zdejmie. Swoje automat poznaje po znaczniku `song/auto` —
/// Ty go nie wieszasz, więc Twoje ręczne etykiety zostają nietknięte.
/// [scope] to mejle cofanego przebiegu; `null` — cała skrzynka.
///
/// Bezpiecznik: mejla z `song/added` nie ruszamy bez [force] — piosenka jest
/// już w apce, a zdjęcie etykiet wepchnęłoby ją z powrotem do kolejki.
({Map<String, List<String>> toRemove, int outsideScope, int added}) unlabelChanges(
  Map<String, Set<String>> labelsByMessage, {
  Set<String>? scope,
  bool force = false,
}) {
  final toRemove = <String, List<String>>{};
  var outsideScope = 0;
  var added = 0;
  for (final e in labelsByMessage.entries) {
    if (!e.value.contains(SongLabel.auto.label)) continue;
    if (scope != null && !scope.contains(e.key)) {
      outsideScope++;
      continue;
    }
    if (e.value.contains(SongLabel.added.label) && !force) {
      added++;
      continue;
    }
    final labels = [for (final l in kToolLabels) if (e.value.contains(l)) l];
    if (labels.isNotEmpty) toRemove[e.key] = labels;
  }
  return (toRemove: toRemove, outsideScope: outsideScope, added: added);
}

void writePlan(String path, RunPlan plan) =>
    writeText(path, const JsonEncoder.withIndent('  ').convert(plan.toJson()));

RunPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return RunPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
