import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:path/path.dart' as p;
import 'package:piosenkomat/classify.dart';
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
    expect(data.legacyAppUsed, isFalse);
    expect(data.userMessage, 'hej');
    expect(data.run, 'import-x');
    expect(data.sentAt, c.submission.sentAt);
    expect(data.issues.map((i) => i.issue), [SongIssue.hasUserMessage, SongIssue.missingYoutube]);
  });

  test('strip: zdejmuje ślad, poprawce daje id poprawianej piosenki', () async {
    final book = bookWith([sampleSong(title: 'Stara', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final items = classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Nowa', lyrics: 'Zupelnie inne')), id: 'n'),
      msgFrom(await completeEmail(isNew: false, correctedSongId: 'tmp', song: sampleSong(title: 'Stara (popr.)', lyrics: 'Ala ma kota\nA kot ma Ale\nZwrotka')), id: 'c'),
    ], book: book);
    final songs = [for (final c in items) c.song!..piosenkomatData = c.piosenkomatData()];
    expect(songs[1].piosenkomatData!.correctionTarget, 'tmp');
    expect(songs.every((s) => s.contributorData?.emailThreadId != null), isTrue,
        reason: 'przed stripem id wątku wiąże piosenkę ze zgłoszeniem');
    // Poprawka zrobiona w apce na własnej kopii przyjeżdża z pamięcią
    // o pierwowzorze w samej piosence.
    songs[1].correctedSongId = 'tmp';
    final targets = stripPiosenkomat(songs);
    expect(songs.every((s) => s.piosenkomatData == null), isTrue);
    expect(songs.every((s) => s.correctedSongId == null), isTrue,
        reason: 'do bazy jedzie sama piosenka, bez pamięci o poprawianiu');
    expect(songs[1].id, 'tmp', reason: 'apka referencjonuje piosenki po lclId');
    expect(targets.single.id, 'tmp');
    expect(targets.single.title, 'Stara (popr.)');
    expect(targets.single.guessed, isFalse, reason: 'cel podany przez apkę');
    expect(songs[0].id, startsWith('o!_'));
    // Ślad to nie tylko pole `piosenkomat` — id wątku ze skrzynki też jest nasze.
    expect(songs.every((s) => s.contributorData?.emailThreadId == null), isTrue);
    expect(songs.every((s) => s.contributorData?.email.isNotEmpty ?? false), isTrue,
        reason: 'reszta contributor_data zostaje — to dane autora, nie nasz ślad');
    expect(encodeHrcpsng(songs), isNot(contains('email_thread_id')));
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
    expect(planPathIn(dir), p.join(dir, 'plan.json'));
    expect(reportPathIn(dir), p.join(dir, 'report.txt'));
    expect(peoplePathIn(dir), p.join(dir, 'people.dart'));
  });
}
