import 'package:piosenkomat/cli.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _json = r'{"title":"Stara","parts":[{"text":"Zwrotka","chords":"a","shift":false}]}';

String _mejl(String marker) => '''
Dzięki za chęć dzielenia się swoimi piosenkami!

!!! $marker !!!
$_json
!!! NIE EDYTUJ POWYŻSZEGO TEKSTU !!!
''';

void main() {
  group('mayBeOldApp: ten sam luźny wzorzec, co parser', () {
    test('zwykły znacznik', () {
      expect(mayBeOldApp(ContribMessage(id: 'a', body: _mejl('NIE EDYTUJ PONIŻSZEGO TEKSTU'))),
          isTrue);
    });

    test('znacznik przełamany przez klienta pocztowego', () {
      // Sztywne `contains` tu chybiało — autor, któremu już odpisano,
      // wracał do kolejki `reply/old-app` i dostawał drugi mejl.
      expect(mayBeOldApp(ContribMessage(id: 'a', body: _mejl('NIE EDYTUJ\nPONIŻSZEGO TEKSTU'))),
          isTrue);
    });

    test('zgłoszenie z nowej apki to nie stara apka', () async {
      expect(mayBeOldApp(msgFrom(await completeEmail())), isFalse);
    });
  });
}
