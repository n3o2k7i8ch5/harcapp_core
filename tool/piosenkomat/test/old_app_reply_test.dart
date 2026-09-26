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
  group('hasOldAppRegion: ten sam luźny wzorzec, co parser', () {
    test('zwykły znacznik', () {
      expect(ContribMessage(id: 'a', body: _mejl('NIE EDYTUJ PONIŻSZEGO TEKSTU')).hasOldAppRegion,
          isTrue);
    });

    test('znacznik przełamany przez klienta pocztowego', () {
      // Sztywne `contains` tu chybiało — autor, któremu już odpisano,
      // wracał do kolejki `reply/old-app` i dostawał drugi mejl.
      expect(ContribMessage(id: 'a', body: _mejl('NIE EDYTUJ\nPONIŻSZEGO TEKSTU')).hasOldAppRegion,
          isTrue);
    });

    test('zgłoszenie z nowej apki to nie stara apka', () async {
      expect(msgFrom(await completeEmail()).hasOldAppRegion, isFalse);
    });
  });
}
