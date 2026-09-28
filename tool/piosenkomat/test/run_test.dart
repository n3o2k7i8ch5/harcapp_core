import 'dart:io';

import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:path/path.dart' as p;
import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/plan.dart';
import 'package:piosenkomat/review.dart';
import 'package:piosenkomat/run_dir.dart';
import 'package:test/test.dart';

import 'fake_mailbox.dart';
import 'helpers.dart';

const _new = SubmissionKind.newSong;
const _correction = SubmissionKind.correction;

const _ognisko = 'Płonie ognisko i szumią knieje\nDrużynowy jest wśród nas\n'
    'Opowiada starodawne dzieje\nBohaterski wskrzesza czas';
const _barka = 'Pan kiedyś stanął nad brzegiem\nSzukał ludzi gotowych pójść za Nim\n'
    'By łowić serca słów Bożych prawdą\nO Panie, to Ty na mnie spojrzałeś';
const _kasia = 'Kasia <kasia@example.com>';

/// Skrzynka, śpiewnik i katalog narzędzia na niby — cały świat jednego testu.
class _World {
  final String root = tempDir().path;
  final mailbox = FakeMailbox();
  late final String db = p.join(root, 'all_songs.hrcpsng');

  _World({List<SongRaw> app = const []}) {
    writeHrcpsng(db, app);
  }

  RunDir get run => RunDir.current(root: root);

  Future<int> cli(List<String> args) => runPiosenkomat(
        [...args, if (const {'scan', 'finalize'}.contains(args.first)) ...['--songs-db', db]],
        root: root,
        connect: (_) async => mailbox,
      );

  /// Zgłoszenie z apki: mejl z plikiem zgłoszenia. Film zależy od tekstu.
  void submit(String id,
      {String title = 'Ognisko',
      String lyrics = _ognisko,
      bool youtube = true,
      SubmissionKind kind = _new,
      String? target}) {
    final song = youtube ? sampleSong(title: title, lyrics: lyrics) : sampleSong(title: title, lyrics: lyrics, yt: null);
    mailbox.add(FakeMail(id, id,
        raw: submissionEmail(submissions: [SongSubmission(kind: kind, correctionTarget: target, song: song)]).eml));
  }

  /// Zgłoszenie z najstarszej apki — każde z własnym filmem.
  void submitOld(String id, {String title = 'Stara piosenka', String lyrics = _barka, String from = _kasia}) =>
      mailbox.add(FakeMail(id, id,
          from: from,
          subject: 'Piosenka własna',
          body: oldAppBody(title: title, lyrics: lyrics, yt: id.padRight(11, '_'))));

  Set<String> labels(String id) => mailbox.mails.firstWhere((m) => m.id == id).labels;
  String? draftIn(String thread) =>
      mailbox.drafts.values.where((d) => d.threadId == thread).firstOrNull?.body;

  /// Eksport ze strony: kandydaci po przejściu przez format pliku, z tym, co
  /// [edit] zmieni na piosenkach.
  void export(SubmissionKind kind, [void Function(SongRaw song)? edit]) {
    final songs = roundTrip(readHrcpsng(run.candidates(kind)));
    for (final s in songs) {
      edit?.call(s);
    }
    writeHrcpsng(run.reviewed(kind), songs, withPiosenkomatData: true);
  }

  /// Wklejenie `final-*` do `all_songs` — tak, jak robisz to ręcznie.
  void paste() {
    final byId = {for (final s in readHrcpsng(db)) s.id: s};
    for (final kind in run.kinds) {
      for (final s in readHrcpsng(run.finalSongs(kind))) {
        byId[s.id] = s;
      }
    }
    writeHrcpsng(db, byId.values.toList());
  }
}

void Function(SongRaw) _verdict({bool accepted = true, String? note}) => (song) => song.piosenkomatData =
    song.piosenkomatData!.copyWith(accepted: () => accepted ? null : false, reviewNote: () => note);

