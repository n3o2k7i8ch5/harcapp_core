import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_element.dart';

const _ognisko = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\nOpowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _morze = 'Zupełnie inny tekst o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu i od ogniska';
const _gory = 'Hej góry moje góry\nWysoko pod chmury\nTam gdzie orzeł krąży\nA wiatr halny dąży';

SongRaw song(String id, String title, String lyrics, {String chords = 'a d e\na d e', List<String>? hidTitles}) {
  final s = SongRaw.empty(id: id);
  s.title = title;
  s.hidTitles = hidTitles ?? [];
  s.performers = ['Zespół'];
  s.hasRefren = false;
  s.songParts = [SongPart.from(SongElement(lyrics, chords, false))];
  return s;
}

void main() {
  final app = SongIndex<SongRaw>([
    song('o!_ognisko@zespol', 'Płonie ognisko', _ognisko),
    song('o!_morze', 'Morze', _morze, hidTitles: ['Żagle']),
    song('o!_gory', 'Góry', _gory),
  ]);

  group('SongIndex.byId / allById:', () {
    test('allById daje wszystkie pod jednym id — w warsztacie id się powtarza', () {
      final index = SongIndex<SongRaw>([
        song('x', 'Pierwsza', _ognisko),
        song('y', 'Inna', _morze),
        song('x', 'Druga', _gory),
      ]);
      expect(index.allById('x').map((s) => s.title), ['Pierwsza', 'Druga']);
      expect(index.allById('nie ma'), isEmpty);
      expect(index.byId('x')?.title, 'Pierwsza');
    });

    test('dokładnie, a potem bez członu @wykonawca', () {
      expect(app.byId('o!_morze')?.title, 'Morze');
      expect(app.byId('o!_ognisko@zespol')?.title, 'Płonie ognisko');
      expect(app.byId('o!_ognisko@inny')?.title, 'Płonie ognisko',
          reason: 'zgłoszenie sprzed zmiany wykonawcy to dalej ta sama piosenka');
      expect(app.byId('o!_nie_ma'), isNull);
      expect(app.byId(''), isNull, reason: 'puste id to nie id');
    });
  });

  group('SongIndex.matches:', () {
    test('wszystkie trafienia, od najsilniejszego — tekst przed tytułem', () {
      // Ten sam tytuł co „Morze”, tekst z „Ogniska” i jeden wers więcej.
      final probe = SongProfile(song('o!_probe', 'Morze', '$_ognisko\nDodatkowa linijka tekstu'));
      final got = app.matches(probe);

      expect(got.map((m) => m.song.id), ['o!_ognisko@zespol', 'o!_morze']);
      expect(got[0].level, MatchLevel.longer, reason: 'całe „Ognisko” jest w sprawdzanej, ona ma więcej');
      expect(got[1].level, MatchLevel.sameTitleDifferentText);
      expect(got[1].similarities.whereType<SameTitle>(), hasLength(1));
      expect(got.every((m) => m.source == MatchSource.app), isTrue);
    });

    test('tytuł ukryty liczy się jak tytuł', () {
      final got = app.matches(SongProfile(song('x', 'Żagle', 'coś zupełnie innego')));
      expect(got.single.song.id, 'o!_morze');
      expect(got.single.level, MatchLevel.sameTitleDifferentText);
    });

    test('w obrębie poziomu i między poziomami — bliższy tekst wyżej', () {
      final index = SongIndex<SongRaw>([
        song('b', 'Ognisko B', '$_ognisko\nJedna nowa linijka tekstu\nI druga nowa linijka\nI trzecia na koniec'),
        song('a', 'Ognisko A', _ognisko),
      ]);
      final got = index.matches(SongProfile(song('p', 'Inny tytuł', _ognisko)));
      expect(got.map((m) => m.song.id), ['a', 'b']);
      expect(got[0].level, MatchLevel.sameSong);
      expect(got[1].level, MatchLevel.shorter, reason: 'sprawdzana to fragment „Ogniska B”');
    });

    test('exclude wyłącza wskazane piosenki, np. samą siebie', () {
      final self = song('o!_gory', 'Góry', _gory);
      final index = SongIndex<SongRaw>([self, song('o!_gory2', 'Góry', _gory)]);
      final got = index.matches(SongProfile(self), exclude: (s) => identical(s, self));
      expect(got.map((m) => m.song.id), ['o!_gory2']);
    });

    test('source jedzie na trafieniu i do detail', () {
      final got = app.matches(SongProfile(song('o!_morze', 'Morze', _morze, hidTitles: ['Żagle'])), source: MatchSource.workspace);
      expect(got.single.source, MatchSource.workspace);
      expect(got.single.detail, '„Morze” w warsztacie: to samo id, ten sam tytuł, ten sam tekst, te same chwyty');
      expect(got.single.level, MatchLevel.identical);
    });

    test('samo wspólne id daje sameIdDifferentSong, za treścią', () {
      final got = app.matches(SongProfile(song('o!_gory', 'Zupełnie co innego', _morze)));
      // „Morze” po tekście przed „Góry” po id.
      expect(got.map((m) => m.song.id), ['o!_morze', 'o!_gory']);
      expect(got[0].level, MatchLevel.sameSong, reason: 'ten sam tekst pod innym tytułem to ta sama piosenka');
      expect(got[1].level, MatchLevel.sameIdDifferentSong);
      expect(got[1].similarities.whereType<SameId>(), hasLength(1));
    });

    test('kandydaci z indeksu dają to samo, co pełne przejście', () {
      final probe = SongProfile(song('p', 'Morze', '$_ognisko\nŻagle na wietrze i sól na wargach'));
      final fast = app.matches(probe).map((m) => m.song.id).toList();
      final naive = [
        for (final s in app.songs)
          if (levelOf(compare(probe, SongProfile(s))) != null) s.id,
      ];
      expect(fast.toSet(), naive.toSet());
    });

    test('identyczne, choć tekst bez ani jednego słowa — nie wypada z kandydatów', () {
      final a = song('a', '', '♪ ♪ ♪');
      final b = song('b', '', '♪ ♪ ♪');
      expect(SongProfile(a).words, isEmpty);
      final got = SongIndex<SongRaw>([a]).matches(SongProfile(b));
      expect(got.single.level, MatchLevel.identical);
    });

    test('ten sam film YouTube łączy, choćby tekst spisano inaczej', () {
      final a = song('a', 'Pierwsza', _ognisko)..youtubeVideoId = 'abcdefghijk';
      final b = song('b', 'Druga', _gory)..youtubeVideoId = 'abcdefghijk';
      final got = SongIndex<SongRaw>([a]).matches(SongProfile(b));
      expect(got.single.level, MatchLevel.related);
      expect(got.single.similarities.whereType<SameRecording>(), hasLength(1));
    });

    test('nic podobnego → pusto', () {
      expect(app.matches(SongProfile(song('x', 'Nowa', 'Tekst bez żadnego wspólnego słowa z resztą'))), isEmpty);
    });

    test('jeden krótki wers to za mało, żeby cokolwiek wnioskować', () {
      // Wpisany w edytorze pierwszy wers „jest w całości” w piosence — ale
      // tak samo byłby w każdej innej, która go ma.
      final got = app.matches(SongProfile(song('x', 'Nowa', 'Opowiada starodawne dzieje')));
      expect(got, isEmpty);
    });
  });

  group('SongIndex.closest / matchTo:', () {
    test('closest: najsilniejsze po treści, tytuł dopiero bez treści', () {
      expect(app.closest(SongProfile(song('x', 'Morze', 'nic')))?.song.id, 'o!_morze');
      expect(app.closest(SongProfile(song('x', 'Inaczej', _gory)))?.song.id, 'o!_gory');
      expect(app.closest(SongProfile(song('x', 'Inaczej', 'zupełnie obcy tekst bez słów wspólnych'))), isNull);
      // Tytuł „Morze”, tekst „Gór”: wygrywa tekst.
      expect(app.closest(SongProfile(song('x', 'Morze', _gory)))?.song.id, 'o!_gory');
    });

    test('matchTo: ze wskazaną, nie najbliższą', () {
      final m = app.matchTo('o!_gory', SongProfile(song('x', 'Morze', _morze)));
      expect(m?.song.id, 'o!_gory');
      expect(m?.level, isNull);
      expect(app.matchTo('o!_brak', SongProfile(song('x', 'Morze', _morze))), isNull);
    });
  });

  group('correctionTargetOf:', () {
    test('ze śladu piosenkomatu — po correctionTarget', () {
      final s = song('o!_hej_sokoly', 'Hej sokoły', _gory)
        ..piosenkomatData = const PiosenkomatData(kind: SubmissionKind.correction, correctionTarget: 'o!_gory');
      expect(correctionTargetOf(s, app)?.id, 'o!_gory');
    });

    test('sama kolizja id to nie deklaracja — o niej mówi dowód SameId', () {
      final s = song('o!_morze', 'Morze poprawione', _morze);
      expect(correctionTargetOf(s, app), isNull);
      expect(
        app.matches(SongProfile(s)).first.similarities.whereType<SameId>(),
        hasLength(1),
      );
    });

    test('nowa piosenka ze śladem nie jest poprawką, choćby id kolidowało', () {
      final s = song('o!_morze', 'Morze', _morze)
        ..piosenkomatData = const PiosenkomatData(kind: SubmissionKind.newSong);
      expect(correctionTargetOf(s, app), isNull);
    });

    test('piosenka własna z apki — po correctedSongId', () {
      final s = song('own_1', 'Moje góry', _gory)..correctedSongId = 'o!_gory';
      expect(correctionTargetOf(s, app)?.id, 'o!_gory');
    });

    test('sama siebie nie jest własnym pierwowzorem', () {
      final self = song('o!_x', 'X', _gory)..correctedSongId = 'o!_x';
      expect(correctionTargetOf(self, SongIndex<SongRaw>([self])), isNull);
    });

    test('przy powtórzonym id deklaracja wskazuje sąsiada, nigdy samą siebie', () {
      // Po `prepare` poprawka ma id pierwowzoru, a obok w warsztacie leży
      // oryginał pod tym samym id — deklaracja `correctedSongId` ma trafić
      // w niego, niezależnie od tego, kto jest pierwszy na liście.
      final a = song('o!_x', 'X', _gory);
      final b = song('o!_x', 'X poprawione', _gory)..correctedSongId = 'o!_x';
      expect(correctionTargetOf(b, SongIndex<SongRaw>([a, b])), same(a));
      expect(correctionTargetOf(b, SongIndex<SongRaw>([b, a])), same(a));
      expect(correctionTargetOf(b, SongIndex<SongRaw>([b])), isNull);
    });

    test('puste correctedSongId nie wskazuje piosenek bez id', () {
      final blank = song('', 'Bez id', _gory);
      final s = song('o!_y', 'Y', _morze)..correctedSongId = '';
      expect(correctionTargetOf(s, SongIndex<SongRaw>([blank])), isNull);
    });

    test('nic nie pasuje → null', () {
      expect(correctionTargetOf(song('o!_nowa', 'Nowa', 'tekst'), app), isNull);
    });
  });
}
