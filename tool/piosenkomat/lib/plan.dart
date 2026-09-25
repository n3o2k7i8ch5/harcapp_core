import 'dart:convert';
import 'dart:io';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';

import 'hrcpsng.dart';
import 'model.dart';

/// Piosenka, którą automat wstawił do pliku kandydatów. Wiąże wpis
/// w `.hrcpsng` ze zgłoszeniem (wątkiem), nawet gdy strona zgubi
/// `thread_id` przy eksporcie.
class PlannedSong {
  final String songId;
  final String title;
  /// Nadawca — po nim `prepare` wiąże piosenkę z osobą dodającą.
  final String sender;
  /// Pozostałe adresy z bloku „Osoba dodająca”. Piosenka niesie tylko jeden
  /// (`email_ref`), a `people.dart` powstaje dopiero po przeglądzie, więc
  /// reszta musi tu przeczekać.
  final List<String> otherEmails;
  final SubmissionKind kind;

  const PlannedSong({
    required this.songId,
    required this.title,
    required this.sender,
    this.kind = SubmissionKind.newSong,
    this.otherEmails = const [],
  });

  Map<String, dynamic> toJson() => {
        'song_id': songId,
        'title': title,
        'sender': sender,
        'kind': kind.id,
        if (otherEmails.isNotEmpty) 'other_emails': otherEmails,
      };

  factory PlannedSong.fromJson(Map<String, dynamic> json) => PlannedSong(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        sender: json['sender'] as String,
        kind: SubmissionKind.byId(json['kind'] as String?),
        otherEmails:
            ((json['other_emails'] ?? const []) as List).cast<String>(),
      );
}

/// Plan przebiegu (`plan.json`), czyli zapisany wynik `scan`: które etykiety
/// automat nadałby któremu mejlowi i co z którego wątku poszło do pliku.
/// Pozwala nadać etykiety później (`label scanned`) bez ponownego czytania
/// skrzynki.
class RunPlan {
  final DateTime createdAt;
  /// Etykiety po **wiadomości** — wątek dostaje je na wszystkich.
  final Map<String, List<String>> labelsByMessage;
  /// Piosenka po **wątku** — jeden wątek to jedna piosenka.
  final Map<String, PlannedSong> songByThread;
  /// Wiadomości każdego wątku — `label reviewed` przestawia etykiety na całym.
  final Map<String, List<String>> messagesByThread;

  const RunPlan({
    required this.createdAt,
    required this.labelsByMessage,
    required this.songByThread,
    required this.messagesByThread,
  });

  factory RunPlan.fromClassified(List<Classified> items) => RunPlan(
        createdAt: DateTime.now(),
        labelsByMessage: {
          for (final c in items)
            for (final m in c.submission.messages)
              m.id: [...c.labels, kLabelAuto],
        },
        songByThread: {
          for (final c in items)
            if (c.goesToFile)
              c.submission.threadId: PlannedSong(
                songId: c.song!.id,
                title: c.song!.title,
                sender: c.submission.sender ?? '',
                kind: c.submission.kind,
                otherEmails: _otherEmailsOf(c),
              ),
        },
        messagesByThread: {
          for (final c in items)
            c.submission.threadId: [for (final m in c.submission.messages) m.id],
        },
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt.toIso8601String(),
        'labels': labelsByMessage,
        'songs': {
          for (final e in songByThread.entries) e.key: e.value.toJson(),
        },
        'threads': messagesByThread,
      };

  factory RunPlan.fromJson(Map<String, dynamic> json) => RunPlan(
        createdAt: DateTime.parse(json['created_at'] as String),
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
      );

  /// Wiadomości wątku. Plan zna wszystkie wątki przebiegu, więc pusta lista
  /// znaczy, że pytasz o wątek spoza niego.
  List<String> messagesOf(String threadId) =>
      messagesByThread[threadId] ?? const [];

  /// Piosenka przebiegu po id mejla — do wypisania tytułu i nadawcy.
  Map<String, PlannedSong> get songByMessage => {
        for (final e in songByThread.entries)
          for (final messageId in messagesOf(e.key)) messageId: e.value,
      };
}

/// Adresy z bloku „Osoba dodająca” poza adresem nadawcy — ten jest już
/// w `email_ref` piosenki.
List<String> _otherEmailsOf(Classified c) {
  final sender = (c.submission.sender ?? '').trim().toLowerCase();
  return [
    for (final e in c.submission.registered?.emails ?? const <String>[])
      if (e.trim().isNotEmpty && e.trim().toLowerCase() != sender) e.trim(),
  ];
}

/// Dodatkowe adresy z przebiegu, po nadawcy — tyle, ile `people.dart`
/// potrzebuje od planu.
Map<String, List<String>> otherEmailsBySender(RunPlan plan) {
  final out = <String, List<String>>{};
  for (final s in plan.songByThread.values) {
    final sender = s.sender.trim().toLowerCase();
    if (sender.isEmpty || s.otherEmails.isEmpty) continue;
    final into = out.putIfAbsent(sender, () => []);
    for (final e in s.otherEmails) {
      if (!into.contains(e)) into.add(e);
    }
  }
  return out;
}

/// Co `unlabel` zdejmie. Swoje automat poznaje po znaczniku `song/auto` —
/// Ty go nie wieszasz, więc Twoje ręczne etykiety zostają nietknięte.
/// Z [plan] tylko mejle przebiegu; bez — cała skrzynka.
///
/// Bezpiecznik: mejla z `song/added` nie ruszamy bez [force] — piosenka jest
/// już w apce, a zdjęcie etykiet wepchnęłoby ją z powrotem do kolejki.
({Map<String, List<String>> toRemove, int outsidePlan, int added}) unlabelChanges(
  Map<String, Set<String>> labelsByMessage, {
  RunPlan? plan,
  bool force = false,
}) {
  final toRemove = <String, List<String>>{};
  var outsidePlan = 0;
  var added = 0;
  for (final e in labelsByMessage.entries) {
    if (!e.value.contains(kLabelAuto)) continue;
    if (plan != null && !plan.labelsByMessage.containsKey(e.key)) {
      outsidePlan++;
      continue;
    }
    if (e.value.contains(kLabelAdded) && !force) {
      added++;
      continue;
    }
    final labels = [for (final l in kToolLabels) if (e.value.contains(l)) l];
    if (labels.isNotEmpty) toRemove[e.key] = labels;
  }
  return (toRemove: toRemove, outsidePlan: outsidePlan, added: added);
}

void writePlan(String path, RunPlan plan) =>
    writeText(path, const JsonEncoder.withIndent('  ').convert(plan.toJson()));

RunPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return RunPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
