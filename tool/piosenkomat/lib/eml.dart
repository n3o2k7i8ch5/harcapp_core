/// Czytanie surowego mejla (RFC 822): nagłówki, części MIME, kodowania, data.
/// Jeden czytnik dla Gmaila (`format: raw`) i dla plików `.eml` w `explain` —
/// inaczej ten sam mejl wyglądał różnie w zależności od drogi.
///
/// Mejl to **bajty**: część w ISO-8859-2 czy windows-1250 nie jest UTF-8
/// i ścisłe `utf8.decode` wywracało na niej cały przebieg. Dlatego całość
/// czytamy jako latin1 (jeden znak = jeden bajt, nic nie ginie), strukturę
/// MIME rozbieramy na tym, a tekst dekodujemy dopiero w części, według jej
/// `charset`. Nic tu nie rzuca: nieczytelny bajt to znak zastępczy, nie błąd.
library;

import 'dart:convert';

/// Nagłówki mejla, ze sklejonymi liniami kontynuowanymi i zdekodowanymi
/// słowami RFC 2047 (`=?UTF-8?B?…?=`). Klucze małymi literami. [block] to
/// bajty jako latin1.
Map<String, String> parseMailHeaders(String block) {
  final out = <String, String>{};
  final unfolded = <String>[];
  for (final line in block.split('\n')) {
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
        decodeHeaderValue(line.substring(colon + 1).trim());
  }
  return out;
}

final _encodedWordRe = RegExp(r'=\?([^?]+)\?([bBqQ])\?([^?]*)\?=');
final _betweenEncodedWordsRe = RegExp(r'(\?=)\s+(=\?)');

/// Wartość nagłówka: słowa RFC 2047 zdekodowane w swoim charsecie, a gołe
/// bajty spoza ASCII — jako UTF-8, gdy się da (tak piszą dzisiejsze klienty),
/// inaczej jako latin1. Odstęp między dwoma słowami zakodowanymi znika.
String decodeHeaderValue(String raw) {
  final joined = raw.replaceAllMapped(_betweenEncodedWordsRe, (m) => '${m[1]}${m[2]}');
  final out = StringBuffer();
  var last = 0;
  for (final m in _encodedWordRe.allMatches(joined)) {
    out.write(_bareHeaderText(joined.substring(last, m.start)));
    final charset = m[1]!, text = m[3]!;
    final bytes = m[2]!.toLowerCase() == 'b'
        ? _base64Bytes(text)
        : _quotedPrintableBytes(text.replaceAll('_', ' '));
    out.write(decodeCharset(bytes, charset));
    last = m.end;
  }
  out.write(_bareHeaderText(joined.substring(last)));
  return out.toString();
}

String _bareHeaderText(String latin1Text) {
  if (latin1Text.codeUnits.every((c) => c < 0x80)) return latin1Text;
  try {
    return utf8.decode(latin1Text.codeUnits);
  } on FormatException {
    return latin1Text;
  }
}

/// Jedna część mejla MIME: własne nagłówki plus surowa zawartość (bajty
/// jako latin1).
class MimePart {
  final Map<String, String> headers;
  final String raw;

  const MimePart(this.headers, this.raw);

  String get contentType => (headers['content-type'] ?? 'text/plain').toLowerCase();
  String? get boundary => _paramOf(headers['content-type'], 'boundary');
  String? get charset => _paramOf(headers['content-type'], 'charset');
  String? get fileName =>
      _paramOf(headers['content-disposition'], 'filename') ??
      _paramOf(headers['content-type'], 'name');

  /// Bajty po zdjęciu kodowania transportowego: base64 albo quoted-printable.
  List<int> get bytes {
    final encoding = (headers['content-transfer-encoding'] ?? '').trim().toLowerCase();
    return switch (encoding) {
      'base64' => _base64Bytes(raw),
      'quoted-printable' => _quotedPrintableBytes(raw),
      _ => raw.codeUnits,
    };
  }

  /// Tekst części w jej charsecie.
  String get content => decodeCharset(bytes, charset);

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
        : MimePart(parseMailHeaders(body.substring(0, split)), body.substring(split + 2));
  }
}

/// Mejl rozebrany na nagłówki i części.
class RawMail {
  final Map<String, String> headers;
  final List<MimePart> parts;

  const RawMail(this.headers, this.parts);

  /// [bytes] całego mejla. Bez bloku nagłówków całość to treść.
  factory RawMail.parse(List<int> bytes) {
    final text = latin1.decode(bytes).replaceAll('\r\n', '\n');
    final split = text.indexOf('\n\n');
    if (split == -1 || !_headerLineRe.hasMatch(text)) {
      return RawMail(const {}, [MimePart(const {}, text)]);
    }
    final headers = parseMailHeaders(text.substring(0, split));
    return RawMail(headers, MimePart(headers, text.substring(split + 2)).flatten());
  }

  static final _headerLineRe = RegExp(r'^[A-Za-z-]+:');

  /// Treść dla człowieka: pierwszy `text/plain` bez nazwy pliku.
  String get plainText =>
      parts.where((p) => p.fileName == null && p.contentType.startsWith('text/plain')).firstOrNull?.content ??
      (parts.isEmpty ? '' : parts.first.content);

