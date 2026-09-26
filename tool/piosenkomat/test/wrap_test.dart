import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/similarity.dart';
import 'dart:convert';

import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  _correction();
  _oldest();
  test('złamane linie JSON-a: sklejenie spacją ratuje mejl', () async {
    final raw = hardWrap(await completeEmail());
    expect(raw, contains('\r\n'));
    final got = classify(msgFrom(raw), book: SongBook.empty);
    expect(got.isClean, isTrue);
    expect(got.song!.title, 'Piosenka testowa XYZ');
  });

  test('złamane id poprawianej piosenki: deklaracja nie ginie', () async {
    // Najdłuższe lclId w śpiewniku ma 95 znaków, a nagłówek zjada 25, więc
    // klient pocztowy łamie tę linię — i to w środku identyfikatora.
    const long =
        'o!_ballada_o_stefanie_mirowskim@21_druzyna_harcerska_im_hm_stefana_mirowskiego_blekitna_gwiazda';
    final raw = hardWrap(await completeEmail(isNew: false, correctionTarget: long));
    expect(raw, contains('Poprawiana piosenka'));
    expect(raw.split('\r\n').any((l) => l.contains(long)), isFalse,
        reason: 'linia z id ma być w tym teście naprawdę złamana');

    final got = classify(msgFrom(raw), book: SongBook.empty);
    expect(got.submission.declaredCorrectionTarget, long);
    expect(got.submission.correctionTargetGuessed, isFalse);
  });

  test('id w bloku ```: złamane i zacytowane linie sklejają się w całość', () {
    const long =
        'o!_ballada_o_stefanie_mirowskim@21_druzyna_harcerska_im_hm_stefana_mirowskiego_blekitna_gwiazda';
    const broken = 'o!_ballada_o_stefanie_mirowskim@21_druzyna_harcerska_im_hm_s\ntefana_mirowskiego_blekitna_gwiazda';
    expect(
      extractCorrectionTarget('### Poprawiana piosenka:\n\n```\n$broken\n```\n\n### Osoba dodająca:'),
      long,
    );
    expect(
      extractCorrectionTarget('> ### Poprawiana piosenka:\n>\n> ```\n> o!_ballada_o_stefanie_mirowskim@21_druzyna_harcerska_im_hm_s\n> tefana_mirowskiego_blekitna_gwiazda\n> ```\n>\n> ### Osoba dodająca:'),
      long,
    );
    // Podpis pod blokiem nie wchodzi do id.
    expect(
      extractCorrectionTarget('### Poprawiana piosenka:\n\n```\no!_barka\n```\nPozdrawiam\nJan'),
      'o!_barka',
    );
  });

  test('id bez bloku ``` to nie deklaracja', () {
    expect(extractCorrectionTarget('### Poprawiana piosenka: o!_barka\n\n### Osoba dodająca:'), isNull);
  });

  test('załącznik .hrcpsng wygrywa nad uszkodzoną treścią', () async {
    final good = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = good.song!;
    final attachment = jsonEncode({
      'official': {song.id: {'song': song.toApiJsonMap(withId: false), 'index': 0}},
      'conf': {},
    });

    final broken = (await completeEmail()).replaceFirst('"title":"Piosenka testowa XYZ"',
        '"title":"Pios\r\nenka testowa XYZ"');
    final eml = ContribMessage.fromEml(broken, id: 'x');
    final withAtt = ContribMessage(
      id: eml.id, body: eml.body, subject: eml.subject, from: eml.from,
      date: eml.date, songAttachment: attachment,
    );
    final got = classify(withAtt, book: SongBook.empty);
    expect(got.isClean, isTrue);
    expect(got.song!.title, 'Piosenka testowa XYZ');
    expect(got.song!.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
  });

  test('zbłąkana spacja w email_ref jest usuwana', () async {
    final raw = (await completeEmail()).replaceFirst('"add_pers":[]',
        '"add_pers":[{"person":null,"email_ref":"\r\njan.testowy@example.com","user_key_ref":null}]');
    final got = classify(msgFrom(raw), book: SongBook.empty);
    expect(got.isClean, isTrue);
    final refs = got.song!.contribRefs;
    expect(refs.where((c) => c.emailRef == 'jan.testowy@example.com'), hasLength(1));
  });
}

