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
  /// Uwagi, z jakimi piosenka pojechała do przeglądu — do `decisions.json`.
  final List<String> issues;

  const PlannedSong({
    required this.songId,
    required this.title,
    required this.sender,
    this.kind = SubmissionKind.newSong,
    this.issues = const [],
    this.otherEmails = const [],
  });

  Map<String, dynamic> toJson() => {
        'song_id': songId,
        'title': title,
        'sender': sender,
        'kind': kind.id,
        'issues': issues,
        if (otherEmails.isNotEmpty) 'other_emails': otherEmails,
      };

  factory PlannedSong.fromJson(Map<String, dynamic> json) => PlannedSong(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        sender: json['sender'] as String? ?? '',
        kind: SubmissionKind.byId(json['kind'] as String?),
        issues: ((json['issues'] ?? const []) as List).cast<String>(),
        otherEmails:
            ((json['other_emails'] ?? const []) as List).cast<String>(),
      );
}

/// Zapisany wynik `scan`: które etykiety automat nadałby któremu mejlowi
/// i co z którego wątku poszło do pliku. Pozwala nadać etykiety później
/// (`label scanned`) bez ponownego czytania skrzynki.
class LabelPlan {
  final DateTime createdAt;
  /// Etykiety po **wiadomości** — wątek dostaje je na wszystkich.
  final Map<String, List<String>> labelsById;
  /// Piosenki po **wątku**. Lista, bo kiedyś jeden wątek może nieść kilka
  /// piosenek; dziś zawsze jednoelementowa.
  final Map<String, List<PlannedSong>> songsByThread;
  /// Wiadomości każdego wątku — `label reviewed` przestawia etykiety na całym.
  final Map<String, List<String>> messagesByThread;

  const LabelPlan({
    required this.createdAt,
    required this.labelsById,
    this.songsByThread = const {},
    this.messagesByThread = const {},
  });

  factory LabelPlan.fromClassified(List<Classified> items) => LabelPlan(
        createdAt: DateTime.now(),
        labelsById: {
          for (final c in items)
            for (final m in c.submission.messages)
              m.id: [...c.labels, kLabelAuto],
        },
        songsByThread: {
          for (final c in items)
            if (c.goesToFile)
              c.submission.threadId: [
                PlannedSong(
                  songId: c.song!.id,
                  title: c.song!.title,
                  sender: c.submission.sender ?? '',
                  kind: c.submission.kind,
                  issues: [for (final i in c.issues) i.issue.id],
                  otherEmails: _otherEmailsOf(c),
                ),
              ],
        },
        messagesByThread: {
          for (final c in items)
            c.submission.threadId: [for (final m in c.submission.messages) m.id],
        },
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt.toIso8601String(),
        'labels': labelsById,
        'songs': {
          for (final e in songsByThread.entries)
            e.key: [for (final i in e.value) i.toJson()],
        },
        'threads': messagesByThread,
      };

  factory LabelPlan.fromJson(Map<String, dynamic> json) => LabelPlan(
        createdAt: DateTime.parse(json['created_at'] as String),
        labelsById: {
          for (final e in (json['labels'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
        songsByThread: {
          for (final e in ((json['songs'] ?? <String, dynamic>{}) as Map<String, dynamic>).entries)
            e.key: [
              for (final i in e.value as List)
                PlannedSong.fromJson(i as Map<String, dynamic>),
            ],
        },
        messagesByThread: {
          for (final e in ((json['threads'] ?? <String, dynamic>{}) as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
      );

  /// Wiadomości wątku. Plan zna wszystkie wątki przebiegu, więc pusta lista
  /// znaczy, że pytasz o wątek spoza niego.
  List<String> messagesOf(String threadId) =>
      messagesByThread[threadId] ?? const [];
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
Map<String, List<String>> otherEmailsBySender(LabelPlan plan) {
  final out = <String, List<String>>{};
  for (final songs in plan.songsByThread.values) {
    for (final s in songs) {
      final sender = s.sender.trim().toLowerCase();
      if (sender.isEmpty || s.otherEmails.isEmpty) continue;
      final into = out.putIfAbsent(sender, () => []);
      for (final e in s.otherEmails) {
        if (!into.contains(e)) into.add(e);
      }
    }
  }
  return out;
}

void writePlan(String path, LabelPlan plan) =>
    writeText(path, const JsonEncoder.withIndent('  ').convert(plan.toJson()));

LabelPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return LabelPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
