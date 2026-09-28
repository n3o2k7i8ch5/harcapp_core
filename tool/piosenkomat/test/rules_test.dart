import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/reply.dart';
import 'package:piosenkomat/review.dart';
import 'package:test/test.dart';

/// Reguły, które kiedyś siedziały w komendach i dało się je sprawdzić tylko
/// na żywej skrzynce.
void main() {
  group('plural', () {
    test('odmienia jak po polsku', () {
      String mejl(int n) => plural(n, 'mejl', 'mejle', 'mejli');
      expect(mejl(1), '1 mejl');
      expect(mejl(2), '2 mejle');
      expect(mejl(4), '4 mejle');
      expect(mejl(5), '5 mejli');
      expect(mejl(12), '12 mejli');
      expect(mejl(14), '14 mejli');
      expect(mejl(22), '22 mejle');
      expect(mejl(0), '0 mejli');
    });
  });

  group('withReadOnClose', () {
    test('werdykt domykający zdejmuje nieprzeczytane', () {
      expect(withReadOnClose(([SongLabel.rejectedAfterReview.label], [SongLabel.readyToAdd.label])).$2,
          [SongLabel.readyToAdd.label, 'UNREAD']);
      expect(withReadOnClose(([SongLabel.added.label], const [])).$2, ['UNREAD']);
    });
    test('reszta zostaje nieprzeczytana', () {
      expect(withReadOnClose(([SongLabel.needsReview.label], const [])).$2, isEmpty);
      expect(withReadOnClose(([SongLabel.replyReviewNote.label], const [])).$2, isEmpty);
    });
    test('nie dubluje UNREAD', () {
      expect(withReadOnClose(([SongLabel.added.label], ['UNREAD'])).$2, ['UNREAD']);
    });
    test('tekst do autora czeka na wysyłkę → zostaje nieprzeczytany', () {
      expect(
          withReadOnClose(([SongLabel.added.label], [SongLabel.readyToAdd.label]),
              current: {SongLabel.readyToAdd.label, SongLabel.replyReviewNote.label}).$2,
          [SongLabel.readyToAdd.label]);
      expect(
          withReadOnClose(([SongLabel.added.label], [SongLabel.readyToAdd.label]), current: {SongLabel.readyToAdd.label}).$2,
          [SongLabel.readyToAdd.label, 'UNREAD']);
    });
  });

  group('openVerdicts: co trzyma przebieg otwarty', () {
    test('werdykt automatu czeka na review albo finalize', () {
      expect(
          openVerdicts({
            'ready': {SongLabel.auto.label, SongLabel.readyToAdd.label},
            'review': {SongLabel.auto.label, SongLabel.needsReview.label, SongLabel.missingData.label},
          }),
          ['ready', 'review']);
    });
    test('nie trzyma: ręczne „ready-to-add”, odrzuty, dodane, odpowiedzi, czekanie na autora', () {
      expect(
          openVerdicts({
            'reczne': {SongLabel.readyToAdd.label},
            'odrzut': {SongLabel.auto.label, SongLabel.rejectedAfterReview.label},
            'dodana': {SongLabel.auto.label, SongLabel.added.label},
            'odpowiedz': {SongLabel.auto.label, SongLabel.replyOldApp.label, SongLabel.replyReviewNote.label},
            'czeka': {SongLabel.auto.label, SongLabel.waitingForAuthor.label},
            'recznie': {SongLabel.auto.label, SongLabel.multipleSongs.label, SongLabel.haveALook.label},
          }),
          isEmpty);
    });
  });

  group('unlabelChanges', () {
    test('zdejmuje tylko etykiety narzędzia i tylko ze śladem automatu', () {
      final r = unlabelChanges({
        'auto': {SongLabel.auto.label, SongLabel.readyToAdd.label, 'song/rejected/silly'},
        'reczne': {'song/rejected/silly'},
      });
      expect(r.toRemove.keys, ['auto']);
      expect(r.toRemove['auto'], [SongLabel.auto.label, SongLabel.readyToAdd.label]);
    });
    test('domknięte zostają bez --force', () {
      final labels = {
        'added': {SongLabel.auto.label, SongLabel.added.label},
      };
      final r = unlabelChanges(labels);
      expect(r.toRemove, isEmpty);
      expect(r.added, 1);
      expect(unlabelChanges(labels, force: true).toRemove.keys, ['added']);
    });
    test('z zakresem: tylko mejle przebiegu', () {
      final r = unlabelChanges({
        'w': {SongLabel.auto.label, SongLabel.needsReview.label},
        'poza': {SongLabel.auto.label, SongLabel.needsReview.label},
      }, scope: {'w'});
      expect(r.toRemove.keys, ['w']);
      expect(r.outsideScope, 1);
    });
  });

  group('reviewSafetyError', () {
    ReviewResult resultWith({int removed = 0}) => ReviewResult(
          kind: SubmissionKind.newSong,
          accepted: const [],
          removed: [
            for (var i = 0; i < removed; i++)
              ReviewCandidate(
                  threadId: 't$i', planned: PlannedSong(songId: 's$i', title: 'x')),
          ],
          foreign: const [],
          wrongKind: const [],
          duplicateTargets: const {},
        );

    test('eksport bez żadnej piosenki to prawie na pewno pomyłka', () {
      expect(
          reviewSafetyError(resultWith(),
              reviewedPath: 'r.hrcpsng', reviewedCount: 0, candidateCount: 3),
          contains('nie zawiera żadnej piosenki'));
    });
    test('odrzucona większość zatrzymuje', () {
      expect(
          reviewSafetyError(resultWith(removed: 2),
              reviewedPath: 'r', reviewedCount: 1, candidateCount: 3),
          contains('ponad połowa'));
      expect(
          reviewSafetyError(resultWith(removed: 1),
              reviewedPath: 'r', reviewedCount: 2, candidateCount: 3),
          isNull);
    });
  });

  group('draftStep: narzędzie rusza tylko szkic bez ludzkiego tekstu', () {
    final block = composeContribReply(oldApp: true)!;
    final note = composeContribReply(reviewNote: 'Brakuje chwytów.')!;
    final noteWithBlock = composeContribReply(reviewNote: 'Brakuje chwytów.', oldApp: true)!;

    test('bez szkicu: zakłada, gdy jest co napisać', () {
      expect(draftStep(exists: false, want: note), DraftStep.create);
      expect(draftStep(exists: false), DraftStep.none);
    });
    test('taki, jaki ma być — także przełamany przez Gmaila', () {
      expect(draftStep(exists: true, body: note, want: note), DraftStep.keep);
      expect(draftStep(exists: true, body: noteWithBlock.replaceAll('. ', '.\n'), want: noteWithBlock),
          DraftStep.keep);
    });
    test('sama ramka i blok: wolno przeliczyć albo skasować', () {
      expect(draftStep(exists: true, body: block, want: noteWithBlock), DraftStep.rewrite);
      expect(draftStep(exists: true, body: block), DraftStep.delete);
    });
    test('ten sam tekst, inna ramka (doszedł blok): przeliczenie nic Twojego nie zmienia', () {
      expect(draftStep(exists: true, body: note, want: noteWithBlock), DraftStep.rewrite);
    });
    test('szkic z innym tekstem jest Twój — zostaje, narzędzie mówi o różnicy', () {
      final edited = composeContribReply(reviewNote: 'Brakuje chwytów w refrenie.')!;
      expect(draftStep(exists: true, body: edited, want: note), DraftStep.differs);
      expect(draftStep(exists: true, body: edited), DraftStep.differs);
    });
    test('pisany ręcznie albo nieczytelny — nietknięty', () {
      expect(draftStep(exists: true, body: 'Cześć, piszę sam.', want: note), DraftStep.manual);
      expect(draftStep(exists: true, want: note), DraftStep.manual);
    });
  });
}
