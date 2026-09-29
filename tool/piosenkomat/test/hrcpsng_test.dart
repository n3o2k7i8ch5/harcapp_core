import 'dart:convert';
import 'dart:io';


import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:path/path.dart' as p;
import 'package:piosenkomat/run_dir.dart';
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
    expect(decoded.single.contributorData!.acceptedRulesVersion, 'v05.10.2025');
    expect(decoded.single.youtubeVideoId, 'dQw4w9WgXcQ');
    expect(decoded.single.hasChords, isTrue);
  });

  test('pliku ze zdublowanym id nie zapisujemy — ani nie zmieniamy id po cichu', () async {
    final a = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    final b = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    expect(a.id, b.id);
    expect(() => encodeHrcpsng([a, b]),
        throwsA(isA<HrcpsngDuplicateIdError>().having((e) => e.ids, 'ids', [a.id])));
  });

  test('all_songs ze zdublowanym id: błąd z listą id i śpiewnik się nie wczytuje', () {
    final path = p.join(tempDir().path, 'all_songs.hrcpsng');
    final song = jsonEncode({'song': sampleSong(title: 'Barka').toApiJsonMap(withId: false), 'index': 0});
    File(path).writeAsStringSync('{"official":{"o!_barka":$song,"o!_barka":$song},"conf":{}}');
    expect(
      () => loadBook(path),
      throwsA(isA<FileSystemException>().having((e) => e.message, 'message',
          allOf(contains('W all_songs są zdublowane id (o!_barka)'), contains('napraw plik')))),
    );
  });

  test('assignUniqueIds: sufiks w piosence, nie tylko w pliku', () async {
    final a = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    final b = classify(msgFrom(await completeEmail()), book: SongBook.empty).song!;
    assignUniqueIds([a, b]);
    expect(b.id, '${a.id}~2');
    expect(importHrcpsng(encodeHrcpsng([a, b])).$1.map((s) => s.id).toSet(), {a.id, b.id});
  });

  test('ślad piosenkomatu jedzie do pliku tylko na życzenie i wraca w całości', () async {
    final c = classifyBatch([msgFrom(await completeEmail(song: sampleSong(yt: null), userMessage: 'hej'))],
        book: SongBook.empty, run: 'run-x').single;
    final song = c.song!;
    expect(importHrcpsng(encodeHrcpsng([song])).$1.single.piosenkomatData, isNull,
        reason: 'domyślnie pole nie wychodzi — inaczej wyciekłoby do bazy piosenek');

    final back = importHrcpsng(encodeHrcpsng([song], withPiosenkomatData: true)).$1.single;
    final data = back.piosenkomatData!;
    expect(data.threadId, c.submission.threadId);
    expect(data.kind, SubmissionKind.newSong);
    expect(data.isOldApp, isFalse);
    expect(data.userMessage, 'hej');
    expect(data.run, 'run-x');
    expect(data.sentAt, c.submission.sentAt);
    expect(data.issues.map((i) => i.issue), [SongIssue.userMessage, SongIssue.missingYoutube]);
  });

  test('strip: zgadnięty cel poprawki jedzie z dopiskiem na liście „podmień”', () async {
    const lyrics = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\n'
        'Opowiada starodawne dzieje\nBohaterski wskrzesza czas';
    final book = bookWith([sampleSong(title: 'Stara', lyrics: lyrics)]);
    // Bez deklaracji celu: narzędzie dobiera najbliższą i to oznacza.
    final c = classify(
        msgFrom(await completeEmail(
            isNew: false, song: sampleSong(title: 'Stara', lyrics: '$lyrics\nDopisana zwrotka na koniec'))),
        book: book);
    final song = c.song!;
    expect(song.piosenkomatData!.correctionTargetGuessed, isTrue);
    final replacements = stripPiosenkomat([song]).replacements;
    expect(replacements.single.id, 'tmp');
    expect(replacements.single.guessed, isTrue, reason: 'podmiana po złym id kosztuje cudzą piosenkę');
  });

  test('strip: kopie bez śladu, poprawka pod id poprawianej piosenki, oryginały nietknięte', () async {
    final book = bookWith([sampleSong(title: 'Stara', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final items = classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Nowa', lyrics: 'Zupelnie inne')), id: 'n'),
      msgFrom(await completeEmail(isNew: false, basedOnSongId: 'tmp', song: sampleSong(title: 'Stara (popr.)', lyrics: 'Ala ma kota\nA kot ma Ale\nZwrotka')), id: 'c'),
    ], book: book);
    final songs = [for (final c in items) c.song!];
    expect(songs[1].piosenkomatData!.correctionTarget, 'tmp');
    expect(songs.every((s) => s.piosenkomatData?.threadId != null), isTrue,
        reason: 'przed stripem id wątku wiąże piosenkę ze zgłoszeniem');
    // Poprawka zrobiona w apce na własnej kopii przyjeżdża z pamięcią
    // o pierwowzorze w samej piosence.
    songs[1].basedOnSongId = 'tmp';
    final (songs: stripped, :replacements) = stripPiosenkomat(songs);
    expect(stripped.every((s) => s.piosenkomatData == null), isTrue);
    expect(stripped.every((s) => s.basedOnSongId == null), isTrue,
        reason: 'do bazy jedzie sama piosenka, bez pamięci o poprawianiu');
    expect(stripped[1].id, 'tmp', reason: 'apka referencjonuje piosenki po lclId');
    expect(replacements.single.id, 'tmp');
    expect(replacements.single.title, 'Stara (popr.)');
    expect(replacements.single.guessed, isFalse, reason: 'cel podany przez apkę');
    expect(stripped[0].id, startsWith('o!_'));
    expect(stripped.every((s) => s.contributorData?.email.isNotEmpty ?? false), isTrue,
        reason: 'contributor_data zostaje — to dane autora, nie nasz ślad');
    expect(encodeHrcpsng(stripped), isNot(contains('thread_id')), reason: 'id wątku ze skrzynki nie wycieka');
    // Przegląd zostaje ze śladem: osoby i `summary.md` czytają go także po
    // złożeniu `final-*`, w dowolnej kolejności.
    expect(songs.every((s) => s.piosenkomatData != null), isTrue);
    expect(songs[1].id, isNot('tmp'));
  });

  test('poprawka piosenki z conf: w pliku w sekcji conf, id bez sklejonych przedrostków', () async {
    const lyrics = 'Ala ma kota\nA kot ma Ale';
    final book = bookWith([sampleSong(id: 'oc!_stara', title: 'Stara', lyrics: lyrics)]);
    final c = classify(
        msgFrom(await completeEmail(
            isNew: false, basedOnSongId: 'oc!_stara', song: sampleSong(title: 'Stara', lyrics: '$lyrics\nZwrotka'))),
        book: book);
    final stripped = stripPiosenkomat([c.song!]).songs;
    expect(stripped.single.id, 'oc!_stara');

    final content = encodeHrcpsng(stripped);
    expect((jsonDecode(content)['conf'] as Map).keys, ['oc!_stara'],
        reason: 'apka szuka piosenki oc!_… tylko w conf');
    final (official, conf) = importHrcpsng(content);
    expect(official, isEmpty);
    expect(conf.single.id, 'oc!_stara');
  });

  test('nazwy plików przebiegu', () {
    final run = RunDir.current(root: 'x');
    final dir = run.path;
    expect(dir, p.join('x', 'out', 'run'), reason: 'przebieg jest jeden naraz — zawsze ten sam katalog');
    expect(run.candidates(SubmissionKind.newSong), p.join(dir, 'candidates-new.hrcpsng'));
    expect(run.candidates(SubmissionKind.correction), p.join(dir, 'candidates-correction.hrcpsng'));
    expect(run.reviewed(SubmissionKind.newSong), p.join(dir, 'reviewed-new.hrcpsng'));
    expect(run.finalSongs(SubmissionKind.correction), p.join(dir, 'final-correction.hrcpsng'));
    expect(run.plan, p.join(dir, 'plan.json'));
    expect(run.report, p.join(dir, 'report.txt'));
    expect(run.people, p.join(dir, 'people.dart'));
    expect(run.drafts, p.join(dir, 'drafts.json'));
    expect(run.summary, p.join(dir, 'summary.md'));
  });

  test('archiwum: katalog przebiegu obok out/, drugi raz z sufiksem', () {
    final root = tempDir().path;
    expect(archivePath('run-1', root: root), p.join(root, 'archive', 'run-1'));
    Directory(p.join(root, 'archive', 'run-1')).createSync(recursive: true);
    expect(archivePath('run-1', root: root), p.join(root, 'archive', 'run-1~2'));
  });
}
