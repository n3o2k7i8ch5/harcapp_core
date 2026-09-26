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
}
