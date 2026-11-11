import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'song_core.dart';

/// Jak mocno piosenka pasuje do szukanej frazy. Wyniki układa się w tej
/// kolejności: najpierw tytuły zaczynające się od frazy, na końcu trafienia
/// tylko po osobie dodającej.
enum SongMatch{
  /// Tytuł (albo tytuł ukryty) zaczyna się od frazy.
  titleStart,
  /// Fraza jest gdzieś w tytule (albo tytule ukrytym).
  title,
  /// Autor słów, kompozytor, wykonawca albo pochodzenie
  /// („Shrek” znajduje „All Star”, „Kraina lodu” — „Mam tę moc”).
  meta,
  /// Słowa piosenki.
  text,
  /// Osoba, która piosenkę dodała.
  contributor,
}

/// Pola piosenki sprowadzone do postaci do szukania ([searchableString]).
/// Liczone leniwie, raz — kto szuka wiele razy w tych samych piosenkach
/// (strona), trzyma wpisy; kto raz (apka, po każdej zmianie frazy), tworzy
/// je na bieżąco i płaci tylko za to, czego szukanie faktycznie dotknęło.
class SongSearchEntry{

  final SongCore song;

  SongSearchEntry(this.song);

  late final List<String> _titles = [
    searchableString(song.title),
    for(final hidTitle in song.hidTitles) searchableString(hidTitle),
  ];

  late final List<String> _meta = [
    for(final author in song.authors) searchableString(author),
    for(final composer in song.composers) searchableString(composer),
    for(final performer in song.performers) searchableString(performer),
    for(final origin in song.origins) searchableString(origin.value),
  ];

  late final String _text = searchableString(song.text);

  late final List<String> _contributors = [
    for(final ContributorRef ref in song.contribRefs) ...[
      if(ref.person?.name != null) searchableString(ref.person!.name),
      if(registeredPersonByEmail(ref.emailRef) case final registered?) searchableString(registered.person.name),
    ],
  ];

  /// [phrase] już po [searchableString]. `null` — nie pasuje wcale.
  SongMatch? match(String phrase){
    if(_titles.any((title) => title.startsWith(phrase))) return SongMatch.titleStart;
    if(_titles.any((title) => title.contains(phrase))) return SongMatch.title;
    if(_meta.any((meta) => meta.contains(phrase))) return SongMatch.meta;
    if(_text.contains(phrase)) return SongMatch.text;
    if(_contributors.any((name) => name.contains(phrase))) return SongMatch.contributor;
    return null;
  }

}

/// Czy piosenka ma wszystkie zaznaczone tagi.
bool songHasTags(SongCore song, List<String> checkedTags) =>
    checkedTags.every(song.tags.contains);

/// Pozycje pasujących elementów [items], ułożone wg [SongMatch], a w obrębie
/// grupy — w kolejności [items]. Pusta fraza pasuje do wszystkiego.
/// [stillValid] pozwala przerwać szukanie, gdy fraza się już zmieniła —
/// wtedy wynik `null`.
List<int>? searchSongs<T>(
    List<T> items,
    String phrase,
    { required SongSearchEntry Function(T item) entryOf,
      bool Function(T item)? filter,
      bool Function()? stillValid,
    }){

  final String searchablePhrase = searchableString(phrase);
  final List<List<int>> groups = [for(final _ in SongMatch.values) []];

  for(int i=0; i<items.length; i++){
    if(stillValid != null && !stillValid()) return null;
    final T item = items[i];
    if(filter != null && !filter(item)) continue;
    final SongMatch? match = entryOf(item).match(searchablePhrase);
    if(match != null) groups[match.index].add(i);
  }

  return [for(final group in groups) ...group];
}
