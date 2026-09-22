import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Najstarsza apka: temat „Piosenka własna”, brak sekcji `### Kod piosenki:`,
/// JSON wklejony między znaczniki „nie edytuj”. Kształty zebrane z prawdziwej
/// skrzynki: treść łamana przez klienta pocztowego, cytowanie w odpowiedziach,
/// HTML w wątkach i `add_pers` raz napisem, raz listą.
const _songJson =
    r'{"title":"Testowa stara piosenka","hid_titles":[],"text_authors":["Autor Testowy"],'
    r'"composers":[],"performers":["Zespol Testowy"],"release_date":null,'
    r'"show_rel_date_month":true,"show_rel_date_day":true,'
    r'"yt_link":"https://youtu.be/dQw4w9WgXcQ","add_pers":"Jan Testowy","tags":[],'
    r'"refren":{"text":"Refren piosenki testowej","chords":"a d","shift":true},'
    r'"parts":[{"text":"Zwrotka pierwsza tej piosenki\nDruga linia zwrotki",'
    r'"chords":"a d\ne a","shift":false},{"refren":1}]}';

String _mejl(String json, {String powitanie = 'Dzięki za chęć dzielenia się swoimi piosenkami!'}) => '''
$powitanie

Pamiętaj, by podać swoje:
- imię: Jan

!!! NIE EDYTUJ PONIŻSZEGO TEKSTU !!!
$json
!!! NIE EDYTUJ POWYŻSZEGO TEKSTU !!!
''';

ContribMessage _wiadomosc(String body) => ContribMessage(
      id: 'stara1',
      body: body,
      subject: 'Piosenka własna',
      from: 'Jan Testowy <jan.testowy@example.com>',
      date: DateTime(2021, 5, 1),
    );

void main() {
  test('wchodzi do kolejki mimo braku „### Kod piosenki:”', () {
    expect(_wiadomosc(_mejl(_songJson)).isSongSubmission, isTrue);
    expect(kQueueQuery, contains(kOldAppMarker));
  });

  test('parsuje się i jest rozpoznana jako stara apka', () {
    final parsed = parseSubmission(_wiadomosc(_mejl(_songJson)));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(parsed.isOldestFormat, isTrue);
    expect(parsed.song.youtubeVideoId, 'dQw4w9WgXcQ');
  });

  test('treść połamana przez klienta pocztowego', () {
    final parsed = parseSubmission(_wiadomosc(hardWrap(_mejl(_songJson))));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(textWords(parsed.song.text), contains('zwrotki'));
  });

  test('nagłówek powitalny przełamany w środku', () {
    final parsed = parseSubmission(_wiadomosc(
        _mejl(_songJson, powitanie: 'Dzięki za chęć dzielenia się\nswoimi piosenkami!')));
    expect(parsed.isOldestFormat, isTrue);
  });

  test('odpowiedź w wątku: cytowanie na początku linii', () {
    final cytat = _mejl(_songJson)
        .split('\n')
        .map((l) => '> $l')
        .join('\n');
    final parsed = parseSubmission(_wiadomosc('Dzięki!\n\n$cytat'));
    expect(parsed.song.title, 'Testowa stara piosenka');
  });

  test('wątek odesłany jako HTML', () {
    final html = _mejl(_songJson.replaceAll(
            '"add_pers":"Jan Testowy"',
            '"add_pers":[{"name":"Jan Testowy","email_ref":'
                '"<a href="mailto:jan@example.com" target="_blank">jan@example.com</a>",'
                '"user_key_ref":""}]'))
        .split('\n')
        .join('<br>');
    final parsed = parseSubmission(_wiadomosc(html));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(parsed.song.contribRefs.map((c) => c.emailRef), contains('jan@example.com'));
  });

  test('nawiasy kątowe w tekście piosenki to nie HTML', () {
    final json = _songJson.replaceFirst(
        'Zwrotka pierwsza tej piosenki', 'Refren <powtórz 2x> i Zosia -> Kasia');
    final parsed = parseSubmission(_wiadomosc(_mejl(json)));
    expect(parsed.song.text, contains('Refren <powtórz 2x> i Zosia -> Kasia'));
  });

  test('marker przełamany przez klienta dalej robi ze zgłoszenia zgłoszenie', () {
    final body = _mejl(_songJson)
        .replaceFirst('NIE EDYTUJ PONIŻSZEGO TEKSTU', 'NIE EDYTUJ\nPONIŻSZEGO TEKSTU');
    final m = ContribMessage(id: 'x', body: body, subject: 'Re: cokolwiek');
    expect(m.isSongSubmission, isTrue,
        reason: 'parser to czyta, więc filtr przed nim nie może tego wyrzucić');
  });

  test('stary mejl zacytowany pod nowym zgłoszeniem nie robi z niego starej apki',
      () async {
    final nowy = await completeEmail(withConsent: false);
    final zCytatem = '$nowy\n\n> ${_mejl(_songJson).split('\n').join('\n> ')}';
    final got = classify(msgFrom(zCytatem), book: SongBook.empty);
    expect(got.submission.isOldApp, isFalse);
    expect(issuesOf(got), contains(SongIssue.noConsent),
        reason: 'brak zgody nie może przejść dzięki cudzemu cytatowi');
  });

  test('`add_pers` napisem zamiast listą nie wywala parsera', () {
    final parsed = parseSubmission(_wiadomosc(_mejl(_songJson)));
    expect(parsed.song.contribRefs.map((c) => c.person?.name), contains('Jan Testowy'));
  });

  test('klasyfikacja wiesza kolejkę odpowiedzi do starej apki', () {
    final c = classify(_wiadomosc(_mejl(_songJson)), book: SongBook.empty);
    expect(c.submission.isOldApp, isTrue);
    expect(c.submission.shape, EmailShape.oldest,
        reason: 'po rozkładzie kształtów poznasz, kiedy wolno skasować czytnik');
    expect(c.labels, contains(kLabelReplyOldApp));
  });

  test('komu już odpisano, ten nie wraca do kolejki odpowiedzi', () {
    // Wątek cofnięty przez `reopen`: etykiety zeszły, ale nasza odpowiedź
    // w wątku została — `scan` wie o niej z etykiety wątku `SENT`.
    final m = _wiadomosc(_mejl(_songJson));
    final c = classifyBatch([m], book: SongBook.empty, answeredThreads: {m.threadId}).single;
    expect(c.submission.isOldApp, isTrue);
    expect(c.submission.weReplied, isTrue);
    expect(c.labels, isNot(contains(kLabelReplyOldApp)),
        reason: 'drugi blok o starej apce nikomu nie jest potrzebny');
  });

  test('nasza wiadomość w wątku też znaczy „odpisano”', () {
    final ours = ContribMessage(
      id: 'nasza',
      threadId: 'stara1',
      body: 'Zaktualizuj apkę',
      from: 'HarcApp <$kInboxEmail>',
      date: DateTime(2021, 5, 2),
    );
    final c = classifyBatch([_wiadomosc(_mejl(_songJson)), ours], book: SongBook.empty).single;
    expect(c.submission.weReplied, isTrue);
    expect(c.labels, isNot(contains(kLabelReplyOldApp)));
  });

  test('kolejka wyklucza po każdej etykiecie song/*', () {
    expect(isSongLabel(kLabelDone), isTrue);
    expect(isSongLabel(kLabelReplyOldApp), isTrue);
    expect(isSongLabel(kLabelWaitingForAuthor), isTrue);
    expect(kQueueQuery, contains(labelQueryName(kLabelDone)));
    expect(kQueueQuery, contains(labelQueryName(kLabelReplyOldApp)));
  });
}
