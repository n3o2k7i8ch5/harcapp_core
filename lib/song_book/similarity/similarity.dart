/// Podobieństwo dwóch piosenek: **dowody** i **wniosek** z nich.
///
/// Jedno miejsce dla piosenkomatu, edytora na stronie i apki — inaczej każdy
/// z nich ma własną definicję „ta sama piosenka” i ta sama para wychodzi
/// duplikatem w jednym miejscu, a nie w drugim. Progi żyją tu, nie w danych
/// i nie w UI.
library;

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_core.dart';

/// Ten sam tekst: przy tym progu tytuł + tekst + chwyty znaczą „ta sama piosenka”.
const double kSameText = 0.9;
/// Podejrzanie podobny: idzie do przeglądu.
const double kSimilarText = 0.5;
/// Poniżej tego progu nie wolno **zgadywać**, którą piosenkę poprawia
/// zgłoszenie bez deklaracji. Poprawka bywa sporym diffem, więc próg jest
/// dużo niższy niż [kSimilarText] — ale sam zbieżny tytuł („Barka” to nie
/// zawsze ta sama „Barka”) nie jest dowodem, a podmiana idzie po id.
const double kGuessableTarget = 0.3;

/// Zbiór słów po normalizacji (małe litery, bez polskich znaków, bez
/// interpunkcji). Kolejność zwrotek i literówki w wielkości liter nie liczą się.
///
/// Końce linii sprowadzamy do spacji **przed** normalizacją: `simplifyString`
/// je kasuje, więc ostatnie słowo wersu sklejało się z pierwszym słowem
/// następnego (`dach` + `żeby` → `dachzeby`) i każda para wychodziła mniej
/// podobna, niż jest naprawdę.
Set<String> textWords(String text) =>
    simplifyString(text.replaceAll(RegExp(r'\s+'), ' '),
            spaceStrategy: SpaceStrategy.space)
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toSet();

double jaccard(Set<String> a, Set<String> b) {
  if (a.isEmpty || b.isEmpty) return 0;
  return a.intersection(b).length / a.union(b).length;
}

String pct(double score) => '${(score * 100).round()}%';

