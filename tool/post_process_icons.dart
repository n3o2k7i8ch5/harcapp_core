import 'dart:io';

const _file = 'lib/app_mdi_icons.dart';

String _toCamel(String kebab) {
  final parts =
      kebab.split(RegExp(r'[-_]+')).where((p) => p.isNotEmpty).toList();
  if (parts.isEmpty) return kebab;
  return parts.first.toLowerCase() +
      parts
          .skip(1)
          .map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase())
          .join();
}

void main() {
  final f = File(_file);
  if (!f.existsSync()) {
    stderr.writeln('$_file not found — run icon_font_generator first.');
    exit(1);
  }

  final pattern = RegExp(
    r'(/// Font icon named "__([^"]+)__"[\s\S]*?static const IconData )(\w+)(\s*=\s*IconData)',
  );

  var count = 0;
  final updated = f.readAsStringSync().replaceAllMapped(pattern, (m) {
    count++;
    return '${m.group(1)}${_toCamel(m.group(2)!)}${m.group(4)}';
  });

  f.writeAsStringSync(updated);
  stdout.writeln('Renamed $count icon identifier(s) to camelCase.');
}
