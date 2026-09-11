import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:path/path.dart' as p;
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
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(await completeEmail(userMessage: 'pytanie'), id: 'bad'),
    ], book: SongBook.empty));
    expect(report, contains('IMPORT          1'));
    expect(report, contains('RĘCZNIE         1'));
    expect(report, contains('   1  ${SkipReason.hasUserMessage.text}'));
    expect(report, contains('[ok]'));
  });

  test('raport przebiegu: sparsowane vs nie, jedna przeszkoda vs kilka', () async {
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(await completeEmail(song: sampleSong(yt: null)), id: 'yt'),
      msgFrom(
        await completeEmail(song: sampleSong(yt: null, chords: false)),
        id: 'both',
      ),
      msgFrom('From: a@b.pl\nSubject: Cześć\n\nCześć, mam pytanie', id: 'raw'),
    ], book: SongBook.empty));
    expect(report, contains('SKLASYFIKOWANO  4'));
    expect(report, contains('SPARSOWANE      3'));
    expect(report, contains('NIE SPARSOWANE  1'));
    expect(report, contains('IMPORT          1'));
    expect(report, contains('Blokowane wyłącznie przez to'));
    expect(report, contains(SkipReason.missingYoutube.text));
    expect(report, contains('Blokowane przez kilka rzeczy naraz:'));
    expect(report, contains(
        '${SkipReason.missingChords.text}; ${SkipReason.missingYoutube.text}'));
  });

  test('domyślne wyjście to katalog przebiegu', () {
    final dir = defaultOutDir();
    expect(p.split(dir), hasLength(2));
    expect(p.split(dir).first, 'out');
    expect(p.basename(dir), startsWith('import-'));
    expect(songsPathIn(dir), p.join(dir, 'songs.hrcpsng'));
    expect(planPathIn(dir), p.join(dir, 'labels.json'));
    expect(reportPathIn(dir), p.join(dir, 'report.txt'));
    expect(peoplePathIn(dir), p.join(dir, 'people.dart'));
  });
}
