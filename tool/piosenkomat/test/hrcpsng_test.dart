import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:path/path.dart' as p;
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/similarity.dart';
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
    assignUniqueIds([a, b]);
    expect(b.id, '${a.id}~2');
    expect(importHrcpsng(encodeHrcpsng([a, b])).$1.map((s) => s.id).toSet(), {a.id, b.id});
  });

  test('ślad piosenkomatu jedzie do pliku tylko na życzenie i wraca w całości', () async {
    final c = classify(msgFrom(await completeEmail(song: sampleSong(yt: null), userMessage: 'hej')),
        book: SongBook.empty);
    final song = c.song!..piosenkomatData = c.piosenkomatData(run: 'import-x');
    expect(importHrcpsng(encodeHrcpsng([song])).$1.single.piosenkomatData, isNull,
        reason: 'domyślnie pole nie wychodzi — inaczej wyciekłoby do bazy piosenek');

    final back = importHrcpsng(encodeHrcpsng([song], withPiosenkomatData: true)).$1.single;
    final data = back.piosenkomatData!;
    expect(data.threadId, c.submission.threadId);
    expect(data.kind, SubmissionKind.newSong);
    expect(data.source, SubmissionSource.currentApp);
    expect(data.userMessage, 'hej');
    expect(data.run, 'import-x');
    expect(data.sentAt, c.submission.sentAt);
    expect(data.issues.map((i) => i.issue), [SongIssue.hasUserMessage, SongIssue.missingYoutube]);
  });

  test('strip: zdejmuje ślad, poprawce daje id poprawianej piosenki', () async {
    final book = bookWith([sampleSong(title: 'Stara', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final items = classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Nowa', lyrics: 'Zupelnie inne')), id: 'n'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Stara (popr.)', lyrics: 'Ala ma kota\nA kot ma Ale\nZwrotka')), id: 'c'),
    ], book: book);
    final songs = [for (final c in items) c.song!..piosenkomatData = c.piosenkomatData()];
    expect(songs[1].piosenkomatData!.correctionTarget, 'tmp');
    final targets = stripPiosenkomat(songs);
    expect(songs.every((s) => s.piosenkomatData == null), isTrue);
    expect(songs[1].id, 'tmp', reason: 'apka referencjonuje piosenki po lclId');
    expect(targets, [('tmp', 'Stara (popr.)')]);
    expect(songs[0].id, startsWith('o!_'));
  });

  test('raport liczy nowe, poprawki, odrzuty i sam mejl', () async {
    final book = bookWith([sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Czysta', lyrics: 'Zupelnie inne slowa')), id: 'ok'),
      msgFrom(await completeEmail(song: sampleSong(title: 'Bez YT', yt: null, lyrics: 'Wlazl kotek na plotek')), id: 'yt'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale\nX')), id: 'corr'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')), id: 'dup'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale'), userMessage: 'hej'), id: 'msg'),
      msgFrom('From: a@b.pl\nSubject: Cześć\n\nCześć, mam pytanie', id: 'raw'),
    ], book: book));
    expect(report, contains('ZGŁOSZEŃ        6'));
    expect(report, contains('NIE SPARSOWANE  1'));
    expect(report, contains('NOWE            2'));
    expect(report, contains('  bez zarzutu   1'));
    expect(report, contains('  z uwagami     1'));
    expect(report, contains('POPRAWKI        1'));
    expect(report, contains('  już w apce    1'));
    expect(report, contains('SAM MEJL        1'));
    expect(report, contains('missing-youtube'));
    expect(report, contains('[ok]'));
    expect(report, contains('NIEPARS  Cześć'));
  });

  test('nazwy plików przebiegu', () {
    final dir = defaultOutDir();
    expect(p.split(dir), hasLength(2));
    expect(p.split(dir).first, 'out');
    expect(p.basename(dir), startsWith('import-'));
    expect(candidatesPathIn(dir, SubmissionKind.newSong), p.join(dir, 'candidates-new.hrcpsng'));
    expect(candidatesPathIn(dir, SubmissionKind.correction), p.join(dir, 'candidates-correction.hrcpsng'));
    expect(reviewedPathIn(dir, SubmissionKind.newSong), p.join(dir, 'reviewed-new.hrcpsng'));
    expect(finalPathIn(dir, SubmissionKind.correction), p.join(dir, 'final-correction.hrcpsng'));
    expect(decisionsPathIn(dir), p.join(dir, 'decisions.json'));
    expect(planPathIn(dir), p.join(dir, 'labels.json'));
    expect(reportPathIn(dir), p.join(dir, 'report.txt'));
    expect(peoplePathIn(dir), p.join(dir, 'people.dart'));
  });
}
