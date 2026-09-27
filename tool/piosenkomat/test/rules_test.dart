import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
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

  group('pendingLabelsOf (clean)', () {
    test('czeka: werdykt w pliku, przegląd, kolejka odpowiedzi', () {
      expect(pendingLabelsOf({SongLabel.auto.label, SongLabel.readyToAdd.label}), {SongLabel.readyToAdd.label});
      expect(pendingLabelsOf({SongLabel.needsReview.label, SongLabel.missingData.label}),
          {SongLabel.needsReview.label, SongLabel.missingData.label});
      expect(pendingLabelsOf({SongLabel.replyOldApp.label, SongLabel.replyReviewNote.label}),
          {SongLabel.replyOldApp.label, SongLabel.replyReviewNote.label});
    });
    test('nie czeka: odrzuty, dodane, znaczniki, czekanie na autora', () {
      expect(
          pendingLabelsOf({
            SongLabel.added.label,
            SongLabel.rejectedUnparsable.label,
            SongLabel.haveALook.label,
            SongLabel.correction.label,
            SongLabel.waitingForAuthor.label,
            SongLabel.auto.label,
          }),
          isEmpty);
    });
  });

  group('unlabelChanges', () {
    RunPlan planOf(List<String> ids) => RunPlan(
          createdAt: DateTime(2026),
          labelsByMessage: {for (final id in ids) id: const []},
          songByThread: const {},
          messagesByThread: const {},
        );

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
    test('z planem: tylko mejle przebiegu', () {
      final r = unlabelChanges({
        'w': {SongLabel.auto.label, SongLabel.needsReview.label},
        'poza': {SongLabel.auto.label, SongLabel.needsReview.label},
      }, plan: planOf(['w']));
      expect(r.toRemove.keys, ['w']);
      expect(r.outsidePlan, 1);
    });
  });

  group('reviewSafetyError', () {
    ReviewResult resultWith({int removed = 0}) => ReviewResult(
          kind: SubmissionKind.newSong,
          accepted: const [],
          removed: [
            for (var i = 0; i < removed; i++)
              ReviewCandidate(
                  threadId: 't$i', planned: PlannedSong(songId: 's$i', title: 'x', sender: '')),
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

  group('draftActionFor', () {
    final text = composeContribReply(oldApp: true)!;

    test('ta sama treść → bez zmian', () {
      expect(draftActionFor(text, text), DraftAction.unchanged);
      expect(draftActionFor('  $text\n', text), DraftAction.unchanged);
    });
    test('nasz kształt, inna treść → przeliczamy', () {
      final older = composeContribReply(reviewNote: 'Stara uwaga.')!;
      expect(isToolShapedReply(older), isTrue);
      expect(draftActionFor(older, text), DraftAction.rewrite);
    });
    test('ruszony ręcznie albo nieczytelny → zostawiamy', () {
      expect(draftActionFor('Cześć, piszę sam.', text), DraftAction.leaveManual);
      expect(draftActionFor(null, text), DraftAction.leaveManual);
    });
  });
}