/// Białe znaki zbite do jednej spacji, brzegi przycięte. Nic więcej — do
/// porównań „dosłownie równe”.
String squash(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();

// ---------------------------------------------------------------------------
// Dowody podobieństwa
// ---------------------------------------------------------------------------

/// Jeden dowód: **co** jest podobne i **jak bardzo**. Zbieramy wszystkie,
/// jakie są; wniosek ([MatchLevel]) to reguła nad listą, nie pole.
sealed class Similarity {
  const Similarity();
  /// Gotowe zdanie do pastylki i raportu.
  String get text;
}

/// To samo id (`lclId`). Najtwardszy sygnał z możliwych: w apce piosenki są
/// referencjonowane po id, a po `prepare` poprawka **ma** id pierwowzoru.
/// Dwie różne piosenki pod jednym id to konflikt, nawet gdy nic poza tym
/// ich nie łączy.
class SameId extends Similarity {
  const SameId();
  @override
  String get text => 'to samo id';
}

/// Tytuły równe po normalizacji jak w wyszukiwarce (także `hid_titles`).
class SameTitle extends Similarity {
  const SameTitle();
  @override
  String get text => 'ten sam tytuł';
}

/// Tekst **dosłownie** równy po zbiciu białych znaków. Jaccard 1.0 to nie to
/// samo — on nie widzi kolejności zwrotek ani interpunkcji.
class SameText extends Similarity {
  const SameText();
  @override
  String get text => 'ten sam tekst';
}

/// Jaccard zbiorów słów całego tekstu.
class TextOverlap extends Similarity {
  final double jaccard;
  const TextOverlap(this.jaccard);
  @override
  String get text => 'tekst ${pct(jaccard)}';
}

/// Chwyty równe po zbiciu białych znaków; wielkość liter zostaje (`a` ≠ `A`).
class SameChords extends Similarity {
  const SameChords();
  @override
  String get text => 'te same chwyty';
}

/// Które pola metadanych się różnią. Nieemitowany, gdy nic.
class MetadataDiff extends Similarity {
  final List<String> fields;
  const MetadataDiff(this.fields);
  @override
  String get text => 'inne: ${fields.join(', ')}';
}

/// Wniosek z dowodów. Progi żyją tu, nie w danych. Kolejność to siła
/// trafienia — po niej sortuje `SongIndex.matches`.
enum MatchLevel {
  /// Każde pole dosłownie równe — to jest ta sama piosenka.
  identical('ta sama piosenka, bez różnic'),
  /// Tytuł, tekst ≥ 90%, chwyty — ale coś się różni: kolejność zwrotek,
  /// interpunkcja, metadane.
  sameSong('ta sama piosenka, drobne różnice'),
  /// Tytuł i tekst ≥ 90%, inne chwyty.
  sameTextDifferentChords('ta sama piosenka, inne chwyty'),
  /// Ten sam tytuł, tekst < 90%.
  sameTitleDifferentText('ten sam tytuł, inna treść'),
  /// Inny tytuł, tekst ≥ 50%.
  similarText('podobny tekst'),
  /// To samo id, a poza tym nic — id zajęte przez inną piosenkę. Ostatnie,
  /// bo o **treści** nie mówi nic; ważne jest przez to, co id znaczy w apce,
  /// i po to UI patrzy na dowód [SameId], nie na poziom.
  sameIdDifferentSong('inna piosenka pod tym samym id');

  const MatchLevel(this.text);

  /// Polskie zdanie na poziom — do belki i podpowiedzi, bez `SongIssue`.
  final String text;
}

MatchLevel? levelOf(List<Similarity> s) {
  final sameId = s.any((e) => e is SameId);
  final sameTitle = s.any((e) => e is SameTitle);
  final sameText = s.any((e) => e is SameText);
  final sameChords = s.any((e) => e is SameChords);
  final metaDiff = s.any((e) => e is MetadataDiff);
  final overlap = s.whereType<TextOverlap>().firstOrNull?.jaccard ?? 0;

  if (sameText && sameChords && !metaDiff) return MatchLevel.identical;
  if (sameTitle && overlap >= kSameText && sameChords) return MatchLevel.sameSong;
  if (sameTitle && overlap >= kSameText) return MatchLevel.sameTextDifferentChords;
  if (sameTitle) return MatchLevel.sameTitleDifferentText;
  if (overlap >= kSimilarText) return MatchLevel.similarText;
  if (sameId) return MatchLevel.sameIdDifferentSong;
  return null;
}

String similaritiesText(List<Similarity> s) => s.map((e) => e.text).join(', ');

// ---------------------------------------------------------------------------
// Porównanie dwóch piosenek
// ---------------------------------------------------------------------------

/// Piosenka sprowadzona do tego, co potrzebne do porównań — liczone raz.
/// Nad [SongCore], nie [SongRaw]: apka liczy profil ze swojego `Song`.
class SongProfile {
  final String id;
  final String title;
  final Set<String> titleKeys;
  final Set<String> words;
  final String text;
  final String chords;
  final Map<String, String> metadata;

  SongProfile(SongCore s)
      : id = s.id,
        title = s.title,
        titleKeys = {
          searchableString(s.title),
          for (final h in s.hidTitles) searchableString(h),
        }..remove(''),
        words = textWords(s.text),
        text = squash(s.text),
        chords = squash(s.chords),
        metadata = {
          'title': s.title.trim(),
          'hid_titles': _list(s.hidTitles),
          'authors': _list(s.authors),
          'composers': _list(s.composers),
          'performers': _list(s.performers),
          'release_date': s.releaseDate?.toIso8601String() ?? '',
          'yt_video_id': (s.youtubeVideoId ?? '').trim(),
          'tags': _list(s.tags),
        };

  /// Normalizacja tylko techniczna: `null == []`, przycięte brzegi.
  ///
  /// Sklejamy bajtem zerowym, nie spacją: separator musi być czymś, czego
  /// żadne pole nie zawiera, bo inaczej `['Jan Kowalski']` i `['Jan',
  /// 'Kowalski']` wychodzą na to samo. Zapis `\x00`, a nie goły bajt w pliku —
  /// ten robił z tego źródła plik binarny dla gita i reszty narzędzi.
  static String _list(List<String> l) =>
      [for (final e in l) e.trim()].where((e) => e.isNotEmpty).join('\x00');

  bool sharesTitleWith(SongProfile o) => titleKeys.intersection(o.titleKeys).isNotEmpty;
}

/// Wszystkie dowody, jakie da się zebrać między [a] i [b].
List<Similarity> compare(SongProfile a, SongProfile b) {
  final out = <Similarity>[];
  if (a.id.isNotEmpty && a.id == b.id) out.add(const SameId());
  if (a.sharesTitleWith(b)) out.add(const SameTitle());
  if (a.text.isNotEmpty && a.text == b.text) out.add(const SameText());
  out.add(TextOverlap(jaccard(a.words, b.words)));
  if (a.chords == b.chords) out.add(const SameChords());
  final diff = [
    for (final e in a.metadata.entries)
      if (e.value != b.metadata[e.key]) e.key,
  ];
  if (diff.isNotEmpty) out.add(MetadataDiff(diff));
  return out;
}
