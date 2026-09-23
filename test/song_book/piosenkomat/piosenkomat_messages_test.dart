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
      const data = PiosenkomatData(conversation: [
        PiosenkomatMessage('pierwsze pytanie'),
        PiosenkomatMessage('moja odpowiedź', isOurs: true),
        PiosenkomatMessage('druga wiadomość'),
      ]);
      expect(data.userMessage, 'pierwsze pytanie\n\ndruga wiadomość');
    });

    test('same odpowiedzi ze skrzynki → autor nic nie napisał', () {
      const data = PiosenkomatData(conversation: [PiosenkomatMessage('odpisałem', isOurs: true)]);
      expect(data.userMessage, isNull);
    });

    test('bez rozmowy → nic', () {
      expect(const PiosenkomatData().userMessage, isNull);
    });
  });

  group('PiosenkomatData: zapis i odczyt', () {
    test('runda w obie strony zachowuje stronę i datę', () {
      final data = PiosenkomatData(conversation: [
        PiosenkomatMessage('od autora', at: DateTime.utc(2026, 6, 28, 17, 54)),
        const PiosenkomatMessage('ode mnie', isOurs: true),
      ]);
      final back = PiosenkomatData.fromJsonMap(data.toJsonMap());

      expect(back.conversation, hasLength(2));
      expect(back.conversation[0].text, 'od autora');
      expect(back.conversation[0].isOurs, isFalse);
      expect(back.conversation[0].at, DateTime.utc(2026, 6, 28, 17, 54));
      expect(back.conversation[1].isOurs, isTrue);
      expect(back.conversation[1].at, isNull);
    });

    test('`ours: false` nie zaśmieca pliku', () {
      const data = PiosenkomatData(conversation: [PiosenkomatMessage('od autora')]);
      final json = data.toJsonMap()[PiosenkomatData.PARAM_CONVERSATION] as List;
      expect((json.single as Map).containsKey(PiosenkomatMessage.PARAM_OURS), isFalse);
    });

    test('odpowiedź do autora i stara apka przechodzą przez zapis', () {
      const data = PiosenkomatData(isOldApp: true, reviewNote: '  Dorzuć chwyty.  ');
      final json = data.toJsonMap();
      expect(json[PiosenkomatData.PARAM_REVIEW_NOTE], 'Dorzuć chwyty.');
      final back = PiosenkomatData.fromJsonMap(json);
      expect(back.isOldApp, isTrue);
      expect(back.reviewNote, 'Dorzuć chwyty.');
      expect(back.hasReviewNote, isTrue);
    });

    test('pusta wiadomość w pliku jest pomijana', () {
      final back = PiosenkomatData.fromJsonMap({
        PiosenkomatData.PARAM_CONVERSATION: [
          {PiosenkomatMessage.PARAM_TEXT: '   '},
          {PiosenkomatMessage.PARAM_TEXT: 'coś'},
        ],
      });
      expect(back.conversation.map((m) => m.text), ['coś']);
    });
  });

}
