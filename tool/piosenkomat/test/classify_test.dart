import 'dart:convert';

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/values/people/contributor_ref.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  _threads();

  test('kompletna nowa piosenka → kandydat bez zarzutu, ze zgodą, datą i nadawcą', () async {
    final got = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = got.song!;
    expect(got.target, Target.candidateNew);
    expect(got.issues, isEmpty);
    expect(got.submission.kind, SubmissionKind.newSong);
    expect(got.sender, 'jan.testowy@example.com');
    expect(got.title, 'Piosenka testowa XYZ');
    expect(song.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(song.contributorData!.email, 'jan.testowy@example.com');
    expect(song.contributorData!.contributionDate,
        DateTime.parse('2026-09-06T12:00:00+02:00'));
    expect(song.id, startsWith('o!_'));
    expect(song.contribRefs.any((c) => c.emailRef == 'jan.testowy@example.com'), isTrue);
    expect(song.contributorData!.emailThreadId, got.submission.threadId,
        reason: 'po tym przegląd wiąże piosenkę ze zgłoszeniem');
  });

  group('osoba dodająca w `add_pers`:', () {
    Person card(String name) => Person(name: name, druzyna: '88. DW „Wierchy”');

    test('karta bez adresu + nadawca → jedna osoba, nie karta i goły mejl', () async {
      // Tak wysyła apka: karta w `add_pers` bez adresu, adres osobno.
      final song = sampleSong()..contribRefs = [ContributorRef(person: card('Patrycja Dudzinska'))];
      final got = classify(msgFrom(await completeEmail(song: song)), book: SongBook.empty);
      final refs = got.song!.contribRefs;
      expect(refs, hasLength(1), reason: 'druga pozycja z samym mejlem to bug, który irytował przy przeglądzie');
      expect(refs.single.person?.name, 'Patrycja Dudzinska');
      expect(refs.single.emailRef, 'jan.testowy@example.com');
    });

    test('kilka kart bez adresu → nie zgadujemy, mejl osobno', () async {
      final song = sampleSong()..contribRefs = [
        ContributorRef(person: card('Jedna')),
        ContributorRef(person: card('Druga')),
      ];
      final got = classify(msgFrom(await completeEmail(song: song)), book: SongBook.empty);
      final refs = got.song!.contribRefs;
      expect(refs, hasLength(3));
      expect(refs.where((c) => c.emailRef == 'jan.testowy@example.com'), hasLength(1));
      expect(refs.take(2).every((c) => c.emailRef == null), isTrue, reason: 'żadna karta nie dostaje adresu na chybił trafił');
    });

    test('karta już z tym adresem → nic nie dokładamy', () async {
      final song = sampleSong()..contribRefs = [
        ContributorRef(person: card('Jan'), emailRef: 'jan.testowy@example.com'),
      ];
      final got = classify(msgFrom(await completeEmail(song: song)), book: SongBook.empty);
      expect(got.song!.contribRefs, hasLength(1));
    });
  });

  group('cechy → uwagi:', () {
    Future<Classified> run(String raw, {SongBook? book}) async =>
        classify(msgFrom(raw), book: book ?? SongBook.empty);

    test('własna wiadomość', () async {
      final got = await run(await completeEmail(userMessage: 'Czy możecie dodać transpozycję?'));
      expect(issuesOf(got), [SongIssue.hasUserMessage]);
      expect(got.submission.userMessage, 'Czy możecie dodać transpozycję?');
    });
    test('brak YouTube', () async {
      final got = await run(await completeEmail(song: sampleSong(yt: null)));
      expect(issuesOf(got), [SongIssue.missingYoutube]);
    });
    test('brak chwytów', () async {
      final got = await run(await completeEmail(song: sampleSong(chords: false)));
      expect(issuesOf(got), contains(SongIssue.missingChords));
    });
    test('brak zgody', () async {
      final got = await run(await completeEmail(withConsent: false));
      expect(issuesOf(got), [SongIssue.noConsent]);
      expect(got.submission.consentVersion, isNull);
    });
    test('nadawca = skrzynka HarcApp', () async {
      final got = await run(await completeEmail(from: 'HarcApp <harcapp@gmail.com>'));
      expect(issuesOf(got), [SongIssue.noContributorEmail]);
    });
    test('odpowiedź w wątku nie jest zarzutem', () async {
      final got = await run(await completeEmail(reply: true));
      expect(got.issues, isEmpty);
      expect(got.target, Target.candidateNew);
    });
    test('nie da się sparsować → unparsable, sam mejl', () {
      final got = classify(
        ContribMessage(id: 'x', body: 'Cześć, mam pytanie', subject: 'Cześć'),
        book: SongBook.empty,
      );
      expect(got.target, Target.unparsable);
      expect(got.song, isNull);
      expect(got.title, 'Cześć');
      expect(got.labels, [kLabelUnparsable]);
    });
  });

  group('poprawka:', () {
    test('kind z tematu albo bloku, bez missing-*', () async {
      final got = classify(
        msgFrom(await completeEmail(isNew: false, song: sampleSong(yt: null))),
        book: bookWith([sampleSong(lyrics: 'Ala ma kota a kot ma ale\nW lesie gra muzyka i cos jeszcze')]),
      );
      expect(got.submission.kind, SubmissionKind.correction);
      expect(got.submission.correctionMessage, 'poprawka chwytu w refrenie');
      expect(got.target, Target.candidateCorrection);
      expect(issuesOf(got), isNot(contains(SongIssue.missingYoutube)),
          reason: 'poprawka to diff, nie pełna piosenka');
      expect(got.submission.correctionTarget, 'tmp',
          reason: 'bez deklaracji wolno zgadnąć po tytule i tekście');
      expect(got.submission.correctionTargetGuessed, isTrue);
      expect(issuesOf(got), contains(SongIssue.guessedCorrectionTarget),
          reason: 'domysł nigdy nie udaje danych ze zgłoszenia');
      // Ślad w piosence też musi to nieść — po nim pozna edytor i `prepare`.
      final data = PiosenkomatData.fromJsonMap(
          got.piosenkomatData().toJsonMap());
      expect(data.correctionTarget, 'tmp');
      expect(data.correctionTargetGuessed, isTrue);
      expect(got.labels, contains(kLabelCorrection));
    });
    test('ten sam tytuł, zupełnie inna piosenka → nie zgadujemy', () async {
      // Podmiana idzie po id, a zgłoszenie bez decyzji wchodzi: słaby domysł
      // skasowałby cudzą piosenkę.
      final got = classify(
        msgFrom(await completeEmail(
            isNew: false,
            song: sampleSong(title: 'Barka', lyrics: 'Pan kiedyś stanął nad brzegiem'))),
        book: bookWith([
          sampleSong(title: 'Barka', lyrics: 'Zupełnie co innego o tym samym tytule')
        ]),
      );
      expect(got.submission.correctionTarget, isNull);
      expect(got.submission.correctionTargetGuessed, isFalse);
      expect(issuesOf(got), contains(SongIssue.noTargetInApp));
      expect(issuesOf(got), isNot(contains(SongIssue.guessedCorrectionTarget)));
    });

    test('bez deklaracji, zmieniony tytuł, ten sam tekst → cel zgadnięty', () async {
      // Poprawka może zmieniać tytuł; identyczny tekst to ta sama piosenka.
      final wApce = sampleSong(title: 'Stary tytuł');
      wApce.id = 'o!_stary';
      final got = classify(
        msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'Nowy tytuł'))),
        book: bookWith([wApce]),
      );
      expect(got.submission.correctionTarget, 'o!_stary');
      expect(got.submission.correctionTargetGuessed, isTrue);
      expect(issuesOf(got), contains(SongIssue.guessedCorrectionTarget));
      expect(issuesOf(got), isNot(contains(SongIssue.noTargetInApp)));
    });

    test('linia z celem zginęła — id z JSON-a piosenki ratuje deklarację', () async {
      // Apka niesie `corrected_song_id` w dwóch miejscach: w linii nagłówka
      // i w samej piosence. Nagłówek bywa złamany albo zacytowany.
      final song = sampleSong()..correctedSongId = 'tmp';
      final raw = await completeEmail(isNew: false, song: song);
      expect(raw, isNot(contains('Poprawiana piosenka')));
      final got = classify(msgFrom(raw),
          book: bookWith([sampleSong(lyrics: 'Zupełnie co innego')]));
      expect(got.submission.declaredCorrectionTarget, 'tmp');
      expect(got.submission.correctionTarget, 'tmp');
      expect(got.submission.correctionTargetGuessed, isFalse);
    });

    test('bez deklaracji i bez czego zgadnąć → no-target-in-app', () async {
      final got = classify(msgFrom(await completeEmail(isNew: false)), book: SongBook.empty);
      expect(issuesOf(got), [SongIssue.noTargetInApp]);
      expect(got.submission.correctionTarget, isNull);
    });
    test('apka wskazała poprawianą piosenkę → cel z mejla, nie z domysłu', () async {
      // W apce dwie piosenki o tym samym tytule; domysł wskazałby tę bliższą
      // tekstem, deklaracja wskazuje tę właściwą.
      final mylona = sampleSong(lyrics: 'Ala ma kota a kot ma ale\nW lesie gra muzyka');
      mylona.id = 'o!_blisko';
      final wlasciwa = sampleSong(lyrics: 'Zupelnie inny tekst o morzu i zaglach');
      wlasciwa.id = 'o!_wskazana';
      final got = classify(
        msgFrom(await completeEmail(isNew: false, correctedSongId: 'o!_wskazana')),
        book: bookWith([mylona, wlasciwa]),
      );
      expect(got.submission.declaredCorrectionTarget, 'o!_wskazana');
      expect(got.submission.correctionTarget, 'o!_wskazana');
      expect(got.submission.correctionTargetGuessed, isFalse);
      expect(issuesOf(got), isNot(contains(SongIssue.guessedCorrectionTarget)));
      expect(got.submission.appMatch?.songId, 'o!_wskazana',
          reason: 'porównujemy z pierwowzorem wskazanym przez apkę');
      expect(issuesOf(got), isNot(contains(SongIssue.noTargetInApp)));
    });
    test('apka wskazała piosenkę, której nie ma w śpiewniku → no-target-in-app', () async {
      final got = classify(
        msgFrom(await completeEmail(isNew: false, correctedSongId: 'o!_nie_ma_takiej')),
        book: bookWith([sampleSong(lyrics: 'Ala ma kota a kot ma ale\nW lesie gra muzyka i cos jeszcze')]),
      );
      expect(issuesOf(got), contains(SongIssue.noTargetInApp));
      expect(got.target, Target.candidateCorrection);
      // Nieistniejące id to brak celu: `prepare` nie może kazać podmieniać
      // piosenki, której nie ma, i to bez ostrzeżenia.
      expect(got.submission.correctionTarget, isNull);
      expect(got.submission.correctionTargetGuessed, isFalse);
    });
    test('nowa piosenka nie niesie deklaracji celu', () async {
      final got = classify(msgFrom(await completeEmail(correctedSongId: 'o!_cokolwiek')),
          book: SongBook.empty);
      expect(got.submission.declaredCorrectionTarget, isNull);
      expect(got.submission.correctionTarget, isNull);
    });
    test('przerobiona cudza piosenka wysłana jako nowa: JSON-owe id to nie deklaracja', () async {
      // Piosenka własna pamięta pierwowzór w `corrected_song_id`; wysłana jako
      // nowa ma być sprawdzona jak nowa — z najbliższą, nie z pierwowzorem.
      final pierwowzor = sampleSong(title: 'Pierwowzór', lyrics: 'Zupełnie inny tekst o górach');
      pierwowzor.id = 'o!_pierwowzor';
      final wApce = sampleSong();
      wApce.id = 'o!_juz_jest';
      final song = sampleSong()..correctedSongId = 'o!_pierwowzor';
      final got = classify(msgFrom(await completeEmail(song: song)),
          book: bookWith([pierwowzor, wApce]));
      expect(got.submission.declaredCorrectionTarget, isNull);
      expect(got.submission.appMatch?.songId, 'o!_juz_jest');
      expect(got.target, Target.rejectAlreadyInApp);
    });
    test('identyczna z apką → sam mejl, nie do pliku', () async {
      final got = classify(msgFrom(await completeEmail(isNew: false)),
          book: bookWith([sampleSong()]));
      expect(got.target, Target.mailOnlyIdentical);
      expect(got.labels, containsAll([kLabelToReview, ReviewKind.identicalInApp.label, kLabelCorrection]));
    });
  });

  test('stara apka: kandydat plus kolejka odpowiedzi, sentinel zgody', () async {
    final oldApp = ContribMessage(
      id: 'old',
      subject: 'Piosenka "Piosenka testowa XYZ"',
      from: 'Jan <jan.testowy@example.com>',
      body: 'Dzięki za chęć dzielenia się swoimi piosenkami!\n\n'
          '### Kod piosenki:\n\n'
          '${jsonEncode({'o!_x': sampleSong().toApiJsonMap(withId: false)})}\n',
    );
    final got = classify(oldApp, book: SongBook.empty);
    expect(got.isClean, isTrue, reason: 'stary format sam w sobie nie blokuje');
    expect(got.submission.legacyApp, isTrue);
    expect(got.submission.consentVersion, kOldAppRulesVersion);
    expect(got.labels, [kLabelReady, kLabelOldAppToReply]);
    expect(got.song!.piosenkomatData!.isOldApp, isTrue);
    expect(got.issues, isEmpty, reason: 'stara apka to wiedza o nadawcy, nie zarzut');
  });

  test('emailFromHeader', () {
    expect(emailFromHeader('Jan <Jan.K@Example.com>'), 'jan.k@example.com');
    expect(emailFromHeader('jan@example.com'), 'jan@example.com');
    expect(emailFromHeader('HarcApp'), isNull);
    expect(emailFromHeader(null), isNull);
  });
}

