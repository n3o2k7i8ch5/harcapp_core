import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

List<SkipReason> reasonsOf(Classified c) => (c.verdict as Manual).reasons;

void main() {
  _labels();
  _submission();
  test('kompletna nowa piosenka → import z zgodą, datą i nadawcą', () async {
    final got = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final v = got.verdict as Import;
    expect(v.sender, 'jan.testowy@example.com');
    expect(got.title, 'Piosenka testowa XYZ');
    expect(v.song.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
    expect(v.song.contributorData!.email, 'jan.testowy@example.com');
    expect(v.song.contributorData!.contributionDate,
        DateTime.parse('2026-09-06T12:00:00+02:00'));
    expect(v.song.id, startsWith('o!_'));
    expect(v.song.contribRefs.any((c) => c.emailRef == 'jan.testowy@example.com'), isTrue);
  });

  group('do ręcznej obsługi:', () {
    Future<void> expectManual(String raw, SkipReason reason,
        {SongBook? book}) async {
      final got = classify(msgFrom(raw), book: book ?? SongBook.empty);
      expect(got.verdict, isA<Manual>(), reason: raw.split('\n').first);
      expect(reasonsOf(got), contains(reason));
    }

    test('poprawka', () async =>
        expectManual(await completeEmail(isNew: false), SkipReason.correction));
    test('własna wiadomość', () async => expectManual(
        await completeEmail(userMessage: 'Czy możecie dodać transpozycję?'),
        SkipReason.hasUserMessage));
    test('brak YouTube', () async => expectManual(
        await completeEmail(song: sampleSong(yt: null)), SkipReason.missingYoutube));
    test('brak chwytów', () async => expectManual(
        await completeEmail(song: sampleSong(chords: false)), SkipReason.missingChords));
    test('brak zgody', () async => expectManual(
        await completeEmail(withConsent: false), SkipReason.noConsent));
    test('odpowiedź', () async =>
        expectManual(await completeEmail(reply: true), SkipReason.reply));
    test('nadawca = skrzynka HarcApp', () async => expectManual(
        await completeEmail(from: 'HarcApp <harcapp@gmail.com>'), SkipReason.noSender));
    test('tytuł już w śpiewniku', () async => expectManual(
        await completeEmail(),
        SkipReason.alreadyInBook,
        book: bookWith([sampleSong()])));
    test('temat bez „Nowa piosenka”', () {
      final got = classify(
        ContribMessage(id: 'x', body: 'Cześć, mam pytanie', subject: 'Cześć'),
        book: SongBook.empty,
      );
      expect(reasonsOf(got), contains(SkipReason.parseError));
      expect(got.title, 'Cześć');
    });
  });


  test('emailFromHeader', () {
    expect(emailFromHeader('Jan <Jan.K@Example.com>'), 'jan.k@example.com');
    expect(emailFromHeader('jan@example.com'), 'jan@example.com');
    expect(emailFromHeader('HarcApp'), isNull);
    expect(emailFromHeader(null), isNull);
  });

  test('fromEml: bez nagłówków całość jest treścią', () {
    final m = ContribMessage.fromEml('Ala ma kota\n\nDruga linia', id: 'x');
    expect(m.subject, isNull);
    expect(m.body, 'Ala ma kota\n\nDruga linia');
  });
}

void _labels() {
  test('stateLabelFor: odrzuca sam tylko przy jednoznacznych powodach', () {
    expect(stateLabelFor(const Manual([SkipReason.missingChords])), kLabelToReview);
    expect(stateLabelFor(const Manual([SkipReason.alreadyInBook])), kLabelRejectedInBook);
    expect(stateLabelFor(const Manual([SkipReason.alreadyInBook, SkipReason.missingChords])),
        kLabelToReview);
    expect(stateLabelFor(const Manual([SkipReason.alreadyInBook, SkipReason.correction])),
        kLabelToReview);
    expect(stateLabelFor(const Manual([SkipReason.hasUserMessage])), kLabelToReview);
    expect(kQueueQuery, contains('-label:song/needs-review/possible-duplicate'));
    expect(kQueueQuery, contains('-label:song/rejected/duplicate'));
  });

  test('query Gmaila: spacje na myślniki, wszystkie etykiety song/* wykluczone', () {
    expect(kQueueQuery, startsWith('in:inbox (subject:'));
    expect(kQueueQuery, contains(' -label:song/auto '));
    expect(kQueueQuery, contains('-label:song/ready-to-add'));
    expect(kQueueQuery, contains('-label:song/rejected/too-niche'));
    expect(kReadyByToolQuery, 'label:song/ready-to-add label:song/auto');
  });
}

void _submission() {
  test('isSongSubmission: po temacie albo znaczniku w treści', () {
    expect(const ContribMessage(id: 'a', body: 'x', subject: 'Nowa piosenka "Y"').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'b', body: 'bla\n### Kod piosenki:\n{}').isSongSubmission, isTrue);
    expect(const ContribMessage(id: 'c', body: 'x', subject: 'Re: grupa FB').isSongSubmission, isFalse);
    expect(kQueueQuery, contains('subject:"Nowa piosenka" OR subject:"Poprawka piosenki" OR "### Kod piosenki:"'));
  });
}
