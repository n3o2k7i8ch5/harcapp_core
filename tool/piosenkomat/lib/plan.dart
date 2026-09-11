import 'dart:convert';
import 'dart:io';

import 'model.dart';

/// Piosenka, którą automat wstawił do pliku. Wiąże wpis w `.hrcpsng`
/// z mejlem, nawet gdy strona zgubi `email_msg_id` przy eksporcie.
class PlannedImport {
  final String songId;
  final String title;
  /// Nadawca — po nim poznasz, czyj wpis w `people.dart` był niepotrzebny,
  /// jeśli piosenka wypadnie przy przeglądzie.
  final String sender;

  const PlannedImport({
    required this.songId,
    required this.title,
    required this.sender,
  });

  Map<String, dynamic> toJson() =>
      {'song_id': songId, 'title': title, 'sender': sender};

  factory PlannedImport.fromJson(Map<String, dynamic> json) => PlannedImport(
        songId: json['song_id'] as String,
        title: json['title'] as String,
        sender: json['sender'] as String? ?? '',
      );
}

/// Zapisany wynik `process`: które etykiety automat nadałby któremu mejlowi.
/// Pozwala nadać je później (`apply`) bez ponownego czytania skrzynki.
class LabelPlan {
  final DateTime createdAt;
  final String hrcpsngPath;
  final Map<String, List<String>> labelsById;
  /// Tylko mejle, z których coś poszło do pliku. Lista, bo kiedyś jeden mejl
  /// może nieść kilka piosenek; dziś zawsze jednoelementowa.
  final Map<String, List<PlannedImport>> importsById;

  const LabelPlan({
    required this.createdAt,
    required this.hrcpsngPath,
    required this.labelsById,
    this.importsById = const {},
  });

  factory LabelPlan.fromClassified(List<Classified> items, String hrcpsngPath) => LabelPlan(
        createdAt: DateTime.now(),
        hrcpsngPath: hrcpsngPath,
        labelsById: {
          for (final c in items)
            c.message.id: [...c.labels, kLabelAuto],
        },
        importsById: {
          for (final c in items)
            if (c.verdict case Import(:final song, :final sender))
              c.message.id: [
                PlannedImport(songId: song.id, title: song.title, sender: sender),
              ],
        },
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt.toIso8601String(),
        'hrcpsng': hrcpsngPath,
        'labels': labelsById,
        'imports': {
          for (final e in importsById.entries)
            e.key: [for (final i in e.value) i.toJson()],
        },
      };

  factory LabelPlan.fromJson(Map<String, dynamic> json) => LabelPlan(
        createdAt: DateTime.parse(json['created_at'] as String),
        hrcpsngPath: json['hrcpsng'] as String,
        labelsById: {
          for (final e in (json['labels'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
        // Plany z wcześniejszych wersji narzędzia tej sekcji nie mają.
        importsById: {
          for (final e in ((json['imports'] ?? {}) as Map<String, dynamic>).entries)
            e.key: [
              for (final i in e.value as List)
                PlannedImport.fromJson(i as Map<String, dynamic>),
            ],
        },
      );
}

void writePlan(String path, LabelPlan plan) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(plan.toJson()));
}

LabelPlan readPlan(String path) {
  final file = File(path);
  if (!file.existsSync()) throw FileSystemException('Nie ma pliku planu', path);
  return LabelPlan.fromJson(jsonDecode(file.readAsStringSync()) as Map<String, dynamic>);
}
