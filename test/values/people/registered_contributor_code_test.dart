import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/registered_contributor_code.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

void main(){
  test('dartConstName', (){
    expect(dartConstName('Agnieszka Radecka-Kubicka'), 'AGNIESZKA_RADECKA_KUBICKA');
    expect(dartConstName('  Łukasz  Żółw '), 'LUKASZ_ZOLW');
    expect(dartConstName(''), 'OSOBA', reason: 'stała bez nazwy nie skompiluje się w data.dart');

    // Karta podpisana „Anonim” nazywa stałą adresem: `ANONIM`, `ANONIM_2`,
    // `ANONIM_3` nie mówią, kto jest kto, a przy kolejnym zgłoszeniu tej samej
    // osoby nie da się znaleźć jej wpisu.
    expect(dartConstName('Anonim', email: 'karina.powiecka@icloud.com'), 'KARINA_POWIECKA');
    expect(dartConstName('', email: 'adamplutaaa@gmail.com'), 'ADAMPLUTAAA');
    expect(dartConstName('Anonim'), 'OSOBA', reason: 'bez adresu nie ma z czego wziąć nazwy');
    expect(dartConstName('Anonim', email: 'anonim@wp.pl'), 'OSOBA',
        reason: 'adres też nikogo nie nazywa');
    expect(dartConstName('Kinga Szafrańska', email: 'kinga.szafranska@zhp.net.pl'),
        'KINGA_SZAFRANSKA',
        reason: 'imię i nazwisko zawsze wygrywa z adresem');
  });

  test('wpis w kształcie data.dart, napisy wyescapowane', (){
    const registered = RegisteredContributor(
      person: Person(
        name: "Jan O'Brien",
        druzyna: r'Drużyna $1',
        srodowisko: Srodowisko.hufiec('ziemi_cieszynskiej', showChoragiew: false),
      ),
      emails: ['jan@example.com'],
    );
    expect(registeredContributorDartCode(registered), [
      'const RegisteredContributor JAN_O_BRIEN = RegisteredContributor(',
      '  person: Person(',
      r"    name: 'Jan O\'Brien',",
      r"    druzyna: 'Drużyna \$1',",
      "    srodowisko: Srodowisko.hufiec('ziemi_cieszynskiej', showChoragiew: false),",
      '  ),',
      "  emails: ['jan@example.com'],",
      ');',
    ].join('\n'));
  });
}
