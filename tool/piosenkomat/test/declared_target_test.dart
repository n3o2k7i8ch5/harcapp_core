import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _tekst = 'Pan kiedyś stanął nad brzegiem\nSzukał ludzi gotowych pójść za Nim';

void main() {
  group('cel poprawki wskazany przez apkę — ten sam lookupId, co w edytorze', () {
    Future<Classified> poprawka(String celZApki, List<String> idsWApce) async => classify(
          msgFrom(await completeEmail(
            isNew: false,
            correctionTarget: celZApki,
            song: sampleSong(title: 'Barka', lyrics: '$_tekst\nDopisana zwrotka'),
          )),
          book: bookWith([
            for (final id in idsWApce) sampleSong(id: id, title: 'Barka', lyrics: _tekst),
          ]),
        );

    test('dokładne id → cel bez uwagi', () async {
      final c = await poprawka('o!_barka@sdm', ['o!_barka@sdm']);
      expect(c.submission.correctionTarget, 'o!_barka@sdm');
      expect(c.submission.correctionTargetGuessed, isFalse);
      expect(issuesOf(c), isNot(contains(SongIssue.guessedCorrectionTarget)));
      expect(issuesOf(c), isNot(contains(SongIssue.differsFromTarget)), reason: 'dopisana zwrotka to zwykła poprawka');
    });

    test('id sprzed zmiany wykonawcy → cel znaleziony, ale oznaczony jako domysł', () async {
      final c = await poprawka('o!_barka@dom', ['o!_barka@sdm']);
      expect(c.submission.correctionTarget, 'o!_barka@sdm');
      expect(c.submission.correctionTargetGuessed, isTrue);
      expect(detailOf(c, SongIssue.guessedCorrectionTarget), contains('inny wykonawca'));
      expect(issuesOf(c), isNot(contains(SongIssue.noTargetInApp)));
    });

    test('bez wykonawcy pasuje kilka → brak celu z listą kandydatów', () async {
      final c = await poprawka('o!_barka@dom', ['o!_barka@sdm', 'o!_barka@zespol']);
      expect(c.submission.correctionTarget, isNull);
      expect(detailOf(c, SongIssue.noTargetInApp), allOf(contains('o!_barka@sdm'), contains('o!_barka@zespol')));
    });
  });

  group('poprawka znacząco różna od celu → ostrzeżenie differs-from-target', () {
    const ognisko = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\n'
        'Opowiada starodawne dzieje\nBohaterski wskrzesza czas';
    Future<Classified> poprawka(String lyrics, {String title = 'Płonie ognisko', String chords = 'a d e\na d e'}) async =>
        classify(
          msgFrom(await completeEmail(
            isNew: false,
            correctionTarget: 'o!_plonie_ognisko',
            song: sampleSong(title: title, lyrics: lyrics, chordsText: chords),
          )),
          book: bookWith([sampleSong(id: 'o!_plonie_ognisko', title: 'Płonie ognisko', lyrics: ognisko)]),
        );

    test('zupełnie inna piosenka jako poprawka → cel zostaje, ale z ostrzeżeniem do przeglądu', () async {
      final c = await poprawka(_tekst, title: 'Barka', chords: 'C G\nF C');
      expect(c.destination, Destination.candidate);
      expect(c.submission.correctionTarget, 'o!_plonie_ognisko', reason: 'to dane z apki — rozstrzygasz przy przeglądzie');
      expect(issuesOf(c), [SongIssue.differsFromTarget]);
      expect(detailOf(c, SongIssue.differsFromTarget), startsWith('„Płonie ognisko” w apce: treść niepodobna'));
      expect(c.labels, containsAll([SongLabel.needsReview.label, SongLabel.correctionProblem.label]));
      expect(c.labels, isNot(contains(SongLabel.readyToAdd.label)), reason: 'nie „bez zarzutu”');
    });

    test('fragment celu → ostrzeżenie, bo podmiana skasowałaby resztę zwrotek', () async {
      final c = await poprawka(ognisko.split('\n').take(2).join('\n'));
      expect(detailOf(c, SongIssue.differsFromTarget), contains('brak części zwrotek'));
    });

    test('zwykła poprawka — literówka albo dopisana zwrotka → bez ostrzeżenia', () async {
      for (final lyrics in [ognisko.replaceFirst('knieje', 'kniejee'), '$ognisko\nDopisana zwrotka na sam koniec']) {
        expect(issuesOf(await poprawka(lyrics)), isNot(contains(SongIssue.differsFromTarget)), reason: lyrics);
      }
    });
  });
}
