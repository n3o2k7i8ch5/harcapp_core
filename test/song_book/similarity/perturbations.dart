/// Zmiany, jakie ludzie robią piosenkom, zanim je zgłoszą: literówki,
/// przesunięty refren, dopisane zwrotki, przeróbki. Na kanonicznym JSON-ie
/// piosenki (`parts` / `refren`), żeby porównanie widziało dokładnie to,
/// co przy prawdziwym zgłoszeniu.
library;

import 'dart:convert';
import 'dart:math';

import 'package:harcapp_core/song_book/song_editor/song_raw.dart';

typedef SongJson = Map<String, dynamic>;

/// Zmiana piosenki; `null`, gdy do tej piosenki nie pasuje (np. przesunięcie
/// refrenu w piosence bez refrenu).
typedef Perturbation = SongJson? Function(SongJson song, Random r, List<SongRaw> book);

SongJson songJson(SongRaw s) => jsonDecode(jsonEncode(s.toApiJsonMap(withId: false))) as SongJson;

SongRaw fromJson(String id, SongJson m) => SongRaw.fromApiRespMap(id, m);

List<SongJson> _parts(SongJson m) => (m['parts'] as List).cast<SongJson>();
bool _hasRefrain(SongJson m) => m.containsKey('refren');
List<SongJson> _verses(SongJson m) => [for (final p in _parts(m)) if (p.containsKey('text')) p];

final _word = RegExp(r'[\p{L}]{2,}', unicode: true);

const _neighbours = {
  'q': 'wa', 'w': 'qes', 'e': 'wrd', 'r': 'etf', 't': 'ryg', 'y': 'tuh', 'u': 'yij', 'i': 'uok', 'o': 'ipl',
  'p': 'ol', 'a': 'qsz', 's': 'awdz', 'd': 'sefx', 'f': 'drgc', 'g': 'fthv', 'h': 'gjyb', 'j': 'hkun',
  'k': 'jlim', 'l': 'kop', 'z': 'asx', 'x': 'zsdc', 'c': 'xdfv', 'v': 'cfgb', 'b': 'vghn', 'n': 'bhjm', 'm': 'njk',
};

/// Jedna literówka: najpierw klasyki ortografii (ó/u, rz/ż, ch/h), potem
/// palce — zjedzona, przestawiona, sąsiednia albo podwójna litera.
String _typo(String w, Random r) {
  const spelling = [['ó', 'u'], ['u', 'ó'], ['rz', 'ż'], ['ż', 'rz'], ['ch', 'h'], ['h', 'ch'], ['ą', 'om'], ['ę', 'e']];
  if (r.nextDouble() < 0.3) {
    final fits = [for (final p in spelling) if (w.contains(p[0])) p];
    if (fits.isNotEmpty) {
      final p = fits[r.nextInt(fits.length)];
      return w.replaceFirst(p[0], p[1]);
    }
  }
  final i = r.nextInt(w.length);
  switch (r.nextInt(4)) {
    case 0:
      return w.substring(0, i) + w.substring(i + 1);
    case 1:
      return i + 1 < w.length ? w.substring(0, i) + w[i + 1] + w[i] + w.substring(i + 2) : w.substring(0, i);
    case 2:
      final nb = _neighbours[w[i].toLowerCase()];
      return nb == null ? w.substring(0, i) + w.substring(i + 1) : w.substring(0, i) + nb[r.nextInt(nb.length)] + w.substring(i + 1);
    default:
      return w.substring(0, i) + w[i] + w.substring(i);
  }
}

String _mapWords(String text, double p, Random r, String Function(String) f) =>
    text.replaceAllMapped(_word, (m) => r.nextDouble() < p ? f(m[0]!) : m[0]!);

void _mapTexts(SongJson m, String Function(String) f) {
  for (final p in _parts(m)) {
    if (p.containsKey('text')) p['text'] = f(p['text'] as String);
  }
  if (_hasRefrain(m)) (m['refren'] as SongJson)['text'] = f((m['refren'] as SongJson)['text'] as String);
}

void _mapChords(SongJson m, String Function(String) f) {
  for (final p in _parts(m)) {
    if (p.containsKey('chords')) p['chords'] = f(p['chords'] as String);
  }
  if (_hasRefrain(m)) (m['refren'] as SongJson)['chords'] = f((m['refren'] as SongJson)['chords'] as String);
}

List<String>? _vocabulary;
List<String> _vocab(List<SongRaw> book) =>
    _vocabulary ??= [for (final s in book) ..._word.allMatches(s.text).map((e) => e[0]!)];

// ---------------------------------------------------------------------------

SongJson? metadataOnly(SongJson m, Random r, List<SongRaw> book) => m
  ..['performers'] = ['Ktoś Inny']
  ..['tags'] = ['#Inny']
  ..['yt_video_id'] = 'abcdefghijk';