void _correction() {
  test('pusty blok „Propozycja poprawki” to nie poprawka', () async {
    final raw = (await completeEmail()).replaceFirst('### Kod piosenki:',
        '### Propozycja poprawki:\n\n```text\n\n```\n\n### Kod piosenki:');
    expect(classify(msgFrom(raw), book: SongBook.empty).submission.isCorrection, isFalse);
    final withText = raw.replaceFirst('```text\n\n```', '```text\nzła tonacja\n```');
    final got = classify(msgFrom(withText), book: SongBook.empty);
    expect(got.submission.isCorrection, isTrue);
    expect(got.submission.correctionMessage, 'zła tonacja');
    expect(got.destination, Destination.candidateCorrection);
  });
}

void _oldest() {
  test('najstarsza apka: goły JSON połamany, załącznik ratuje', () async {
    final good = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = good.song!;
    // Stara apka nie znała zgody na regulamin, więc i piosenka jej nie niesie.
    final songMap = song.toApiJsonMap(withId: false)..remove('contributor_data');
    final attachment = jsonEncode({'official': {song.id: {'song': songMap, 'index': 0}}, 'conf': {}});
    final wrapped = hardWrap(jsonEncode({song.id: songMap}), width: 60);
    final body = 'Dzięki za chęć dzielenia się swoimi piosenkami!\n'
        '!!! Nie edytuj poniższego tekstu !!!\n\n- - - - - - - - -\n\n'
        '### Osoba dodająca:\n\nconst Person JAN_TESTOWY = Person(\n  name: \'Jan Testowy\',\n  email: ["jan.testowy@example.com"]\n);\n\n'
        '### Kod piosenki:\n\n$wrapped\n';
    final m = ContribMessage(id: 'old', body: body, subject: 'Piosenka "Piosenka testowa XYZ"',
        from: 'Jan <jan.testowy@example.com>', songAttachment: attachment);
    final got = classify(m, book: SongBook.empty);
    // Stara apka wchodzi jak każda: jedyny zarzut to brak zgody, a jej temat
    // („Piosenka …”) nie jest tematem spoza szablonów.
    expect(issuesOf(got), [SongIssue.noConsent]);
    expect(got.oldApp, isTrue);
    expect(got.labels, contains(kLabelReplyOldApp));
    expect(got.song!.contributorData?.acceptedContributionRulesVersion,
        kNoConsentRulesVersion);
    expect(got.title, 'Piosenka testowa XYZ');
  });

  test('nowsza apka bez fence\'a: załącznik nie robi z mejla starego formatu', () async {
    final good = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = good.song!;
    final attachment = jsonEncode({
      'official': {song.id: {'song': song.toApiJsonMap(withId: false), 'index': 0}},
      'conf': {},
    });
    // Format pośredni: zgoda i temat jak dziś, ale JSON goły, bez ```.
    final raw = (await completeEmail())
        .replaceFirst('### Kod piosenki:\n\n```json\n', '### Kod piosenki:\n\n')
        .replaceFirst(RegExp(r'\n```\s*$'), '\n');
    final eml = msgFrom(hardWrap(raw));
    final m = ContribMessage(id: 'mid', body: eml.body, subject: eml.subject,
        from: eml.from, date: eml.date, songAttachment: attachment);
    final got = classify(m, book: SongBook.empty);
    expect(got.isClean, isTrue);
    expect(got.oldApp, isFalse);
    expect(got.submission.shape, EmailShape.legacy);
    expect(got.labels, isNot(contains(kLabelReplyOldApp)));
  });
}
