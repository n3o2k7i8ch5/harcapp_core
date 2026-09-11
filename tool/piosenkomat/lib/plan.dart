import 'dart:convert';
import 'dart:io';

import 'hrcpsng.dart';
import 'model.dart';

/// Który plik przebiegu: bez zarzutów czy do przeglądu.
enum RunFile {
  auto('auto'),
  review('review');

  const RunFile(this.key);
  final String key;

  static RunFile byKey(String key) =>
      RunFile.values.where((f) => f.key == key).firstOrNull ?? RunFile.auto;
}

/// Piosenka, którą automat wstawił do pliku. Wiąże wpis w `.hrcpsng`
/// z mejlem, nawet gdy strona zgubi `email_msg_id` przy eksporcie.
class PlannedSong {
  final String songId;
  final String title;
  /// Nadawca — po nim poznasz, czyj wpis w `people.dart` był niepotrzebny,
  /// jeśli piosenka wypadnie przy przeglądzie.
  final String sender;
  final RunFile file;
  /// Uwagi, z jakimi piosenka pojechała do przeglądu. Po powrocie z edytora
  /// porównujemy je z tym, co zostało — stąd wiadomo, co ogarnąłeś.
  final List<String> issues;

  const PlannedSong({
    required this.songId,
    required this.title,
    required this.sender,
    this.file = RunFile.auto,
    this.issues = const [],
  });

  Map<String, dynamic> toJson() => {
        'song_id': songId,
        'title': title,
        'sender': sender,
        'file': file.key,
        'issues': issues,
      };

  factory PlannedSong.fromJson(Map<String, dynamic> json) => PlannedSong(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        sender: json['sender'] as String? ?? '',
        file: RunFile.byKey(json['file'] as String? ?? RunFile.auto.key),
        issues: ((json['issues'] ?? const []) as List).cast<String>(),
      );
}

/// Zapisany wynik `scan`: które etykiety automat nadałby któremu mejlowi
/// i co z którego mejla poszło do którego pliku.
/// Pozwala nadać etykiety później (`label scanned`) bez ponownego czytania
/// skrzynki.
class LabelPlan {
  final DateTime createdAt;
  /// Ścieżki plików przebiegu, po [RunFile.key].
  final Map<String, String> files;
  final Map<String, List<String>> labelsById;
  /// Tylko mejle, z których coś poszło do pliku. Lista, bo kiedyś jeden mejl
  /// może nieść kilka piosenek; dziś zawsze jednoelementowa.
  final Map<String, List<PlannedSong>> songsById;

  const LabelPlan({
    required this.createdAt,
    required this.files,
    required this.labelsById,
    this.songsById = const {},
  });

  String? get autoPath => files[RunFile.auto.key];
  String? get reviewPath => files[RunFile.review.key];

  factory LabelPlan.fromClassified(
    List<Classified> items, {
    required Map<RunFile, String> files,
  }) =>
      LabelPlan(
        createdAt: DateTime.now(),
        files: {for (final e in files.entries) e.key.key: e.value},
        labelsById: {
          for (final c in items) c.message.id: [...c.labels, kLabelAuto],
        },
        songsById: {
          for (final c in items)
            if (c.song case final song?)
              if (c.goesToApp || c.goesToReview)
                c.message.id: [
                  PlannedSong(
                    songId: song.id,
                    title: song.title,
                    sender: c.sender ?? '',
                    file: c.goesToApp ? RunFile.auto : RunFile.review,
                    issues: [for (final i in c.issues) i.issue.id],
                  ),
                ],
        },
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt.toIso8601String(),
        'files': files,
        'labels': labelsById,
        'songs': {
          for (final e in songsById.entries)
            e.key: [for (final i in e.value) i.toJson()],
        },
      };

  factory LabelPlan.fromJson(Map<String, dynamic> json) => LabelPlan(
        createdAt: DateTime.parse(json['created_at'] as String),
        // Plany sprzed podziału na `auto` i `review` miały jeden plik
        // pod kluczem `hrcpsng`.
        files: {
          if (json['hrcpsng'] is String) RunFile.auto.key: json['hrcpsng'] as String,
          for (final e in ((json['files'] ?? {}) as Map<String, dynamic>).entries)
            e.key: e.value as String,
        },
        labelsById: {
          for (final e in (json['labels'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
        // Plany z wcześniejszych wersji narzędzia mają tę sekcję pod `imports`.
        songsById: {
          for (final e in ((json['songs'] ?? json['imports'] ?? {}) as Map<String, dynamic>).entries)
            e.key: [
              for (final i in e.value as List)
                PlannedSong.fromJson(i as Map<String, dynamic>),
            ],
        },
      );
}

void writePlan(String path, LabelPlan plan) =>
    writeText(path, const JsonEncoder.withIndent('  ').convert(plan.toJson()));

LabelPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return LabelPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
