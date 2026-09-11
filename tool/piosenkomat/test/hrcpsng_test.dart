import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('plik .hrcpsng wczytuje się z powrotem ze zgodą', () async {
    final c = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = c.song!;

    final decoded = importHrcpsng(encodeHrcpsng([song])).$1;
    expect(decoded, hasLength(1));
    expect(decoded.single.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(decoded.single.youtubeVideoId, 'dQw4w9WgXcQ');
    expect(decoded.single.hasChords, isTrue);
  });

  test('zdublowane id dostają sufiks, bez mutacji piosenki', () async {
    final a = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    final b = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    expect(a.id, b.id);
    final decoded = importHrcpsng(encodeHrcpsng([a, b])).$1;
    expect(decoded.map((s) => s.id).toSet(), hasLength(2));
    expect(a.id, b.id);
  });

  test('assignUniqueIds: sufiks w piosence, nie tylko w pliku', () async {
    final a = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    final b = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    expect(a.id, b.id);
    assignUniqueIds([a, b]);
    expect(b.id, '${a.id}~2');
    // Plik nie musi już nic przemianowywać, więc plan i plik mówią to samo.
    expect(importHrcpsng(encodeHrcpsng([a, b])).$1.map((s) => s.id).toSet(), {a.id, b.id});
  });

  test('uwagi jadą do pliku tylko na życzenie', () async {
    final c = classify(msgFrom(await completeEmail(song: sampleSong(yt: null))),
        book: SongBook.empty);
    final song = c.song!;
    expect(song.piosenkomatData!.issues.single.issue, SongIssue.missingYoutube);

    // Domyślnie pole nie wychodzi z piosenki — inaczej ślad przeglądu
    // wyciekłby do bazy piosenek.
    expect(importHrcpsng(encodeHrcpsng([song])).$1.single.piosenkomatData, isNull);

    final back = importHrcpsng(
            encodeHrcpsng([song], withPiosenkomatData: true)).$1.single;
    expect(back.piosenkomatData!.emailMsgId, c.message.id);
    expect(back.piosenkomatData!.toResolve.single.issue, SongIssue.missingYoutube);
  });

  test('raport liczy piosenki i uwagi', () async {
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(await completeEmail(userMessage: 'pytanie'), id: 'bad'),
    ], book: SongBook.empty));
    expect(report, contains('BEZ ZARZUTU     1'));
    expect(report, contains('DO PRZEGLĄDU    1'));
    expect(report, contains('   1  ${SongIssue.hasUserMessage.text}'));
    expect(report, contains('[ok]'));
  });

  test('raport przebiegu: sparsowane vs nie, jedna przeszkoda vs kilka', () async {
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(), id: 'ok'),
      msgFrom(
          await completeEmail(song: sampleSong(title: 'Bez YT', yt: null, lyrics: 'Ala ma kota')),
          id: 'yt'),
      msgFrom(
        await completeEmail(
            song: sampleSong(
                title: 'Bez niczego', yt: null, chords: false, lyrics: 'Wlazl kotek na plotek')),
        id: 'both',
      ),
      msgFrom('From: a@b.pl\nSubject: Cześć\n\nCześć, mam pytanie', id: 'raw'),
    ], book: SongBook.empty));
    expect(report, contains('SKLASYFIKOWANO  4'));
    expect(report, contains('SPARSOWANE      3'));
    expect(report, contains('NIE SPARSOWANE  1'));
    expect(report, contains('BEZ ZARZUTU     1'));
    expect(report, contains('Jedyna uwaga do zgłoszenia'));
    expect(report, contains(SongIssue.missingYoutube.text));
    expect(report, contains('Kilka uwag naraz:'));
    expect(report, contains(
        '${SongIssue.missingChords.text}; ${SongIssue.missingYoutube.text}'));
  });

  test('domyślne wyjście to katalog przebiegu', () {
    final dir = defaultOutDir();
    expect(p.split(dir), hasLength(2));
    expect(p.split(dir).first, 'out');
    expect(p.basename(dir), startsWith('import-'));
    expect(autoPathIn(dir), p.join(dir, 'auto.hrcpsng'));
    expect(reviewPathIn(dir), p.join(dir, 'review.hrcpsng'));
    expect(reviewedPathIn(dir), p.join(dir, 'reviewed.hrcpsng'));
    expect(decisionsPathIn(dir), p.join(dir, 'decisions.json'));
    expect(planPathIn(dir), p.join(dir, 'labels.json'));
    expect(reportPathIn(dir), p.join(dir, 'report.txt'));
    expect(peoplePathIn(dir), p.join(dir, 'people.dart'));
  });
}
