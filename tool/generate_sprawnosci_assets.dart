// Usage:
//   dart run tool/generate_sprawnosci_assets.dart [--out=path]
// Behavior:
//   Recursively walks each base directory in BASE_DIRS, and prints every
//   non-empty leaf directory (a directory that has no subdirectories and at
//   least one file) as a pubspec asset line. Results from each base are
//   separated by a single empty line.
//
// To add more sources later, edit BASE_DIRS below.

import 'dart:io';

// EDIT THIS LIST TO ADD MORE SOURCES
const List<String> BASE_DIRS = [
  'assets/sprawnosci/common/zhr_common',
  'assets/sprawnosci/zhp_harc_sim_2022',
  'assets/sprawnosci/zhp_zuch_sim_2022',
  'assets/sprawnosci/zhr_harc_c_sim_2023',
  'assets/sprawnosci/zhr_harc_d_sim_2023',
];

void main(List<String> args) async {
  String? outPath;
  for (final a in args) {
    if (a.startsWith('--out=')) outPath = a.substring('--out='.length);
  }

  final buffer = StringBuffer();

  for (int i = 0; i < BASE_DIRS.length; i++) {
    final base = BASE_DIRS[i];
    final lines = listLeafAssetDirs(base);
    for (final line in lines) buffer.writeln(line);
    if (i != BASE_DIRS.length - 1) buffer.writeln(); // empty line between bases
  }

  final output = buffer.toString();
  if (outPath == null) stdout.write(output);
  else File(outPath).writeAsStringSync(output);
}

List<String> listLeafAssetDirs(String baseDirPath) {
  final baseDir = Directory(baseDirPath);
  if (!baseDir.existsSync()) {
    stderr.writeln('Base not found: $baseDirPath');
    return const [];
  }
  final includedDirs = <String>{};

  void walk(Directory dir) {
    final entries = dir.listSync(followLinks: false);
    final subdirs = entries.whereType<Directory>().toList();
    final files = entries.whereType<File>().toList();
    // Include if it's a leaf with files OR if it has a _data.yaml (needed for YAML loading)
    final hasDataYaml = files.any((f) => f.path.split(Platform.pathSeparator).last == '_data.yaml');
    if ((subdirs.isEmpty && files.isNotEmpty) || hasDataYaml) {
      final norm = dir.path.replaceAll('\\', '/');
      includedDirs.add(norm.endsWith('/') ? norm : '$norm/');
    }
    for (final sub in subdirs)
      walk(sub);

  }

  walk(baseDir);
  final sorted = includedDirs.toList()..sort();
  return sorted.map((p) => '    - $p').toList();
}
