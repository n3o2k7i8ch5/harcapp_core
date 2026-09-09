import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'model.dart';

/// Zapisany wynik `process`: które etykiety automat nadałby któremu mejlowi.
/// Pozwala nadać je później (`apply`) bez ponownego czytania skrzynki.
class LabelPlan {
  final DateTime createdAt;
  final String hrcpsngPath;
  final Map<String, List<String>> labelsById;

  const LabelPlan({
    required this.createdAt,
    required this.hrcpsngPath,
    required this.labelsById,
  });

  factory LabelPlan.fromClassified(List<Classified> items, String hrcpsngPath) => LabelPlan(
        createdAt: DateTime.now(),
        hrcpsngPath: hrcpsngPath,
        labelsById: {
          for (final c in items)
            c.message.id: [...stateLabelsFor(c.verdict), kLabelAuto],
        },
      );

  Map<String, dynamic> toJson() => {
        'created_at': createdAt.toIso8601String(),
        'hrcpsng': hrcpsngPath,
        'labels': labelsById,
      };

  factory LabelPlan.fromJson(Map<String, dynamic> json) => LabelPlan(
        createdAt: DateTime.parse(json['created_at'] as String),
        hrcpsngPath: json['hrcpsng'] as String,
        labelsById: {
          for (final e in (json['labels'] as Map<String, dynamic>).entries)
            e.key: (e.value as List).cast<String>(),
        },
      );
}

String planPathFor(String hrcpsngPath) => p.setExtension(hrcpsngPath, '.labels.json');

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
