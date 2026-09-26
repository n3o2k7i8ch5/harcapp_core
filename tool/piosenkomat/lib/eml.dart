/// Czytanie surowego mejla (`.eml`): nagłówki, części MIME, kodowania, data.
/// Osobno od modelu zgłoszenia — to warstwa formatu poczty, nie piosenkomatu.
library;

import 'dart:convert';

/// Nagłówki mejla, ze sklejonymi liniami kontynuowanymi. Klucze małymi literami.
Map<String, String> parseMailHeaders(String block) {
  final out = <String, String>{};
  final lines = block.split('\n');
  final unfolded = <String>[];
  for (final line in lines) {
    if (line.startsWith(' ') || line.startsWith('\t')) {
      if (unfolded.isNotEmpty) unfolded[unfolded.length - 1] += ' ${line.trim()}';
      continue;
    }
    unfolded.add(line);
  }
  for (final line in unfolded) {
    final colon = line.indexOf(':');
    if (colon <= 0) continue;
    out[line.substring(0, colon).trim().toLowerCase()] =
        line.substring(colon + 1).trim();
  }
  return out;
}

/// Jedna część mejla MIME: własne nagłówki plus surowa zawartość.
class MimePart {
  final Map<String, String> headers;
  final String raw;

  const MimePart(this.headers, this.raw);

  String get contentType => (headers['content-type'] ?? 'text/plain').toLowerCase();
  String? get boundary => _paramOf(headers['content-type'], 'boundary');
  String? get fileName =>
      _paramOf(headers['content-disposition'], 'filename') ??
      _paramOf(headers['content-type'], 'name');

  /// Zawartość po zdjęciu kodowania transportowego: base64 albo
  /// quoted-printable.
  String get content {
    final encoding =
        (headers['content-transfer-encoding'] ?? '').trim().toLowerCase();
    if (encoding == 'base64') {
      try {
        return utf8.decode(base64.decode(raw.replaceAll(RegExp(r'\s'), '')));
      } catch (_) {
        return raw;
      }
    }
    if (encoding == 'quoted-printable') return _decodeQuotedPrintable(raw);
    return raw;
  }

  /// Płaska lista części, także z zagnieżdżonych `multipart/*`.
  List<MimePart> flatten() {
    final b = boundary;
    if (b == null || !contentType.startsWith('multipart/')) return [this];
    // Preambuła przed pierwszym separatorem i epilog po `--boundary--`
    // częściami nie są.
    return [
      for (final chunk in raw
          .split('--$b')
          .skip(1)
          .takeWhile((c) => !c.trimLeft().startsWith('--')))
        ..._partOf(chunk).flatten(),
    ];
  }

  static MimePart _partOf(String chunk) {
    final body = chunk.startsWith('\n') ? chunk.substring(1) : chunk;
    final split = body.indexOf('\n\n');
    return split == -1
        ? MimePart(const {}, body)
        : MimePart(parseMailHeaders(body.substring(0, split)),
            body.substring(split + 2));
  }
}

extension MimeParts on List<MimePart> {
  /// Treść dla człowieka: pierwszy `text/plain` bez nazwy pliku.
  String get plainText =>
      where((p) => p.fileName == null && p.contentType.startsWith('text/plain'))
          .firstOrNull
          ?.content ??
      (isEmpty ? '' : first.content);

  /// Treść pierwszego załącznika o podanym rozszerzeniu.
  String? attachment(String extension) => where((p) =>
          (p.fileName ?? '').toLowerCase().endsWith(extension.toLowerCase()))
      .firstOrNull
      ?.content;
}

String? _paramOf(String? header, String name) {
  if (header == null) return null;
  final m = RegExp('$name\\s*=\\s*(?:"([^"]*)"|([^;\\s]+))', caseSensitive: false)
      .firstMatch(header);
  return m?.group(1) ?? m?.group(2);
}

String _decodeQuotedPrintable(String raw) {
  final unfolded = raw.replaceAll(RegExp(r'=\r?\n'), '');
  final bytes = <int>[];
  for (var i = 0; i < unfolded.length; i++) {
    if (unfolded[i] == '=' && i + 2 < unfolded.length) {
      final hex = int.tryParse(unfolded.substring(i + 1, i + 3), radix: 16);
      if (hex != null) {
        bytes.add(hex);
        i += 2;
        continue;
      }
    }
    bytes.addAll(utf8.encode(unfolded[i]));
  }
  try {
    return utf8.decode(bytes);
  } catch (_) {
    return unfolded;
  }
}

const _months = {
  'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
  'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
};
final _rfc2822DateRe = RegExp(
    r'(\d{1,2})\s+([A-Za-z]{3})\s+(\d{4})\s+(\d{1,2}):(\d{2})(?::(\d{2}))?'
    r'(?:\s+([+-])(\d{2})(\d{2}))?');

/// Nagłówek `Date:` mejla. Prawdziwe klienty piszą po RFC 2822
/// (`Thu, 11 Sep 2026 10:00:00 +0200`), czego `DateTime.tryParse` nie czyta —
/// bez tego każdy plik `.eml` w `explain` miał datę `null` i o tym, które
/// zgłoszenie jest starsze, decydowała kolejność argumentów.
DateTime? parseMailDate(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  final iso = DateTime.tryParse(raw.trim());
  if (iso != null) return iso;
  final m = _rfc2822DateRe.firstMatch(raw);
  if (m == null) return null;
  final month = _months[m.group(2)!.toLowerCase()];
  if (month == null) return null;
  final utc = DateTime.utc(
    int.parse(m.group(3)!),
    month,
    int.parse(m.group(1)!),
    int.parse(m.group(4)!),
    int.parse(m.group(5)!),
    int.parse(m.group(6) ?? '0'),
  );
  if (m.group(7) == null) return utc;
  final offset = Duration(
      hours: int.parse(m.group(8)!), minutes: int.parse(m.group(9)!));
  return m.group(7) == '+' ? utc.subtract(offset) : utc.add(offset);
}
