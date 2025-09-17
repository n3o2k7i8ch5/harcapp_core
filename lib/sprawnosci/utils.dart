import 'dart:io';

import 'package:yaml/yaml.dart';

Map readYaml(File file) {
  final content = file.readAsStringSync();
  final yaml = loadYaml(content);
  if (yaml is YamlMap) return Map.from(yaml);
  if (yaml is Map) return yaml;
  throw StateError('Invalid YAML in ${file.path}');
}