/// Refren wpisany jak zwykłe zwrotki, w tych samych miejscach.
SongJson? refrainNotMarked(SongJson m, Random r, List<SongRaw> book) {
  if (!_hasRefrain(m)) return null;
  final ref = m.remove('refren') as SongJson;
  m['parts'] = [
    for (final p in _parts(m))
      if (p.containsKey('refren'))
        for (var i = 0; i < (p['refren'] as int); i++) {'text': ref['text'], 'chords': ref['chords'], 'shift': false}
      else
        p,
  ];
  return m;
}

SongJson? refrainOnce(SongJson m, Random r, List<SongRaw> book) {
  if (!_hasRefrain(m)) return null;
  final count = _parts(m).where((p) => p.containsKey('refren')).fold<int>(0, (a, p) => a + (p['refren'] as int));
  final vs = _verses(m);
  if (count < 2 || vs.isEmpty) return null;
  m['parts'] = [vs.first, {'refren': 1}, ...vs.skip(1)];
  return m;
}

SongJson? refrainFirst(SongJson m, Random r, List<SongRaw> book) {
  final vs = _verses(m);
  if (!_hasRefrain(m) || vs.isEmpty) return null;
  m['parts'] = [{'refren': 1}, ...vs];
  return m;
}

SongJson? reorderVerses(SongJson m, Random r, List<SongRaw> book) {
  final parts = _parts(m);
  if (parts.length < 3) return null;
  final before = jsonEncode(parts);
  for (var t = 0; t < 5 && jsonEncode(parts) == before; t++) {
    parts.shuffle(r);
  }
  return m..['parts'] = parts;
}

/// [k] nowych zwrotek: układ wersów z prawdziwej zwrotki innej piosenki,
/// ale słowa losowe — dopisany tekst nie może być kopią niczego ze śpiewnika.
Perturbation addVerses(int k) => (m, r, book) {
      if (_verses(m).isEmpty) return null;
      final parts = _parts(m);
      final vocab = _vocab(book);
      for (var n = 0; n < k; n++) {
        final donor = _verses(songJson(book[r.nextInt(book.length)]));
        if (donor.isEmpty) continue;
        final v = donor[r.nextInt(donor.length)];
        parts.add({
          'text': _mapWords(v['text'] as String, 1, r, (_) => vocab[r.nextInt(vocab.length)]),
          'chords': v['chords'],
          'shift': false,
        });
      }
      return m..['parts'] = parts;
    };

/// Sama pierwsza zwrotka (i refren, jeśli jest).
SongJson? firstVerseOnly(SongJson m, Random r, List<SongRaw> book) {
  final vs = _verses(m);
  if (vs.length < 3) return null;
  return m..['parts'] = [vs.first, if (_hasRefrain(m)) {'refren': 1}];
}

Perturbation typos(double share) => (m, r, book) {
      _mapTexts(m, (t) => _mapWords(t, share, r, (w) => _typo(w, r)));
      return m;
    };

/// Przeróbka: [share] słów podmienionych na słowa z innych piosenek,
/// układ wersów i chwyty zostają.
Perturbation parody(double share) => (m, r, book) {
      final vocab = _vocab(book);
      _mapTexts(m, (t) => _mapWords(t, share, r, (_) => vocab[r.nextInt(vocab.length)]));
      return m;
    };

/// Co dwa wersy sklejone w jeden — w tekście i w chwytach.
SongJson? joinLines(SongJson m, Random r, List<SongRaw> book) {
  String Function(String) join(String glue) => (s) {
        final ls = s.split('\n');
        return [for (var i = 0; i < ls.length; i += 2) i + 1 < ls.length ? '${ls[i]}$glue${ls[i + 1]}' : ls[i]].join('\n');
      };

  // Przecinek w tekście, żeby nie wyszło dosłownie to samo po zbiciu spacji.
  _mapTexts(m, join(', '));
  _mapChords(m, join(' '));
  return m;
}

const _names = ['C', 'Cis', 'D', 'Dis', 'E', 'F', 'Fis', 'G', 'Gis', 'A', 'B', 'H'];
const _pitch = {'c': 0, 'd': 2, 'e': 4, 'f': 5, 'g': 7, 'a': 9, 'b': 10, 'h': 11};
final _chordToken = RegExp(r'^([A-Ha-h])(is)?(.*)$');

SongJson? transposeUp2(SongJson m, Random r, List<SongRaw> book) {
  String token(String t) {
    final x = _chordToken.firstMatch(t);
    if (x == null) return t;
    final minor = x[1] == x[1]!.toLowerCase();
    final name = _names[(_pitch[x[1]!.toLowerCase()]! + (x[2] == null ? 0 : 1) + 2) % 12];
    return '${minor ? name.toLowerCase() : name}${x[3]}';
  }

  _mapChords(m, (c) => c.split('\n').map((l) => l.split(' ').map((t) => t.isEmpty ? t : token(t)).join(' ')).join('\n'));
  return m;
}

/// Wszystko naraz: literówki, refren gdzie indziej, dopisana zwrotka, transpozycja.
SongJson? everything(SongJson m, Random r, List<SongRaw> book) {
  var x = typos(0.05)(m, r, book)!;
  x = refrainOnce(x, r, book) ?? x;
  x = addVerses(1)(x, r, book)!;
  return transposeUp2(x, r, book);
}
