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
    expect(got.verdict, isA<Import>());
    expect((got.verdict as Import).song.title, 'Piosenka testowa XYZ');
  });

  test('załącznik .hrcpsng wygrywa nad uszkodzoną treścią', () async {
    final good = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = (good.verdict as Import).song;
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
    expect(got.verdict, isA<Import>());
    expect((got.verdict as Import).song.title, 'Piosenka testowa XYZ');
    expect((got.verdict as Import).song.contributorData!.acceptedContributionRulesVersion, 'v05.10.2025');
  });

  test('zbłąkana spacja w email_ref jest usuwana', () async {
    final raw = (await completeEmail()).replaceFirst('"add_pers":[]',
        '"add_pers":[{"person":null,"email_ref":"\r\njan.testowy@example.com","user_key_ref":null}]');
    final got = classify(msgFrom(raw), book: SongBook.empty);
    expect(got.verdict, isA<Import>());
    final refs = (got.verdict as Import).song.contribRefs;
    expect(refs.where((c) => c.emailRef == 'jan.testowy@example.com'), hasLength(1));
  });
}

void _correction() {
  test('pusty blok „Propozycja poprawki” to nie poprawka', () async {
    final raw = (await completeEmail()).replaceFirst('### Kod piosenki:',
        '### Propozycja poprawki:\n\n```text\n\n```\n\n### Kod piosenki:');
    expect(classify(msgFrom(raw), book: SongBook.empty).verdict, isA<Import>());
    final withText = raw.replaceFirst('```text\n\n```', '```text\nzła tonacja\n```');
    final got = classify(msgFrom(withText), book: SongBook.empty);
    expect((got.verdict as Manual).reasons, contains(SkipReason.correction));
  });
}

void _oldest() {
  test('najstarsza apka: goły JSON połamany, załącznik ratuje', () async {
    final good = classify(msgFrom(await completeEmail()), book: SongBook.empty);
    final song = (good.verdict as Import).song;
    final songMap = song.toApiJsonMap(withId: false);
    final attachment = jsonEncode({'official': {song.id: {'song': songMap, 'index': 0}}, 'conf': {}});
    final wrapped = hardWrap(jsonEncode({song.id: songMap}), width: 60);
    final body = 'Dzięki za chęć dzielenia się swoimi piosenkami!\n'
        '!!! Nie edytuj poniższego tekstu !!!\n\n- - - - - - - - -\n\n'
        '### Osoba dodająca:\n\nconst Person JAN_TESTOWY = Person(\n  name: \'Jan Testowy\',\n  email: ["jan.testowy@example.com"]\n);\n\n'
        '### Kod piosenki:\n\n$wrapped\n';
    final m = ContribMessage(id: 'old', body: body, subject: 'Piosenka "Piosenka testowa XYZ"',
        from: 'Jan <jan.testowy@example.com>', songAttachment: attachment);
    final got = classify(m, book: SongBook.empty);
    final reasons = (got.verdict as Manual).reasons;
    expect(reasons, isNot(contains(SkipReason.parseError)));
    expect(reasons, containsAll([SkipReason.oldestFormat, SkipReason.noConsent]));
    expect(got.title, 'Piosenka testowa XYZ');
  });
}
