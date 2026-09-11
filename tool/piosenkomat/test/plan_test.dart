import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('plan: etykiety per mejl, zapis i odczyt', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(
          await completeEmail(
              song: sampleSong(title: 'Inna piosenka', lyrics: 'Wlazl kotek na plotek'),
              userMessage: 'hej'),
          id: 'msg'),
    ], book: SongBook.empty);
    final plan = LabelPlan.fromClassified(items, files: {
      RunFile.auto: 'out/auto.hrcpsng',
      RunFile.review: 'out/review.hrcpsng',
    });
    expect(plan.labelsById['ok'], [kLabelReady, kLabelAuto]);
    expect(plan.labelsById['msg'], [kLabelToReview, ReviewKind.userMessage.label, kLabelAuto]);

    final dir = Directory.systemTemp.createTempSync('plan');
    final path = planPathIn(dir.path);
    expect(path, p.join(dir.path, 'labels.json'));
    writePlan(path, plan);
    final back = readPlan(path);
    expect(back.labelsById, plan.labelsById);
    expect(back.autoPath, 'out/auto.hrcpsng');
    expect(back.reviewPath, 'out/review.hrcpsng');
    expect(back.songsById['ok']!.single.file, RunFile.auto);
    expect(back.songsById['msg']!.single.file, RunFile.review);
    expect(back.songsById['msg']!.single.issues, ['has-user-message']);
    dir.deleteSync(recursive: true);
  });
}
