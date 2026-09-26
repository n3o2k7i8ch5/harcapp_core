/// Odcisk piosenki: wszystko, czego potrzebują porównania, liczone raz.
library;

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_core.dart';

import 'chords.dart';
import 'normalize.dart';

/// Jeden wers po normalizacji — jednostka porównania tekstu.
class ProfileLine {
  final String text;
  /// Trigramy znaków `' $text '`, każdy spakowany w liczbę (3 × 16 bitów —
  /// mieści się w liczbie z JS-a), posortowane, bez powtórzeń.
  final List<int> trigrams;
  /// Ile ten wers znaczy przy liczeniu pokrycia: jego długość, a przy
  /// wokalizie („laj la laj la”, „na na na”, „aleluja aleluja”) — zero.
  /// Inaczej takie wersy łączą wszystko ze wszystkim.
  final double weight;

  ProfileLine(this.text)
      : trigrams = trigramsOf(text),
        weight = _isVocalization(text) ? 0 : text.length.toDouble();

  static bool _isVocalization(String text) {
    final distinct = text.split(' ').toSet();
    return distinct.length < 2 || distinct.every((w) => w.length <= 3);
  }
}

/// Dwa sąsiednie wersy (w kolejności z tekstu) jako jeden — na wersy
/// sklejone albo rozbite inaczej niż w drugiej piosence.
class LineWindow {
  final List<int> trigrams;
  /// Numery wersów w [SongProfile.lines].
  final int first, second;
  LineWindow(String text, this.first, this.second) : trigrams = trigramsOf(text);
}

List<int> trigramsOf(String text) {
  final s = ' $text ';
  final out = <int>[
    for (var i = 0; i + 3 <= s.length; i++)
      (s.codeUnitAt(i) * 65536 + s.codeUnitAt(i + 1)) * 65536 + s.codeUnitAt(i + 2),
  ]..sort();
  var w = 0;
  for (var i = 0; i < out.length; i++) {
    if (i == 0 || out[i] != out[i - 1]) out[w++] = out[i];
  }
  out.length = w;
  return out;
}

/// Sylaby ≈ grupy samogłosek po zdjęciu ogonków: „się” i „nie” to jedna.
int _syllables(String line) {
  var n = 0;
  var inVowel = false;
  for (var i = 0; i < line.length; i++) {
    final c = line.codeUnitAt(i);
    // a e i o u y
    final vowel = c == 0x61 || c == 0x65 || c == 0x69 || c == 0x6f || c == 0x75 || c == 0x79;
    if (vowel && !inVowel) n++;
    inVowel = vowel;
  }
  return n;
}

/// Piosenka sprowadzona do tego, co potrzebne do porównań. Nad [SongCore],
/// nie `SongRaw`: apka liczy odcisk ze swojego `Song`.
///
/// Pola czyta się z piosenki **w konstruktorze** — `SongRaw` jest mutowalny,
/// a odcisk ma opisywać piosenkę z chwili, w której go policzono. Słowa
/// liczą się od razu (potrzebuje ich indeks), wersy, chwyty i metrum dopiero
/// przy pierwszym porównaniu: indeks śpiewnika porównuje z pojedynczymi
/// kandydatami, więc większość piosenek nigdy ich nie potrzebuje.
class SongProfile {
  final String id;
  final String title;
  /// Tytuł główny po normalizacji jak w wyszukiwarce.
  final String titleKey;
  /// Tytuł główny i ukryte po normalizacji jak w wyszukiwarce.
  final Set<String> titleKeys;
  /// Film YouTube — ten sam znaczy to samo nagranie.
  final String youtubeId;
  final Map<String, String> metadata;
  final String _rawText;
  final String _rawChords;
  /// Znormalizowane wersy w kolejności z tekstu, z powtórzeniami (refren).
  final List<String> _ordered;
  /// Wszystkie słowa tekstu.
  final Set<String> words;

  SongProfile._(this.id, this.title, this.titleKey, this.titleKeys, this.youtubeId, this.metadata,
      this._rawText, this._rawChords, this._ordered)
      : words = {for (final l in _ordered) ...l.split(' ')};

  factory SongProfile(SongCore s) {
    final text = s.text;
    return SongProfile._(
      s.id,
      s.title,
      searchableString(s.title),
      {
        searchableString(s.title),
        for (final h in s.hidTitles) searchableString(h),
      }..remove(''),
      (s.youtubeVideoId ?? '').trim(),
      {
        'title': s.title.trim(),
        'hid_titles': _list(s.hidTitles),
        'authors': _list(s.authors),
        'composers': _list(s.composers),
        'performers': _list(s.performers),
        'release_date': s.releaseDate?.toIso8601String() ?? '',
        'yt_video_id': (s.youtubeVideoId ?? '').trim(),
        'tags': _list(s.tags),
      },
      text,
      s.chords,
      [
        for (final line in text.split('\n'))
          if (lineWords(line) case final words when words.isNotEmpty) words.join(' '),
      ],
    );
  }

  /// Normalizacja tylko techniczna: `null == []`, przycięte brzegi.
  ///
  /// Sklejamy bajtem zerowym, nie spacją: separator musi być czymś, czego
  /// żadne pole nie zawiera, bo inaczej `['Jan Kowalski']` i `['Jan',
  /// 'Kowalski']` wychodzą na to samo. Zapis `\x00`, a nie goły bajt w pliku —
  /// ten robił z tego źródła plik binarny dla gita i reszty narzędzi.
  static String _list(List<String> l) =>
      [for (final e in l) e.trim()].where((e) => e.isNotEmpty).join('\x00');

  /// Tekst po zbiciu białych znaków — do „dosłownie równe”.
  late final String text = squash(_rawText);
  /// Chwyty po zbiciu białych znaków; wielkość liter zostaje (`a` ≠ `A`).
  late final String chords = squash(_rawChords);

  /// Wersy bez powtórzeń — refren liczy się raz, gdziekolwiek stoi.
  late final List<ProfileLine> lines = [for (final l in {..._ordered}) ProfileLine(l)];

  late final double totalWeight = lines.fold(0.0, (a, l) => a + l.weight);

  /// Pary sąsiednich wersów z tekstu, bez powtórzeń.
  late final List<LineWindow> windows = () {
    final index = {for (var i = 0; i < lines.length; i++) lines[i].text: i};
    final seen = <int>{};
    return [
      for (var i = 0; i + 1 < _ordered.length; i++)
        if (seen.add(index[_ordered[i]]! * lines.length + index[_ordered[i + 1]]!))
          LineWindow('${_ordered[i]} ${_ordered[i + 1]}', index[_ordered[i]]!, index[_ordered[i + 1]]!),
    ];
  }();

  /// Sylaby w kolejnych wersach — przeróbka trzyma metrum oryginału.
  late final List<int> meter = [for (final l in _ordered) _syllables(l)];

  /// Pary sąsiednich akordów — patrz [chordPairs].
  late final Set<int> chordPairsSet = chordPairs(_rawChords);

  bool get hasChords => chordPairsSet.isNotEmpty;

  /// Tytuł główny jednej piosenki jest tytułem (głównym albo ukrytym)
  /// drugiej. Sam wspólny tytuł ukryty to za mało: ukryte bywają tagami
  /// („Kasia Sienkiewicz” na czterech różnych piosenkach).
  bool sharesTitleWith(SongProfile o) =>
      (titleKey.isNotEmpty && o.titleKeys.contains(titleKey)) ||
      (o.titleKey.isNotEmpty && titleKeys.contains(o.titleKey));
}