  /// Treść pierwszego załącznika o podanym rozszerzeniu.
  String? attachment(String extension) => parts
      .where((p) => (p.fileName ?? '').toLowerCase().endsWith(extension.toLowerCase()))
      .firstOrNull
      ?.content;
}

String? _paramOf(String? header, String name) {
  if (header == null) return null;
  final m = RegExp('$name\\s*=\\s*(?:"([^"]*)"|([^;\\s]+))', caseSensitive: false)
      .firstMatch(header);
  return m?.group(1) ?? m?.group(2);
}

List<int> _base64Bytes(String text) {
  try {
    return base64.decode(base64.normalize(text.replaceAll(RegExp(r'\s'), '')));
  } on FormatException {
    return text.codeUnits;
  }
}

List<int> _quotedPrintableBytes(String raw) {
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
    bytes.add(unfolded.codeUnitAt(i) & 0xff);
  }
  return bytes;
}

/// Bajty tekstu w [charset]. Znane: UTF-8, ISO-8859-1, ISO-8859-2,
/// windows-1250. Bez charsetu, z ASCII (które klienty doklejają do tekstu
/// z polskimi literami) albo z nieznanym: UTF-8, a gdy to nie UTF-8 —
/// windows-1250, najczęstsze po polsku. Nigdy nie rzuca.
String decodeCharset(List<int> bytes, String? charset) {
  final name = (charset ?? '').trim().toLowerCase().replaceAll('_', '-');
  switch (name) {
    case 'utf-8' || 'utf8':
      return utf8.decode(bytes, allowMalformed: true);
    case 'iso-8859-1' || 'latin1' || 'iso8859-1':
      return latin1.decode(bytes, allowInvalid: true);
    case 'iso-8859-2' || 'latin2' || 'iso8859-2':
      return _decodeTable(bytes, _iso88592);
    case 'windows-1250' || 'cp1250' || 'x-cp1250':
      return _decodeTable(bytes, _windows1250);
  }
  try {
    return utf8.decode(bytes);
  } on FormatException {
    return _decodeTable(bytes, _windows1250);
  }
}

String _decodeTable(List<int> bytes, List<int> upper) => String.fromCharCodes([
      for (final b in bytes) b < 0x80 ? b : upper[b - 0x80],
    ]);

/// ISO-8859-2, bajty 0x80–0xFF. 0x80–0x9F to znaki sterujące C1.
const List<int> _iso88592 = [
  0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
  0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
  0xa0, 0x104, 0x2d8, 0x141, 0xa4, 0x13d, 0x15a, 0xa7, 0xa8, 0x160, 0x15e, 0x164, 0x179, 0xad, 0x17d, 0x17b,
  0xb0, 0x105, 0x2db, 0x142, 0xb4, 0x13e, 0x15b, 0x2c7, 0xb8, 0x161, 0x15f, 0x165, 0x17a, 0x2dd, 0x17e, 0x17c,
  ..._latin2Upper,
];

/// windows-1250, bajty 0x80–0xFF. Nieprzypisane → znak zastępczy.
const List<int> _windows1250 = [
  0x20ac, 0xfffd, 0x201a, 0xfffd, 0x201e, 0x2026, 0x2020, 0x2021, 0xfffd, 0x2030, 0x160, 0x2039, 0x15a, 0x164, 0x17d, 0x179,
  0xfffd, 0x2018, 0x2019, 0x201c, 0x201d, 0x2022, 0x2013, 0x2014, 0xfffd, 0x2122, 0x161, 0x203a, 0x15b, 0x165, 0x17e, 0x17a,
  0xa0, 0x2c7, 0x2d8, 0x141, 0xa4, 0x104, 0xa6, 0xa7, 0xa8, 0xa9, 0x15e, 0xab, 0xac, 0xad, 0xae, 0x17b,
  0xb0, 0xb1, 0x2db, 0x142, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0x105, 0x15f, 0xbb, 0x13d, 0x2dd, 0x13e, 0x17c,
  ..._latin2Upper,
];

/// 0xC0–0xFF — takie same w ISO-8859-2 i windows-1250.
const List<int> _latin2Upper = [
  0x154, 0xc1, 0xc2, 0x102, 0xc4, 0x139, 0x106, 0xc7, 0x10c, 0xc9, 0x118, 0xcb, 0x11a, 0xcd, 0xce, 0x10e,
  0x110, 0x143, 0x147, 0xd3, 0xd4, 0x150, 0xd6, 0xd7, 0x158, 0x16e, 0xda, 0x170, 0xdc, 0xdd, 0x162, 0xdf,
  0x155, 0xe1, 0xe2, 0x103, 0xe4, 0x13a, 0x107, 0xe7, 0x10d, 0xe9, 0x119, 0xeb, 0x11b, 0xed, 0xee, 0x10f,
  0x111, 0x144, 0x148, 0xf3, 0xf4, 0x151, 0xf6, 0xf7, 0x159, 0x16f, 0xfa, 0x171, 0xfc, 0xfd, 0x163, 0x2d9,
];

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
