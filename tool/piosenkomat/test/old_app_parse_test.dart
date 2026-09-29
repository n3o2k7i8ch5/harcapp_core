import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/values/strings.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

import 'helpers.dart';

/// Najstarsza apka: temat „Piosenka własna”, brak sekcji `### Kod piosenki:`,
/// JSON wklejony między znaczniki „nie edytuj”. Kształty zebrane z prawdziwej
/// skrzynki: treść łamana przez klienta pocztowego, cytowanie w odpowiedziach,
/// HTML w wątkach i `add_pers` raz napisem, raz listą.
final _songJson = oldAppSongJson(refren: 'Refren piosenki testowej');

ContribMessage _wiadomosc(String body) => ContribMessage(
      id: 'stara1',
      body: body,
      subject: 'Piosenka własna',
      from: 'Jan Testowy <jan.testowy@example.com>',
      date: DateTime(2021, 5, 1),
    );

/// Nasza odpowiedź w wątku [_wiadomosc] — `scan` dociąga ją z wysłanych.
ContribMessage _nasza(String body) => ContribMessage(
      id: 'nasza',
      threadId: 'stara1',
      body: body,
      from: 'HarcApp <$kHarcappEmail>',
      date: DateTime(2021, 5, 2),
    );

void main() {
  test('wchodzi do kolejki mimo braku „### Kod piosenki:”', () {
    expect(_wiadomosc(oldAppBody(json: _songJson)).isSongSubmission, isTrue);
    expect(kQueueQuery, contains(kOldAppMarker));
  });

  test('parsuje się i jest rozpoznana jako stara apka', () {
    final parsed = parseEmailBody(_wiadomosc(oldAppBody(json: _songJson)));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(parsed.shape, ContribEmailShape.oldApp);
    expect(parsed.song.youtubeVideoId, 'dQw4w9WgXcQ');
  });

  test('treść połamana przez klienta pocztowego', () {
    final parsed = parseEmailBody(_wiadomosc(hardWrap(oldAppBody(json: _songJson))));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(textWords(parsed.song.text), contains('zwrotki'));
  });

  test('nagłówek powitalny przełamany w środku', () {
    final parsed = parseEmailBody(_wiadomosc(
        oldAppBody(greeting: 'Dzięki za chęć dzielenia się\nswoimi piosenkami!')));
    expect(parsed.shape, ContribEmailShape.oldApp);
  });

  test('odpowiedź w wątku: cytowanie na początku linii', () {
    final cytat = oldAppBody(json: _songJson)
        .split('\n')
        .map((l) => '> $l')
        .join('\n');
    final parsed = parseEmailBody(_wiadomosc('Dzięki!\n\n$cytat'));
    expect(parsed.song.title, 'Testowa stara piosenka');
  });

  test('wątek odesłany jako HTML', () {
    final html = oldAppBody(json: _songJson.replaceAll(
            '"add_pers":"Jan Testowy"',
            '"add_pers":[{"name":"Jan Testowy","email_ref":'
                '"<a href="mailto:jan@example.com" target="_blank">jan@example.com</a>",'
                '"user_key_ref":""}]'))
        .split('\n')
        .join('<br>');
    final parsed = parseEmailBody(_wiadomosc(html));
    expect(parsed.song.title, 'Testowa stara piosenka');
    expect(parsed.song.contribRefs.map((c) => c.emailRef), contains('jan@example.com'));
  });

  test('nawiasy kątowe w tekście piosenki to nie HTML', () {
    final json = oldAppSongJson(lyrics: 'Refren <powtórz 2x> i Zosia -> Kasia');
    final parsed = parseEmailBody(_wiadomosc(oldAppBody(json: json)));
    expect(parsed.song.text, contains('Refren <powtórz 2x> i Zosia -> Kasia'));
  });

  test('marker przełamany przez klienta dalej robi ze zgłoszenia zgłoszenie', () {
    final body = oldAppBody(json: _songJson)
        .replaceFirst('NIE EDYTUJ PONIŻSZEGO TEKSTU', 'NIE EDYTUJ\nPONIŻSZEGO TEKSTU');
    final m = ContribMessage(id: 'x', body: body, subject: 'Re: cokolwiek');
    expect(m.isSongSubmission, isTrue,
        reason: 'parser to czyta, więc filtr przed nim nie może tego wyrzucić');
  });

  test('stary mejl zacytowany pod nowym zgłoszeniem nie robi z niego starej apki',
      () async {
    final nowy = await completeEmail(withConsent: false);
    final zCytatem = '$nowy\n\n> ${oldAppBody(json: _songJson).split('\n').join('\n> ')}';
    final got = classify(msgFrom(zCytatem), book: SongBook.empty);
    expect(got.submission.isOldApp, isFalse);
    expect(issuesOf(got), contains(SongIssue.noConsent),
        reason: 'brak zgody nie może przejść dzięki cudzemu cytatowi');
  });

  test('`add_pers` napisem zamiast listą nie wywala parsera', () {
    final parsed = parseEmailBody(_wiadomosc(oldAppBody(json: _songJson)));
    expect(parsed.song.contribRefs.map((c) => c.person?.name), contains('Jan Testowy'));
  });

  test('klasyfikacja wiesza kolejkę odpowiedzi do starej apki', () {
    final c = classify(_wiadomosc(oldAppBody(json: _songJson)), book: SongBook.empty);
    expect(c.submission.isOldApp, isTrue);
    expect(c.submission.shape, ContribEmailShape.oldApp,
        reason: 'po rozkładzie kształtów poznasz, kiedy wolno skasować czytnik');
    expect(c.labels, contains(SongLabel.replyOldApp.label));
  });

  test('blok, który w tym wątku już poszedł, nie idzie drugi raz', () {
    // Wątek cofnięty przez `reopen`: etykiety zeszły, ale nasza odpowiedź
    // z blokiem w wątku została — `scan` dociąga ją z wysłanych.
    final c = classifyBatch([_wiadomosc(oldAppBody(json: _songJson)), _nasza(composeContribReply(oldApp: true)!)],
        book: SongBook.empty).single;
    expect(c.submission.isOldApp, isTrue);
    expect(c.submission.oldAppBlockSent, isTrue);
    expect(c.labels, isNot(contains(SongLabel.replyOldApp.label)));
  });

  test('nasza odpowiedź bez bloku nie zwalnia z bloku', () {
    // Np. odpisane ręcznie z Gmaila: pod mejlem ze starej apki info
    // o aktualizacji ma być i tak.
    final c = classifyBatch([_wiadomosc(oldAppBody(json: _songJson)), _nasza('Dzięki, dodam!')],
        book: SongBook.empty).single;
    expect(c.submission.oldAppBlockSent, isFalse);
    expect(c.labels, contains(SongLabel.replyOldApp.label));
  });

  test('kolejka wyklucza po każdej etykiecie song/*', () {
    expect(isSongLabel(SongLabel.added.label), isTrue);
    expect(isSongLabel(SongLabel.replyOldApp.label), isTrue);
    expect(isSongLabel(SongLabel.waitingForAuthor.label), isTrue);
    expect(kQueueQuery, contains(labelQueryName(SongLabel.added.label)));
    expect(kQueueQuery, contains(labelQueryName(SongLabel.replyOldApp.label)));
  });
}