void _threads() {
  group('wątek = zgłoszenie:', () {
    test('odpowiedź z cytatem to dopisek, nie nowe zgłoszenie', () async {
      final original = msgFrom(await completeEmail(), id: 'm1');
      final replyBody = 'Zapomniałem dodać: refren dwa razy.\n\n'
          '${original.body.split('\n').map((l) => '> $l').join('\n')}';
      final reply = ContribMessage(
        id: 'm2', threadId: 'm1', body: replyBody,
        subject: 'Re: Nowa piosenka', from: original.from,
        date: DateTime.parse('2026-09-07T10:00:00+02:00'),
      );
      final out = classifyBatch([original, reply], book: SongBook.empty);
      expect(out, hasLength(1));
      final c = out.single;
      expect(c.message.id, 'm1', reason: 'cytat nie jest własnym kodem');
      expect(c.submission.messages.map((m) => m.id), ['m1', 'm2']);
      expect(c.submission.userMessage, contains('refren dwa razy'));
      expect(issuesOf(c), [SongIssue.hasUserMessage]);
    });

    test('poprawiona wersja odesłana w wątku wygrywa', () async {
      final original = msgFrom(await completeEmail(song: sampleSong(yt: null)), id: 'm1');
      final fixedRaw = await completeEmail(); // z YouTube'em
      final fixed = ContribMessage(
        id: 'm2', threadId: 'm1', body: msgFrom(fixedRaw).body,
        subject: 'Re: Nowa piosenka', from: original.from,
        date: DateTime.parse('2026-09-07T10:00:00+02:00'),
      );
      final out = classifyBatch([original, fixed], book: SongBook.empty);
      expect(out.single.message.id, 'm2');
      expect(out.single.issues, isEmpty, reason: 'najnowsza z własnym kodem ma YouTube');
      expect(out.single.submission.sentAt, fixed.date);
    });

    test('odpowiedź ze skrzynki HarcApp nie zostaje reprezentantem', () async {
      final original = msgFrom(await completeEmail(), id: 'm1');
      final mine = ContribMessage(
        id: 'm2', threadId: 'm1', body: original.body,
        subject: 'Re: Nowa piosenka', from: 'HarcApp <harcapp@gmail.com>',
        date: DateTime.parse('2026-09-07T10:00:00+02:00'),
      );
      final out = classifyBatch([original, mine], book: SongBook.empty);
      expect(out.single.message.id, 'm1');
      expect(out.single.sender, 'jan.testowy@example.com');
    });

    test('etykiety idą na wszystkie wiadomości wątku', () async {
      final original = msgFrom(await completeEmail(), id: 'm1');
      final reply = ContribMessage(
          id: 'm2', threadId: 'm1', body: 'ok', subject: 'Re', from: original.from);
      final items = classifyBatch([original, reply], book: SongBook.empty);
      expect(items.single.submission.messages, hasLength(2));
    });
  });
}
