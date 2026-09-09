import 'dart:io';

import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('plan: etykiety per mejl, zapis i odczyt', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(await completeEmail(userMessage: 'hej'), id: 'msg'),
    ], book: SongBook.empty);
    final plan = LabelPlan.fromClassified(items, 'out/x.hrcpsng');
    expect(plan.labelsById['ok'], [kLabelReady, kLabelAuto]);
    expect(plan.labelsById['msg'], [kLabelToReview, ReviewKind.userMessage.label, kLabelAuto]);

    final dir = Directory.systemTemp.createTempSync('plan');
    final path = planPathFor('${dir.path}/x.hrcpsng');
    expect(path, endsWith('x.labels.json'));
    writePlan(path, plan);
    final back = readPlan(path);
    expect(back.labelsById, plan.labelsById);
    expect(back.hrcpsngPath, 'out/x.hrcpsng');
    dir.deleteSync(recursive: true);
  });
}
