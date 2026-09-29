import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('hasOldAppRegion: ten sam luźny wzorzec, co parser', () {
    test('zwykły znacznik', () {
      expect(ContribMessage(id: 'a', body: oldAppBody()).hasOldAppRegion,
          isTrue);
    });

    test('znacznik przełamany przez klienta pocztowego', () {
      // Sztywne `contains` tu chybiało — autor, któremu już odpisano,
      // wracał do kolejki `reply/old-app` i dostawał drugi mejl.
      expect(ContribMessage(id: 'a', body: oldAppBody().replaceFirst('NIE EDYTUJ PONIŻSZEGO', 'NIE EDYTUJ\nPONIŻSZEGO')).hasOldAppRegion,
          isTrue);
    });

    test('zgłoszenie z nowej apki to nie stara apka', () async {
      expect(msgFrom(await completeEmail()).hasOldAppRegion, isFalse);
    });
  });
}
