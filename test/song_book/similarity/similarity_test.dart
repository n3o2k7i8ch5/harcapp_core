import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/similarity/similarity.dart';
import 'package:harcapp_core/song_book/similarity/src/chords.dart';
import 'package:harcapp_core/song_book/similarity/src/normalize.dart' show lineWords;
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/song_element.dart';

const _v1 = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas';
const _v2 = 'Opowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _v3 = 'O rycerzach i o wojnach\nO harcerskich dawnych dniach';
const _ref = 'Hej ogniska blask\nRozświetla nasze twarze';

/// Piosenka z częściami: `null` w [parts] to refren.
SongRaw song(List<String?> parts, {String title = 'Ognisko', String id = 'o!_x', String chords = 'a d\ne a', String refChords = 'C G\na e'}) {
  final s = SongRaw.empty(id: id);
  s.title = title;
  s.hasRefren = parts.contains(null);
  s.refrenPart = SongPart.from(SongElement(_ref, refChords, true));
  s.songParts = [
    for (final p in parts) p == null ? SongPart.from(s.refrenPart.element) : SongPart.from(SongElement(p, chords, false)),
  ];
  return s;
}

List<Similarity> cmp(SongRaw a, SongRaw b) => compare(SongProfile(a), SongProfile(b));
MatchLevel? level(SongRaw a, SongRaw b) => levelOf(cmp(a, b));