void main() {
  group('scan: przebieg jest jeden naraz', () {
    test('kolejka nie bierze zgłoszeń ze strony', () {
      expect(kQueueQuery, contains('-subject:"${submissionSubjectTag(SubmissionOrigin.web)}"'));
    });

    test('--push otwiera przebieg: out/run, etykiety, szkic z blokiem o starej apce', () async {
      final w = _World()
        ..submit('a')
        ..submitOld('o');
      expect(await w.cli(['scan', '--push']), 0);
      expect(w.run.exists, isTrue);
      expect(w.run.readRunPlan().pushedAt, isNotNull);
      expect(w.labels('a'), containsAll([SongLabel.auto.label, SongLabel.readyToAdd.label]));
      expect(w.labels('o'), contains(SongLabel.replyOldApp.label));
      expect(carriesOldAppBlock(w.draftIn('o')!), isTrue);
      expect(w.mailbox.sentTexts, isEmpty, reason: 'szkic to nie wysyłka');
    });

    test('szkic idzie na sam adres autora — bez nazwy z nagłówka', () async {
      // Nazwa z przecinkiem wpisana w `To:` wyglądałaby jak dwa adresy.
      final w = _World()..submitOld('o', from: '"Kowalska, Kasia" <Kasia@Example.com>');
      expect(await w.cli(['scan', '--push']), 0);
      expect(w.mailbox.draftTo.values, ['kasia@example.com']);
    });

    test('bez --push tylko raport: ani katalogu, ani etykiet', () async {
      final w = _World()..submit('a');
      expect(await w.cli(['scan']), 0);
      expect(w.run.exists, isFalse);
      expect(w.labels('a'), isEmpty);
    });

    test('drugi scan przy otwartym przebiegu staje — także na sucho', () async {
      final w = _World()..submit('a');
      expect(await w.cli(['scan', '--push']), 0);
      w.submit('b', title: 'Barka', lyrics: _barka);
      expect(await w.cli(['scan', '--push']), 1);
      expect(await w.cli(['scan']), 1);
      expect(w.labels('b'), isEmpty);
    });

    test('przebieg otwarty gdzie indziej (werdykt w Gmailu, bez katalogu) też blokuje', () async {
      final w = _World()..submit('a');
      w.mailbox.add(FakeMail('x', 'x', labels: {SongLabel.auto.label, SongLabel.readyToAdd.label}));
      expect(await w.cli(['scan', '--push']), 1);
      expect(w.run.exists, isFalse);
    });

    test('pusta kolejka nie otwiera przebiegu', () async {
      final w = _World();
      expect(await w.cli(['scan', '--push']), 0);
      expect(w.run.exists, isFalse);
    });

    test('przerwany scan --push dokańcza się kolejnym', () async {
      final w = _World()
        ..submit('a')
        ..submitOld('o');
      expect(await w.cli(['scan', '--push']), 0);
      // Wywrotka po zapisaniu katalogu, przed etykietami i szkicami.
      final plan = w.run.readRunPlan();
      writePlan(w.run.plan, RunPlan(
        id: plan.id,
        createdAt: plan.createdAt,
        labelsByMessage: plan.labelsByMessage,
        songByThread: plan.songByThread,
        messagesByThread: plan.messagesByThread,
        senderByThread: plan.senderByThread,
      ));
      for (final m in w.mailbox.mails) {
        m.labels.clear();
      }
      w.mailbox.drafts.clear();
      expect(await w.cli(['review']), 1, reason: 'przebieg nie jest jeszcze w Gmailu');

      expect(await w.cli(['scan', '--push']), 0);
      expect(w.run.readRunPlan().pushedAt, isNotNull);
      expect(w.labels('a'), contains(SongLabel.readyToAdd.label));
      expect(carriesOldAppBlock(w.draftIn('o')!), isTrue);
    });

    test('zgłoszenia ze strony na czele kolejki nie zjadają -n', () async {
      final w = _World();
      for (var i = 0; i < 3; i++) {
        w.mailbox.add(FakeMail('w$i', 'w$i',
            raw: submissionEmail(
              origin: SubmissionOrigin.web,
              song: sampleSong(title: 'Ze strony $i', lyrics: 'Tekst ze strony numer $i\nI druga linijka'),
            ).eml));
      }
      w
        ..submit('a0', title: 'Z apki 0', lyrics: 'Tekst z apki numer 0\nI druga linijka')
        ..submit('a1', title: 'Z apki 1', lyrics: 'Tekst z apki numer 1\nI druga linijka');
      expect(await w.cli(['scan', '-n', '2', '--push']), 0);
      expect(w.run.readRunPlan().labelsByMessage.keys, unorderedEquals(['a0', 'a1']),
          reason: '-n 2 to dwa zgłoszenia z apki, nie dwa ze strony');
    });
  });

  group('review --push', () {
    test('etykiety, final-*, people.dart i szkic z tekstem do autora', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Dodałem, popraw literówkę.'));
      expect(await w.cli(['review', '--push']), 0);
      expect(w.labels('a'), containsAll([SongLabel.readyToAdd.label, SongLabel.replyReviewNote.label]));
      expect(readHrcpsng(w.run.finalSongs(_new)).single.piosenkomatData, isNull);
      expect(File(w.run.people).existsSync(), isTrue);
      expect(w.draftIn('a'), contains('Dodałem, popraw literówkę.'));
    });

    test('na sucho niczego nie zapisuje', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Popraw literówkę.'));
      expect(await w.cli(['review']), 0);
      expect(File(w.run.finalSongs(_new)).existsSync(), isFalse);
      expect(w.labels('a'), isNot(contains(SongLabel.replyReviewNote.label)));
      expect(w.draftIn('a'), isNull);
    });

    test('powtórny review nie nadpisuje szkicu poprawionego w Gmailu', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(accepted: false, note: 'Dorzuć chwyty.'));
      await w.cli(['review', '--push', '--force']);
      final id = w.mailbox.drafts.keys.single;
      final edited = w.draftIn('a')!.replaceFirst('Dorzuć chwyty.', 'Dorzuć chwyty w refrenie.');
      w.mailbox.drafts[id] = (threadId: 'a', body: edited);

      w.export(_new, _verdict(accepted: false, note: 'Inny tekst z przeglądu.'));
      expect(await w.cli(['review', '--push', '--force']), 0);
      expect(w.draftIn('a'), edited);
    });

    test('tekst z przeglądu w wątku ze starej apki wchłania szkic z samym blokiem', () async {
      final w = _World()
        ..submitOld('o1', title: 'Pierwsza stara', lyrics: _barka)
        ..submitOld('o2', title: 'Druga stara', lyrics: _ognisko);
      await w.cli(['scan', '--push']);
      expect(w.mailbox.drafts.values.map((d) => d.threadId), ['o2'], reason: 'blok raz, w najnowszym wątku');

      w.export(_new, (song) {
        if (song.title == 'Pierwsza stara') _verdict(note: 'Dodałem, dzięki!')(song);
      });
      expect(await w.cli(['review', '--push']), 0);
      expect(w.mailbox.drafts.values.map((d) => d.threadId), ['o1'],
          reason: 'mejl z tekstem niesie blok, więc sam blok już niepotrzebny');
      expect(w.draftIn('o1'), contains('Dodałem, dzięki!'));
      expect(carriesOldAppBlock(w.draftIn('o1')!), isTrue);
    });

    test('zmiana zdania „nie” → „tak” → „nie” przestawia etykiety', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(accepted: false));
      expect(await w.cli(['review', '--push', '--force']), 0);
      expect(w.labels('a'), contains(SongLabel.rejectedAfterReview.label));

      w.export(_new);
      expect(await w.cli(['review', '--push']), 0);
      expect(w.labels('a'), contains(SongLabel.readyToAdd.label));
      expect(w.labels('a'), isNot(contains(SongLabel.rejectedAfterReview.label)));

      w.export(_new, _verdict(accepted: false));
      expect(await w.cli(['review', '--push', '--force']), 0);
      expect(w.labels('a'), contains(SongLabel.rejectedAfterReview.label));
      expect(w.labels('a'), isNot(contains(SongLabel.readyToAdd.label)));
    });

    test('tekst do autora idzie raz, choćby review odpalić drugi raz', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Popraw literówkę w drugiej zwrotce.'));
      await w.cli(['review', '--push']);
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, hasLength(1));
      expect(w.labels('a'), contains(SongLabel.waitingForAuthor.label));

      expect(await w.cli(['review', '--push']), 0);
      expect(w.labels('a'), isNot(contains(SongLabel.replyReviewNote.label)));
      expect(w.draftIn('a'), isNull);
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, hasLength(1), reason: 'drugiego takiego samego mejla nie ma');
    });

    test('tekst skasowany przed wysyłką schodzi z kolejki odpowiedzi', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Popraw literówkę.'));
      await w.cli(['review', '--push']);
      w.export(_new);
      expect(await w.cli(['review', '--push']), 0);
      expect(w.labels('a'), isNot(contains(SongLabel.replyReviewNote.label)));
      // Szkic ma Twój tekst — zostaje do skasowania ręcznie, ale bez etykiety
      // `reply --push` go nie wyśle.
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
    });

    test('zdublowana na stronie poprawka: STOP, żadnego final-*', () async {
      final w = _World(app: [sampleSong(id: 'o!_barka', title: 'Barka', lyrics: _barka)])
        ..submit('c', title: 'Barka', lyrics: '$_barka\nDopisana zwrotka na koniec', kind: _correction, target: 'o!_barka');
      await w.cli(['scan', '--push']);
      final songs = roundTrip(readHrcpsng(w.run.candidates(_correction)));
      // Dwie zachowane kopie jednej poprawki — strona dała drugiej inne id.
      writeHrcpsng(w.run.reviewed(_correction), roundTrip([...songs, ...songs]), withPiosenkomatData: true);
      expect(await w.cli(['review', '--push']), 1);
      expect(File(w.run.finalSongs(_correction)).existsSync(), isFalse);
    });
  });

  group('reviewDiff: kilka piosenek z jednego zgłoszenia', () {
    Future<(List<ReviewCandidate>, List<SongRaw>)> scanned() async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      final songs = readHrcpsng(w.run.candidates(_new));
      return (collectCandidates(w.run.readRunPlan(), songs, _new), songs);
    }

    test('kopie z różnym przełącznikiem → STOP, nie „pierwsza wygrywa”', () async {
      final (proposed, songs) = await scanned();
      final copies = roundTrip([...songs, ...songs]);
      copies.first.piosenkomatData = copies.first.piosenkomatData!.copyWith(accepted: () => false);
      final r = reviewDiff(kind: _new, candidates: proposed, reviewed: copies);
      expect(r.conflicts, hasLength(1));
      expect(r.mustStop, isTrue);
    });

    test('nowa rozbita na stronie na dwie wchodzi cała', () async {
      final (proposed, songs) = await scanned();
      final r = reviewDiff(kind: _new, candidates: proposed, reviewed: roundTrip([...songs, ...songs]));
      expect(r.mustStop, isFalse);
      expect(r.acceptedSongs, hasLength(2));
      expect(r.acceptedThreads, hasLength(1));
    });
  });

  group('finalize --push', () {
    test('zwykła kolejność: review → wklejenie → finalize, potem wolno scan', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      expect(await w.cli(['finalize', '--push']), 1, reason: 'bez przeglądu nie ma czego domykać');
      w.export(_new);
      await w.cli(['review', '--push']);
      expect(await w.cli(['finalize', '--push']), 1, reason: 'final-* nie jest jeszcze w all_songs');

      w.paste();
      final id = w.run.readRunPlan().id;
      expect(await w.cli(['finalize', '--push']), 0);
      expect(w.labels('a'), contains(SongLabel.added.label));
      expect(w.run.exists, isFalse);
      final archive = RunDir(p.join(w.root, 'archive', id));
      expect(File(archive.summary).readAsStringSync(), contains('Ognisko'));
      expect(File(archive.finalSongs(_new)).existsSync(), isTrue);

      w.submit('b', title: 'Barka', lyrics: _barka);
      expect(await w.cli(['scan', '--push']), 0, reason: 'przebieg domknięty, można kolejny');
    });

    test('staje, gdy coś czeka na przegląd', () async {
      final w = _World()..submit('a', youtube: false);
      await w.cli(['scan', '--push']);
      expect(w.labels('a'), contains(SongLabel.needsReview.label));
      expect(await w.cli(['finalize', '--push']), 1);
    });

    test('staje, gdy eksport zmienił się po review', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new);
      await w.cli(['review', '--push']);
      w.paste();
      w.export(_new, _verdict(accepted: false));
      expect(await w.cli(['finalize', '--push']), 1);
      expect(w.run.exists, isTrue);
    });

    test('--force domyka mimo piosenek, których nie widać w all_songs', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new);
      await w.cli(['review', '--push']);
      expect(await w.cli(['finalize', '--push', '--force']), 0);
      expect(w.run.exists, isFalse);
    });

    test('przebieg bez nic do przeglądu domyka się od razu', () async {
      final w = _World(app: [sampleSong(id: 'o!_ognisko', title: 'Ognisko', lyrics: _ognisko)])..submit('a');
      await w.cli(['scan', '--push']);
      expect(w.labels('a'), contains(SongLabel.rejectedAlreadyInApp.label));
      expect(w.run.kinds, isEmpty);
      expect(await w.cli(['finalize', '--push']), 0);
      expect(w.run.exists, isFalse);
    });
  });

  group('reply --push', () {
    test('wysyła szkic, a blok o starej apce zdejmuje kolejkę ze wszystkich wątków autora', () async {
      final w = _World();
      // Wątek autora z wcześniejszego przebiegu: blok czeka tam w szkicu.
      w.mailbox.add(FakeMail('prev', 'prev', from: _kasia, labels: {SongLabel.auto.label, SongLabel.replyOldApp.label}));
      w.mailbox.drafts['d-prev'] = (threadId: 'prev', body: composeContribReply(oldApp: true)!);
      w.submitOld('o');
      await w.cli(['scan', '--push']);
      expect(w.draftIn('o'), isNull, reason: 'blok raz na autora — czeka już w innym wątku');

      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts.map((s) => s.threadId), ['prev']);
      expect(w.labels('prev'), isNot(contains(SongLabel.replyOldApp.label)));
      expect(w.labels('o'), isNot(contains(SongLabel.replyOldApp.label)));
    });

    test('szkic bez tekstu w wątku, który na tekst czeka, nie wychodzi', () async {
      final w = _World();
      w.mailbox.add(FakeMail('t', 't', labels: {SongLabel.auto.label, SongLabel.replyReviewNote.label}));
      w.mailbox.drafts['d'] = (threadId: 't', body: composeContribReply(oldApp: true)!);
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
      expect(w.labels('t'), contains(SongLabel.replyReviewNote.label));
    });

    test('bez szkicu: odpisane ręcznie przestawia etykiety, inaczej czeka', () async {
      final w = _World();
      w.mailbox
        ..add(FakeMail('t1', 't1', labels: {SongLabel.replyReviewNote.label}))
        ..add(FakeMail('s1', 't1', from: kInboxEmail, sent: true))
        ..add(FakeMail('t2', 't2', labels: {SongLabel.replyReviewNote.label}));
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
      expect(w.labels('t1'), contains(SongLabel.waitingForAuthor.label));
      expect(w.labels('t2'), contains(SongLabel.replyReviewNote.label));
    });

    test('szkic z Twoją poprawką z Gmaila idzie taki, jaki jest', () async {
      final w = _World();
      w.mailbox.add(FakeMail('t', 't', labels: {SongLabel.replyReviewNote.label}));
      final edited = composeContribReply(reviewNote: 'Dorzuć chwyty, a piosenka wejdzie.')!;
      w.mailbox.drafts['d'] = (threadId: 't', body: edited);
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts.map((s) => s.text), [edited]);
      expect(w.labels('t'), contains(SongLabel.waitingForAuthor.label));
      expect(w.labels('t'), isNot(contains(SongLabel.replyReviewNote.label)));
    });

    test('niedokończony ręczny szkic nie wychodzi', () async {
      final w = _World();
      w.mailbox.add(FakeMail('t', 't', labels: {SongLabel.replyReviewNote.label}));
      w.mailbox.drafts['d'] = (threadId: 't', body: 'Cześć, a może');
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
      expect(w.mailbox.drafts, contains('d'));
    });

    test('blok wysłany ręcznie z Gmaila też zdejmuje kolejkę z reszty wątków autora', () async {
      final w = _World();
      w.mailbox
        ..add(FakeMail('k1', 'k1', from: _kasia, labels: {SongLabel.replyOldApp.label}))
        ..add(FakeMail('s1', 'k1', from: kInboxEmail, sent: true))
        ..add(FakeMail('k2', 'k2', from: _kasia, labels: {SongLabel.replyOldApp.label}));
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
      expect(w.labels('k1'), isNot(contains(SongLabel.replyOldApp.label)));
      expect(w.labels('k2'), isNot(contains(SongLabel.replyOldApp.label)));
    });

    test('tekst wycofany przy przeglądzie w wątku ze starej apki nie wychodzi', () async {
      final w = _World()..submitOld('o');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Dodałem, dzięki!'));
      await w.cli(['review', '--push']);
      expect(w.draftIn('o'), contains('Dodałem, dzięki!'), reason: 'szkic z samym blokiem przeliczony');
      w.export(_new);
      await w.cli(['review', '--push']);
      expect(w.draftIn('o'), contains('Dodałem, dzięki!'), reason: 'szkic z tekstem jest Twój');
      expect(await w.cli(['reply', '--push']), 0);
      expect(w.mailbox.sentTexts, isEmpty);
      expect(w.labels('o'), contains(SongLabel.replyOldApp.label));
    });

    test('-n ogranicza liczbę mejli', () async {
      final w = _World();
      for (final t in ['t1', 't2']) {
        w.mailbox.add(FakeMail(t, t, labels: {SongLabel.replyReviewNote.label}));
        w.mailbox.drafts['d$t'] = (threadId: t, body: composeContribReply(reviewNote: 'Super:)')!);
      }
      expect(await w.cli(['reply', '-n', '1', '--push']), 0);
      expect(w.mailbox.sentTexts, hasLength(1));
    });
  });

  group('unlabel --push cofa przebieg', () {
    test('etykiety, szkice i out/run znikają — mejle wracają do kolejki', () async {
      final w = _World()
        ..submit('a')
        ..submitOld('o');
      await w.cli(['scan', '--push']);
      expect(await w.cli(['unlabel', '--push']), 0);
      expect(w.labels('a'), isEmpty);
      expect(w.labels('o'), isEmpty);
      expect(w.mailbox.drafts, isEmpty);
      expect(w.run.exists, isFalse);
      expect(await w.cli(['scan', '--push']), 0, reason: 'nic nie jest już otwarte');
    });

    test('szkic z tekstem do autora zostaje — to już Twoje', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new, _verdict(note: 'Popraw literówkę.'));
      await w.cli(['review', '--push']);
      expect(await w.cli(['unlabel', '--push', '--force']), 0);
      expect(w.labels('a'), isEmpty);
      expect(w.draftIn('a'), contains('Popraw literówkę.'));
    });

    test('bez out/run/ cofa przebieg otwarty gdzie indziej — tylko jego wątki', () async {
      final w = _World()..submit('a');
      w.mailbox
        ..add(FakeMail('x1', 'x', labels: {SongLabel.auto.label, SongLabel.needsReview.label}))
        ..add(FakeMail('x2', 'x', labels: {SongLabel.auto.label, SongLabel.replyOldApp.label}))
        ..add(FakeMail('z', 'z', labels: {SongLabel.auto.label, SongLabel.rejectedAlreadyInApp.label}));
      expect(await w.cli(['scan', '--push']), 1);
      expect(await w.cli(['unlabel', '--push']), 0);
      expect(w.labels('x1'), isEmpty);
      expect(w.labels('x2'), isEmpty, reason: 'cały wątek z otwartym werdyktem');
      expect(w.labels('z'), contains(SongLabel.rejectedAlreadyInApp.label), reason: 'domknięte zostają');
      expect(await w.cli(['scan', '--push']), 0);
    });

    test('nic nie jest otwarte — nic do cofnięcia', () async {
      final w = _World();
      w.mailbox.add(FakeMail('z', 'z', labels: {SongLabel.auto.label, SongLabel.rejectedAlreadyInApp.label}));
      expect(await w.cli(['unlabel', '--push']), 0);
      expect(w.labels('z'), contains(SongLabel.auto.label));
    });

    test('robota z przeglądu nie przepada bez --force', () async {
      final w = _World()..submit('a');
      await w.cli(['scan', '--push']);
      w.export(_new);
      expect(await w.cli(['unlabel', '--push']), 1);
      expect(w.run.exists, isTrue);
      expect(await w.cli(['unlabel', '--push', '--force']), 0);
      expect(w.run.exists, isFalse);
    });
  });

  group('reopen', () {
    _World waiting({bool authorReplied = true, SongLabel? state}) => _World()
      ..mailbox.add(FakeMail('m1', 't1', labels: {
        SongLabel.auto.label,
        SongLabel.waitingForAuthor.label,
        if (state != null) state.label,
      }))
      ..mailbox.add(FakeMail('s1', 't1', from: kInboxEmail, sent: true))
      ..mailbox.add(authorReplied ? FakeMail('m2', 't1', body: 'Chwyty: a d e') : FakeMail('s2', 't1', sent: true));

    test('autor odpisał → z --push wątek wraca do kolejki bez żadnej song/*', () async {
      final w = waiting();
      expect(await w.cli(['reopen', '--push']), 0);
      expect(w.mailbox.mails.expand((m) => m.labels).where(isSongLabel), isEmpty);
    });

    test('bez --push nic się nie zmienia', () async {
      final w = waiting();
      expect(await w.cli(['reopen']), 0);
      expect(w.labels('m1'), contains(SongLabel.waitingForAuthor.label));
    });

    test('ostatnie słowo nasze → czeka dalej', () async {
      final w = waiting(authorReplied: false);
      await w.cli(['reopen', '--push']);
      expect(w.labels('m1'), contains(SongLabel.waitingForAuthor.label));
    });

    test('piosenka w pliku albo w apce → odpowiedź to nie nowe zgłoszenie', () async {
      for (final state in [SongLabel.added, SongLabel.readyToAdd]) {
        final w = waiting(state: state);
        await w.cli(['reopen', '--push']);
        expect(w.labels('m1'), contains(state.label));
      }
    });
  });

  test('explain odsiewa to samo, co scan — zgłoszenie ze strony nie udaje zgłoszenia', () async {
    final w = _World();
    final eml = p.join(w.root, 'web.eml');
    File(eml).writeAsStringSync(submissionEmail(origin: SubmissionOrigin.web).eml);
    final out = _Capture();
    final code = await IOOverrides.runZoned(
      () => runPiosenkomat(['explain', eml, '--songs-db', w.db]),
      stdout: () => out,
    );
    expect(code, 0);
    expect(out.text, contains('web.eml: zgłoszenie ze strony — scan go nie weźmie.'));
    expect(out.text, isNot(contains('NOWA')), reason: 'bez raportu, jakby weszło do przebiegu');
  });

  test('zbędny argument i nieznana komenda to błąd użycia', () async {
    final w = _World();
    expect(await w.cli(['scan', '20']), 64);
    expect(await runPiosenkomat(['nieznana']), 64);
    expect(await runPiosenkomat(['label', 'scanned']), 64, reason: 'stare komendy zniknęły');
  });

  test('status działa i przy otwartym, i bez przebiegu', () async {
    final w = _World()..submit('a');
    expect(await w.cli(['status']), 0);
    await w.cli(['scan', '--push']);
    expect(await w.cli(['status']), 0);
  });
}

/// Przechwycone `stdout` komendy.
class _Capture implements Stdout {
  final _buf = StringBuffer();
  String get text => _buf.toString();
  @override
  void write(Object? object) => _buf.write(object);
  @override
  void writeln([Object? object = '']) => _buf.writeln(object);
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
