import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('plik .hrcpsng wczytuje się z powrotem ze zgodą', () async {
    final c = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = (c.verdict as Import).song;

    final decoded = importHrcpsng(encodeHrcpsng([song])).$1;
    expect(decoded, hasLength(1));
    expect(decoded.single.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(decoded.single.youtubeVideoId, 'dQw4w9WgXcQ');
    expect(decoded.single.hasChords, isTrue);
  });

  test('zdublowane id dostają sufiks, bez mutacji piosenki', () async {
    final a = (classify(msgFrom(await completeEmail()), book: SongBook.empty).verdict as Import).song;
    final b = (classify(msgFrom(await completeEmail()), book: SongBook.empty).verdict as Import).song;
    expect(a.id, b.id);
    final decoded = importHrcpsng(encodeHrcpsng([a, b])).$1;
    expect(decoded.map((s) => s.id).toSet(), hasLength(2));
    expect(a.id, b.id);
  });

  test('raport liczy import i powody', () async {
    final report = formatReport(classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(await completeEmail(userMessage: 'pytanie'), id: 'bad'),
    ], book: SongBook.empty));
    expect(report, contains('IMPORT   1'));
    expect(report, contains('RĘCZNIE  1'));
    expect(report, contains('   1  ${SkipReason.hasUserMessage.text}'));
    expect(report, contains('[ok]'));
  });
}