void main() {
  group('normalizacja:', () {
    test('te same słowa co wyszukiwarka', () {
      const line = 'Szła dzieweczka do laseczka, do zielonego: ha-ha/ha, żółw!';
      expect(lineWords(line).toSet(),
          simplifyString(line, spaceStrategy: SpaceStrategy.space).split(' ').where((w) => w.isNotEmpty).toSet());
    });

    test('bez podpisów zwrotek i znaczników powtórzeń', () {
      expect(lineWords('Ref.: Płonie ognisko x2'), ['plonie', 'ognisko']);
      expect(lineWords('Refren: Hej'), ['hej']);
      expect(lineWords('2. Druga zwrotka (2x)'), ['druga', 'zwrotka']);
      expect(lineWords('Refleksja i x-men'), ['refleksja', 'i', 'x', 'men'], reason: 'słowa na „ref” i samo „x” zostają');
    });
  });

  group('chwyty:', () {
    test('notacja śpiewnika i angielska', () {
      int pc(String t) => parseChord(t)! ~/ 64;
      bool minor(String t) => parseChord(t)! % 2 == 1;
      expect([pc('C'), pc('Cis'), pc('Des'), pc('Es'), pc('Fis'), pc('As'), pc('B'), pc('H')], [0, 1, 1, 3, 6, 8, 10, 11]);
      expect([minor('a'), minor('A'), minor('Am'), minor('Amaj7'), minor('fis7')], [true, false, true, false, true]);
      expect(pc('Esus4'), 4, reason: '„sus” to nie bemol');
      expect(parseChord('D/Fis'), parseChord('D'), reason: 'bas nie zmienia akordu');
      expect(parseChord('(G)'), parseChord('G'));
      expect(parseChord('x2'), isNull);
    });

    test('transpozycja: te same chwyty o 2 półtony wyżej', () {
      final a = song([_v1], chords: 'a d\nE a'), b = song([_v1], chords: 'h e\nFis h');
      final m = cmp(b, a).chordsMatch!;
      expect(m.similarity, 1.0);
      expect(m.shift, 2);
      expect(m.text, 'chwyty 100% po transpozycji o +2');
      expect(cmp(a, b).chordsMatch!.shift, -2);
    });
  });

  group('dowody:', () {
    test('wspólne, zmienione, nowe i brakujące wersy', () {
      final app = song([_v1, _v2]);
      final sent = song(['Płonie ognisko i szumią knieje\nDrużynowy jest wśród naas', _v3]);
      final l = cmp(sent, app).sharedLines!;
      expect(l.common, 2);
      expect(l.changed, 1, reason: 'literówka w „naas”');
      expect(l.added, 2);
      expect(l.missing, 2);
      expect(l.text, '2 wspólne wersy, w tym 1 zmieniony, 2 nowe, 2 brakujące');
    });

    test('wokalizy nie ważą nic', () {
      final a = song(['$_v1\nLaj la laj la laj la\nNa na na na']);
      final l = cmp(a, song([_v1])).sharedLines!;
      expect(l.coverage(), 1.0, reason: '„laj la” i „na na” nie są treścią');
    });

    test('dowody powtarzające inne nie idą do pokazania', () {
      final s = cmp(song([_v1, _v2]), song([_v1, _v2], id: 'o!_y'));
      expect(s.has<SharedLines>(), isTrue);
      expect(similaritiesToShow(s).any((e) => e is SharedLines || e is ChordsMatch || e is MeterMatch), isFalse);
      expect(similaritiesText(s), 'ten sam tytuł, ten sam tekst, te same chwyty');
    });
  });

  group('poziomy — przypadki z życia:', () {
    final app = song([_v1, null, _v2, null, _v3, null]);

    test('wszystko dosłownie równe → identical', () {
      expect(level(song([_v1, null, _v2, null, _v3, null]), app), MatchLevel.identical);
    });

    test('inne tylko metadane → sameSong', () {
      final s = song([_v1, null, _v2, null, _v3, null])..performers = ['Ktoś inny'];
      expect(level(s, app), MatchLevel.sameSong);
      expect(cmp(s, app).metadataDiff!.fields, ['performers']);
    });

    test('refren raz, na początku albo w innych miejscach → sameSong, te same chwyty', () {
      for (final parts in [
        [_v1, null, _v2, _v3],
        [null, _v1, _v2, _v3],
        [_v3, null, _v1, _v2],
      ]) {
        final s = cmp(song(parts), app);
        expect(levelOf(s), MatchLevel.sameSong, reason: '$parts');
        expect(s.sameChordsUpToOrder, isTrue, reason: 'chwyty te same, tylko w innej kolejności');
      }
    });

    test('inny tytuł, ten sam tekst → ta sama piosenka, nie „podobny tekst”', () {
      expect(level(song([_v1, null, _v2, null, _v3, null], title: 'Płonie ognisko'), app), MatchLevel.sameSong);
    });

    test('dopisane zwrotki → longer; fragment → shorter', () {
      const more = 'Nowa zwrotka której nie było\nDopisana przez kogoś zupełnie innego\nI jeszcze jeden wers na koniec';
      expect(level(song([_v1, null, _v2, null, _v3, null, more]), app), MatchLevel.longer);
      expect(level(song([_v1, null]), app), MatchLevel.shorter);
    });

    test('literówki → dalej ta sama piosenka', () {
      final s = song([
        'Płonie ognisko i szumiom knieje\nDrużynowy jest wśród nas',
        null,
        'Opowiada starodawne dzieje\nBohaterski wskżesza czas',
        null,
        'O rycerzach i o wojnah\nO harcerskich dawnych dniach',
        null,
      ]);
      expect(level(s, app), MatchLevel.sameSong);
    });

    test('sklejone wersy → dalej ta sama piosenka', () {
      // Przecinek, żeby tekst nie był dosłownie ten sam po zbiciu białych
      // znaków — wtedy wyszłoby `identical` bez patrzenia na wersy.
      String glued(String v) => v.replaceAll('\n', ', ');
      final s = song([glued(_v1), null, glued(_v2), null, glued(_v3), null]);
      final l = cmp(s, app).sharedLines!;
      expect((l.coverage(), l.otherCoverage()), (1.0, 1.0));
      expect(level(s, app), MatchLevel.sameSong);
      expect(level(app, s), MatchLevel.sameSong, reason: 'w obie strony');
    });

    test('przeróbka: te same chwyty i metrum, połowa słów inna → variant/related, nie ta sama', () {
      final s = song([
        'Płonie ognisko w harcówce\nDrużynowy wśród nas je',
        null,
        'Opowiada stare dzieje\nZ obozu i z biwaku',
        null,
        'O zastępach i o grach\nO harcerskich dawnych dniach',
        null,
      ], title: 'Ognisko w harcówce');
      final l = level(s, app);
      expect(l, isNotNull);
      expect(l!.isSameSong, isFalse);
      expect(l.byContent, isTrue);
    });

    test('jeden wers z tymi samymi chwytami to jeszcze nie przeróbka', () {
      // Tak wygląda piosenka w edytorze po pierwszym wpisanym wersie.
      final s = song(['Zupełnie własny tekst i nic poza tym'], title: 'Inna', id: 'o!_inna');
      expect(level(s, app)?.byContent ?? false, isFalse);
    });

    test('ten sam tytuł, inna treść → sameTitleDifferentText', () {
      expect(level(song(['Zupełnie inne słowa o morzu\nŻagle na wietrze i sól na wargach\nDaleko od lasu']), app),
          MatchLevel.sameTitleDifferentText);
    });

    test('wspólny tylko tytuł ukryty to nie „ten sam tytuł”', () {
      final a = song(['Zupełnie inne słowa o morzu\nŻagle na wietrze i sól na wargach'], title: 'A', id: 'o!_a')
        ..hidTitles = ['Kasia Sienkiewicz'];
      final b = song([_v1, _v2], title: 'B', id: 'o!_b')..hidTitles = ['Kasia Sienkiewicz'];
      expect(level(a, b), isNull);
    });
  });
}
