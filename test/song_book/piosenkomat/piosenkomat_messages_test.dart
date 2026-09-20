import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';

// Fragment prawdziwego zgłoszenia z apki: belka, dopisek, podpowiedź
// w nawiasach, a potem to, czego człowiek nie pisał.
const _fromApp = '''- - - - - - Miejsce na własną wiadomość - - - - - -
Jasne, może byc tak?

[Jeśli chcesz coś dodać, skomentować, lub wyjaśnić, możesz to zrobić tutaj.]

- - - - - - Zasady dodawania piosenek - - - - - -

Znam i akceptuję zasady dodawania piosenek do aplikacji HarcApp (v05.10.2025).

### Kod piosenki:

```json
{"title":"Poezja"}
```''';

void main() {

  group('stripSubmissionTemplate:', () {
    test('zostaje sam dopisek autora', () {
      expect(stripSubmissionTemplate(_fromApp), 'Jasne, może byc tak?');
    });

    test('zwykła odpowiedź przechodzi bez zmian', () {
      expect(stripSubmissionTemplate('Czuwaj! Jasne, dopiszę autorów.'),
          'Czuwaj! Jasne, dopiszę autorów.');
    });

    test('sam szablon → null, bo nie ma czego pokazać', () {
      expect(stripSubmissionTemplate('### Kod piosenki:\n{}'), isNull);
      expect(stripSubmissionTemplate('- - - - - - Miejsce na własną wiadomość - - - - - -'), isNull);
    });

    test('tnie też przy karcie osoby dodającej i propozycji poprawki', () {
      expect(stripSubmissionTemplate('Dopisek\n\n### Osoba dodająca:\n{}'), 'Dopisek');
      expect(stripSubmissionTemplate('Dopisek\n\n### Propozycja poprawki:\n```text\n```'), 'Dopisek');
    });
  });

  group('PiosenkomatData: rozmowa', () {
    test('userMessage to tylko to, co napisał autor', () {
      const data = PiosenkomatData(messages: [
        PiosenkomatMessage('pierwsze pytanie'),
        PiosenkomatMessage('moja odpowiedź', mine: true),
        PiosenkomatMessage('druga wiadomość'),
      ]);
      expect(data.userMessage, 'pierwsze pytanie\n\ndruga wiadomość');
      expect(data.hasMessages, isTrue);
    });

    test('same odpowiedzi ze skrzynki → autor nic nie napisał', () {
      const data = PiosenkomatData(messages: [PiosenkomatMessage('odpisałem', mine: true)]);
      expect(data.userMessage, isNull);
      // `hasMessages` pyta o rozmowę w ogóle — ta jest, choć autor milczy.
      expect(data.hasMessages, isTrue);
    });

    test('bez rozmowy i bez poprawki → nic', () {
      const data = PiosenkomatData();
      expect(data.userMessage, isNull);
      expect(data.hasMessages, isFalse);
    });
  });

  group('PiosenkomatData: zapis i odczyt', () {
    test('runda w obie strony zachowuje stronę i datę', () {
      final data = PiosenkomatData(messages: [
        PiosenkomatMessage('od autora', at: DateTime.utc(2026, 6, 28, 17, 54)),
        const PiosenkomatMessage('ode mnie', mine: true),
      ]);
      final back = PiosenkomatData.fromJsonMap(data.toJsonMap());

      expect(back.messages, hasLength(2));
      expect(back.messages[0].text, 'od autora');
      expect(back.messages[0].mine, isFalse);
      expect(back.messages[0].at, DateTime.utc(2026, 6, 28, 17, 54));
      expect(back.messages[1].mine, isTrue);
      expect(back.messages[1].at, isNull);
    });

    test('`mine: false` nie zaśmieca pliku', () {
      const data = PiosenkomatData(messages: [PiosenkomatMessage('od autora')]);
      final json = data.toJsonMap()[PiosenkomatData.PARAM_MESSAGES] as List;
      expect((json.single as Map).containsKey(PiosenkomatMessage.PARAM_MINE), isFalse);
    });

    test('stary plik z `user_message` czyta się jako jedna wiadomość autora', () {
      final back = PiosenkomatData.fromJsonMap({
        PiosenkomatData.PARAM_USER_MESSAGE: 'stary zlepiony dopisek',
      });
      expect(back.messages, hasLength(1));
      expect(back.messages.single.text, 'stary zlepiony dopisek');
      expect(back.messages.single.mine, isFalse);
      expect(back.userMessage, 'stary zlepiony dopisek');
    });

    test('pusta wiadomość w pliku jest pomijana', () {
      final back = PiosenkomatData.fromJsonMap({
        PiosenkomatData.PARAM_MESSAGES: [
          {PiosenkomatMessage.PARAM_TEXT: '   '},
          {PiosenkomatMessage.PARAM_TEXT: 'coś'},
        ],
      });
      expect(back.messages.map((m) => m.text), ['coś']);
    });
  });

}
