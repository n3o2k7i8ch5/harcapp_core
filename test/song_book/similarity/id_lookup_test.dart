import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_element.dart';

SongRaw _song(String id, {String title = 'Barka'}) {
  final s = SongRaw.empty(id: id);
  s.title = title;
  s.hasRefren = false;
  s.songParts = [SongPart.from(SongElement('Pan kiedyś stanął nad brzegiem', 'a d', false))];
  return s;
}

SongRaw _correctionOf(String targetId) => _song('o!_barka_poprawiona')
  ..piosenkomatData = PiosenkomatData(kind: SubmissionKind.correction, correctionTarget: targetId);

void main() {
  group('SongIndex.lookupId: jedno wyszukiwanie po id, z informacją jak trafiło', () {
    test('dokładnie to id → fakt', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      final hit = index.lookupId('o!_barka@sdm')!;
      expect(hit.how, IdLookup.exact);
      expect(hit.isGuessed, isFalse);
    });

    test('id sprzed zmiany wykonawcy → trafienie bez @wykonawca, domysł', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      final hit = index.lookupId('o!_barka@dom')!;
      expect(hit.how, IdLookup.withoutPerformer);
      expect(hit.isGuessed, isTrue);
      expect(hit.songs.single.id, 'o!_barka@sdm');
    });

    test('bez wykonawcy pasuje kilka różnych → niejednoznaczne, nic nie wybieramy', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm'), _song('o!_barka@zespol')]);
      final hit = index.lookupId('o!_barka@dom')!;
      expect(hit.how, IdLookup.ambiguous);
      expect(hit.songs.map((s) => s.id), unorderedEquals(['o!_barka@sdm', 'o!_barka@zespol']));
      expect(index.byId('o!_barka@dom'), isNull, reason: 'nie pierwsza z brzegu');
    });

    test('nic nie pasuje, puste id → brak', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      expect(index.lookupId('o!_inna'), isNull);
      expect(index.lookupId(''), isNull);
    });
  });

  group('correctionTargetLookupOf: cel poprawki razem ze znacznikiem domysłu', () {
    test('dokładne id → nie domysł', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      final found = correctionTargetLookupOf(_correctionOf('o!_barka@sdm'), index)!;
      expect(found.song.id, 'o!_barka@sdm');
      expect(found.guessed, isFalse);
    });

    test('id sprzed zmiany wykonawcy → domysł', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      final found = correctionTargetLookupOf(_correctionOf('o!_barka@dom'), index)!;
      expect(found.song.id, 'o!_barka@sdm');
      expect(found.guessed, isTrue);
      expect(correctionTargetOf(_correctionOf('o!_barka@dom'), index)?.id, 'o!_barka@sdm');
    });

    test('cel zgadnięty przez piosenkomat → domysł, choć id pasuje dokładnie', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm')]);
      final song = _song('o!_barka_poprawiona')
        ..piosenkomatData = PiosenkomatData(
            kind: SubmissionKind.correction, correctionTarget: 'o!_barka@sdm', correctionTargetGuessed: true);
      final found = correctionTargetLookupOf(song, index)!;
      expect(found.song.id, 'o!_barka@sdm');
      expect(found.guessed, isTrue, reason: 'narzędzie zapisuje id już rozwiązane — o domyśle mówi znacznik');
    });

    test('niejednoznaczne → brak celu', () {
      final index = SongIndex<SongRaw>([_song('o!_barka@sdm'), _song('o!_barka@zespol')]);
      expect(correctionTargetLookupOf(_correctionOf('o!_barka@dom'), index), isNull);
    });
  });

  group('SongIdIndex: same id, te same reguły co w SongIndex', () {
    test('lookupId daje to samo, co pełny indeks', () {
      final songs = [_song('o!_barka@sdm'), _song('o!_barka@dom'), _song('o!_inna@x')];
      final ids = SongIdIndex<SongRaw>(songs);
      final full = SongIndex<SongRaw>(songs);
      for (final id in ['o!_barka@sdm', 'o!_barka@nikt', 'o!_inna@y', 'o!_brak', '']) {
        expect(ids.lookupId(id)?.how, full.lookupId(id)?.how, reason: id);
        expect(ids.lookupId(id)?.songs, full.lookupId(id)?.songs, reason: id);
      }
    });

    test('allByExactId: tylko dokładnie to id — bez rundy bez @wykonawca', () {
      final a = _song('o!_barka@sdm');
      final b = _song('o!_barka@sdm');
      final ids = SongIdIndex<SongRaw>([a, b, _song('o!_barka@dom')]);
      expect(ids.allByExactId('o!_barka@sdm'), [a, b]);
      expect(ids.allByExactId('o!_barka@nikt'), isEmpty,
          reason: 'pasuje tylko bez wykonawcy — to nie kolizja id');
    });

    test('correctionTargetOf działa na samym indeksie id', () {
      final target = _song('o!_barka@sdm');
      expect(correctionTargetOf(_correctionOf('o!_barka@sdm'), SongIdIndex<SongRaw>([target])), same(target));
    });
  });

  group('SongIndex(profileOf:): gotowe odciski zamiast liczenia od nowa', () {
    test('podany odcisk trafia do indeksu bez przeliczania', () {
      final song = _song('o!_barka@sdm');
      final profile = SongProfile(song);
      final index = SongIndex<SongRaw>([song], profileOf: (_) => profile);
      expect(index.profiles.single, same(profile));
    });

    test('wynik ten sam, co przy liczeniu od nowa', () {
      final songs = [_song('o!_a', title: 'Barka'), _song('o!_b', title: 'Barka')];
      final cached = {for (final s in songs) s: SongProfile(s)};
      final fresh = SongIndex<SongRaw>(songs);
      final reused = SongIndex<SongRaw>(songs, profileOf: (s) => cached[s]!);
      final probe = SongProfile(_song('o!_c', title: 'Barka'));
      expect(reused.matches(probe).map((m) => m.song), fresh.matches(probe).map((m) => m.song));
    });
  });
}
