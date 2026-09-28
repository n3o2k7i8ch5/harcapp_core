import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/mail_quotes.dart';

void main() {
  group('nagłówek cytatu — z prawdziwych klientów', () {
    for (final header in [
      'W dniu pt., 12 wrz 2026 o 10:15 Jan Kowalski <jan@example.com> napisał(a):',
      'pt., 12 wrz 2026 o 10:15 Jan Kowalski <jan@example.com> napisał(a):',
      'W dniu 12.09.2026 o 10:15, Jan Kowalski pisze:',
      'Wiadomość napisana przez Jan Kowalski <jan@example.com> w dniu 12.09.2026, o godz. 10:15:',
      'On Fri, Sep 12, 2026 at 10:15 AM Jan <jan@example.com> wrote:',
      'Jan Kowalski <jan@example.com> napisał(a):',
      'W dniu 1 czerwca Filip napisał:',
      'Dnia 1 czerwca Ola napisała:',
    ]) {
      test(header, () => expect(isQuoteHeader(header), isTrue));
    }

    test('zwykłe zdanie autora nie jest nagłówkiem', () {
      expect(isQuoteHeader('Kolega napisał: dorzuć chwyty'), isFalse);
      expect(isQuoteHeader('Pozdrawiam, Jan'), isFalse);
      expect(isQuoteHeader('napisał(a):'), isFalse);
    });
  });

  group('ownReplyText', () {
    test('Gmail po polsku: nagłówek i cytat znikają', () {
      expect(
        ownReplyText('Chwyty: a d e\n\n'
            'W dniu pt., 12 wrz 2026 o 10:15 HarcApp <harcapp@gmail.com> napisał(a):\n'
            '> Dorzuć chwyty.'),
        'Chwyty: a d e\n',
      );
    });

    test('nagłówek złamany przez klienta na dwie linie', () {
      expect(
        ownReplyText('Chwyty: a d e\n'
            'W dniu pt., 12 wrz 2026 o 10:15 HarcApp <\n'
            'harcapp@gmail.com> napisał(a):\n'
            '> Dorzuć chwyty.'),
        'Chwyty: a d e',
      );
    });

    test('zdanie przed nagłówkiem zostaje, choćby sklejone z nim pasowało', () {
      expect(
        ownReplyText('Pozdrawiam, Jan\n'
            'Jan Kowalski <jan@example.com> napisał(a):\n'
            '> cytat'),
        'Pozdrawiam, Jan',
      );
    });

    test('bez cytatu nic nie ginie', () {
      expect(ownReplyText('Linia 1\n  wcięta linia 2'), 'Linia 1\n  wcięta linia 2');
    });
  });
}
