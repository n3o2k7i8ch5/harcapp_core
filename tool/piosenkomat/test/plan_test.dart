import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:path/path.dart' as p;
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('plan: etykiety per wiadomość, piosenki per wątek, zapis i odczyt', () async {
    final original = msgFrom(await completeEmail(), id: 'ok');
    final reply = ContribMessage(
        id: 'ok2', threadId: 'ok', body: 'dzięki', subject: 'Re', from: original.from,
        date: DateTime.parse('2026-09-07T10:00:00+02:00'));
    final items = classifyBatch([
      original,
      reply,
      msgFrom(
          await completeEmail(
              song: sampleSong(title: 'Inna piosenka', lyrics: 'Wlazl kotek na plotek'),
              userMessage: 'hej'),
          id: 'msg'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Trzecia', lyrics: 'Zupelnie inna')),
          id: 'corr'),
    ], book: SongBook.empty);
    final plan = LabelPlan.fromClassified(items);
    // „dzięki” w odpowiedzi to dopisek autora — stąd `user-message`.
    final okLabels = [kLabelNeedsReview, NeedsReviewKind.userMessage.label, kLabelAuto];
    expect(plan.labelsByMessage['ok'], okLabels);
    expect(plan.labelsByMessage['ok2'], okLabels, reason: 'etykiety idą na cały wątek');
    expect(plan.labelsByMessage['msg'], [kLabelNeedsReview, NeedsReviewKind.userMessage.label, kLabelAuto]);
    expect(plan.labelsByMessage['corr'],
        [kLabelNeedsReview, NeedsReviewKind.correctionProblem.label, kLabelCorrection, kLabelAuto]);
    expect(plan.messagesOf('ok'), ['ok', 'ok2']);

    final dir = tempDir();
    final path = planPathIn(dir.path);
    expect(path, p.join(dir.path, 'plan.json'));
    writePlan(path, plan);
    final back = readPlan(path);
    expect(back.labelsByMessage, plan.labelsByMessage);
    expect(back.songsByThread['ok']!.single.kind, SubmissionKind.newSong);
    expect(back.songsByThread['corr']!.single.kind, SubmissionKind.correction);
    expect(back.messagesOf('ok'), ['ok', 'ok2']);
  });
}
