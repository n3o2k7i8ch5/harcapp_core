import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

import 'common_wychowanie_duchowe.dart';
import 'czynniki_i_mechanizmy_ksztaltowania_duchowosci.dart';


const konspekt_kszt_name_warsztaty_wychowania_duchowego = 'warsztaty_wychowania_duchowego';
const konspekt_kszt_title_warsztaty_wychowania_duchowego = 'Warsztaty wychowania duchowego';


const String _attach_html_scenariusz_fantomowe_dzialania_wychowawcze = '<a href="$_attach_name_scenariusz_fantomowe_dzialania_wychowawcze@attachment">$_attach_title_scenariusz_fantomowe_dzialania_wychowawcze</a>';
const String _attach_name_scenariusz_fantomowe_dzialania_wychowawcze = 'scenariusz_fantomowe_dzialania_wychowawcze';
const String _attach_title_scenariusz_fantomowe_dzialania_wychowawcze = 'Scenariusz fantomowe działania wychowawcze';
KonspektAttachment _attach_scenariusz_fantomowe_dzialania_wychowawcze = KonspektAttachment(
  name: _attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
  title: _attach_title_scenariusz_fantomowe_dzialania_wychowawcze,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_formy = '<a href="$_attach_name_formy@attachment">$_attach_title_formy</a>';
const String _attach_name_formy = 'formy';
const String _attach_title_formy = 'Formy';
KonspektAttachment _attach_formy = KonspektAttachment(
  name: _attach_name_formy,
  title: _attach_title_formy,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);

const String _attach_html_planowanie_strategii_i_dzialan = '<a href="$_attach_name_planowanie_strategii_i_dzialan@attachment">$_attach_title_planowanie_strategii_i_dzialan</a>';
const String _attach_name_planowanie_strategii_i_dzialan = 'planowanie_strategii_i_dzialan';
const String _attach_title_planowanie_strategii_i_dzialan = 'Planowanie strategii i działań';
KonspektAttachment _attach_planowanie_strategii_i_dzialan = KonspektAttachment(
  name: _attach_name_planowanie_strategii_i_dzialan,
  title: _attach_title_planowanie_strategii_i_dzialan,
  assets: {
    FileFormat.pdf: null,
    FileFormat.docx: null,
  },
);


KonspektMaterial material_poradnik_o_strukturze_duchowosci = KonspektMaterial(
  name: 'Dostępny do przygotowania merytorycznego $attach_title_poradnik_o_strukturze_duchowosci',
  attachmentName: attach_name_poradnik_o_strukturze_duchowosci,
);

KonspektMaterial material_poradnik_przykladowa_strategia_rozwoju_duchowego = KonspektMaterial(
  name: 'Dostępny do przygotowania merytorycznego $attach_title_poradnik_przykladowa_strategia_rozwoju_duchowego',
  attachmentName: attach_name_poradnik_przykladowa_strategia_rozwoju_duchowego,
);

KonspektMaterial material_identyfikator = KonspektMaterial(
  name: 'Identyfikator',
  amountAttendantFactor: 1,
);

KonspektMaterial material_dlugopis = KonspektMaterial(
  name: 'Długopis',
  amountAttendantFactor: 1,
);

KonspektMaterial material_notatnik = KonspektMaterial(
  name: 'Notatnik',
  amountAttendantFactor: 1,
);

KonspektMaterial material_nozyczki = KonspektMaterial(
  name: 'Nożyczki',
  amount: 2,
);

KonspektMaterial material_kartka_a4 = KonspektMaterial(
  name: 'Kartka A4',
  amount: 4,
);

KonspektMaterial material_obiad = KonspektMaterial(
  name: 'Obiad',
  amountAttendantFactor: 1,
);

KonspektMaterial material_przekaski = KonspektMaterial(
  name: 'Przekąski (jabłka, marchewki, ciastka)',
);

KonspektMaterial material_miski_na_przekaski = KonspektMaterial(
    name: 'Miski na przekąski',
    amount: 3
);

KonspektMaterial material_herbata = KonspektMaterial(
  name: 'Herbata',
);

KonspektMaterial material_kubek = KonspektMaterial(
  name: 'Kubek',
  amountAttendantFactor: 1,
);

KonspektMaterial material_czajnik = KonspektMaterial(
  name: 'Czajnik',
  amount: 1,
);

KonspektMaterial material_zal_kratka_minimow_rozwoju_duchowego = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_kratka_minimow_rozwoju_duchowego”',
    attachmentName: attach_name_kratka_minimow_rozwoju_duchowego,
    amount: 4
);

KonspektMaterial material_zal_scenariusz_fantomowe_dzialania_wychowawcze = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_scenariusz_fantomowe_dzialania_wychowawcze”',
    attachmentName: _attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
    additionalPreparation: 'Kartkę należy przeciąć na pół wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_formy = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_formy”',
    attachmentName: _attach_name_formy,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_planowanie_strategii_i_dzialan = KonspektMaterial(
    name: 'Wydrukowany załącznik “$_attach_title_planowanie_strategii_i_dzialan”',
    attachmentName: _attach_name_planowanie_strategii_i_dzialan,
    amount: 2,
    comment: 'Może się okazać, że chętni na jedną z metodyk będą tak liczni, że warto ich podzielić na dwie osobne grupy - dlatego warto wydrukować dwa razy.'
);

KonspektMaterial material_zal_przypinki = KonspektMaterial(
    name: 'Przypinki z logiem warsztatów',
    amountAttendantFactor: 1
);

Konspekt konspekt_kszt_warsztaty_wychowania_duchowego = Konspekt(
    name: konspekt_kszt_name_warsztaty_wychowania_duchowego,
    title: konspekt_kszt_title_warsztaty_wychowania_duchowego,
    additionalSearchPhrases: [
      'wychowanie duchowe'
    ],
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      ...wstep_do_wychowania_duchowego_aims,
      'Zapoznanie uczestników z mechanizmami i narzędziami kształtowania duchowości.',
      'Przekazanie uczestnikom wiedzy o oczekiwanych efektach wychowania duchowego w zależności od wieku.',
      'Przekazanie uczestnikom wiedzy o formach praktycznej pracy nad duchowością harcerzy w zależności od wieku.',
      'Wykształcenie u uczestników zrozumienia i zdolności do tworzenia strategii rozwoju duchowego.',
    ],
    attachments: [
      attach_poradnik_o_strukturze_duchowosci,

      attach_sfery,
      attach_sfery_przyklady,

      attach_poradnik_przykladowa_strategia_rozwoju_duchowego,

      attach_karty_poziomow_duchowosci,
      attach_karty_zdolnosci_integracji_duchowosci,

      attach_aksjomaty_opisu_przyklady,
      attach_aksjomaty_sensu_przyklady,
      attach_aksjomaty_bledne_przyklady,

      attach_meta_narracja_scenka,
      attach_meta_narracja_opis,
      attach_meta_narracja_przyklady,
      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,

      ...attach_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,

      attach_karty_zalozen_wyjsciowych_wychowania_duchowego,

      _attach_planowanie_strategii_i_dzialan,

      _attach_formy,
      _attach_scenariusz_fantomowe_dzialania_wychowawcze,

      attach_szybkie_strzaly_dyskusyjne
    ],
    materials: [

      material_poradnik_o_strukturze_duchowosci,
      material_poradnik_przykladowa_strategia_rozwoju_duchowego,

      material_identyfikator,

      material_dlugopis,

      material_notatnik,

      material_nozyczki,

      material_mini_kartki_biurowe,

      material_zal_sfery,
      material_zal_sfery_przyklady,

      material_kartka_a4,

      material_flipchart,

      material_marker,

      material_tasma_klejaca,

      material_obiad,

      material_przekaski,

      material_miski_na_przekaski,

      material_herbata,

      material_kubek,

      material_czajnik,

      material_zal_karty_poziomow_duchowosci,
      material_zal_karty_zdolnosci_integracji_duchowosci,

      material_zal_aksjomaty_opisu_przyklady,
      material_zal_aksjomaty_sensu_przyklady,
      material_zal_aksjomaty_bledne_przyklady,

      material_budzik,
      material_zal_meta_narracja_scenka,
      material_zal_meta_narracja_opis,
      material_zal_meta_narracja_przyklady,

      material_zal_neutralnosc_duchowa_przyklady,

      material_zal_cel_wychowania_duchowego_zhp_statut,

      material_zal_cel_wychowania_duchowego_zhp_uchwala,

      material_zal_kratka_minimow_rozwoju_duchowego,

      ...materials_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci,

      material_zal_karty_zalozen_wyjsciowych_wychowania_duchowego,

      material_zal_planowanie_strategii_i_dzialan,

      material_zal_formy,

      material_zal_scenariusz_fantomowe_dzialania_wychowawcze,

      material_zal_szybkie_strzaly_dyskusyjne,

      material_zal_przypinki,

    ],
    summary: 'Uczestnicy pochylają się nad zagadnieniem duchowości: co to jest? co ją różni od innych sfer? jakie mechanizmy nią rządzą, czy może być ona "neutralna", oraz jak ją kształtować u wychowanków?',
    stepGroups: [

      KonspektStepGroup(
          title: 'Wstęp',
          steps: [
            KonspektStep(
                title: 'Przyjście i ogarnięcie się',
                duration: Duration(minutes: 15),
                required: false,
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Nim rozpocznie się właściwa część warsztatów, warto pozwolić uczestnikom przyjść, zrobić herbatę i porozmawiać o głupotach.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Rozpoczęcie',
                duration: Duration(minutes: 30),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący rozdaje uczestnikom <b>identyfikatory</b>, <b>długopisy</b> i <b>notatniki</b> (do własnego użytku uczestników). Na identyfikatorach uczestnicy wpisują swoje imię i je zakładają.'
                    '<br>'
                    '<br>Następnie, w kręgu, uczestnicy się <b>przedstawiają</b>. Prowadzący prosi, by każdy krótko odpowiedział na następujące zagadnienia:'
                    '</p>'

                    '<ol>'
                    '<li><p style="text-align:justify;">Co robię w harcerstwie?</p></li>'
                    '<li><p style="text-align:justify;">Jakie mam harcerskie doświadczenie z duchowością i religią?</p></li>'
                    '<li><p style="text-align:justify;">Słowo lub fraza - skojarzenie z duchowością.</p></li>'
                    '</ol>'

                    '<p style="text-align:justify;">'
                    'Każdy uczestnik zapisuje przedstawione skojarzenia z duchowością na <b>mini-kartkach</b> i umieszcza je na wspólnej, widocznej przestrzeni.'
                    '</p>',
                materials: [
                  material_identyfikator,
                  material_dlugopis,
                  material_notatnik,
                  material_mini_kartki_biurowe,
                ]
            ),

            KonspektStep(
              title: 'Oświadczenie wstępne',
              duration: Duration(minutes: 5),
              activeForm: KonspektStepActiveForm.static,
              content: '<p style="text-align:justify;">'
                  'Prowadzący informuje uczestników o celu warsztatów:'
                  '<br>'
                  '<br><b><i>Warsztaty nie służą indywidualnej pracy nad duchowością uczestników. Służą umiejętności wychowania duchowego harcerzy z perspektywy instruktora.</i></b>'
                  '<br>'
                  '<br>Warsztaty dzielą się na trzy części:'
                  '</p>'

                  '<ol>'
                  '<li><p style="text-align:justify;">Pojęcia i opis rozwoju duchowego - forma statyczna.</p></li>'
                  '<li><p style="text-align:justify;">Duchowość w kontekście wychowania harcerskiego - forma dyskusyjna.</p></li>'
                  '<li><p style="text-align:justify;">Praca z duchowością w poszczególnych metodykach - forma pracy w małych grupach.</p></li>'
                  '</ol>'

                  '<p style="text-align:justify;">'
                  'Prowadzący może również zaznaczyć, że <b>przedstawiony na warsztatach sposób rozumienia duchowości jest propozycją - nie jest to mądrość dana z niebios, ani wyryta w kamieniu. Owa propozycja jest efektem wielu lat doświadczeń, rozmów i analiz i podlega stałemu rozwojowi.</b>'
                  '</p>',
            ),
          ]
      ),

      step_group_definicja_sfery_ducha,

      step_group_poziomy_duchowosci,

      step_group_integracja_duchowosci,

      step_group_metanarracja,

      step_group_zdolnosc_integracji_duchowosci,

      KonspektStepGroup(
          steps: [
            KonspektStep(
                title: 'Przerwa',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
                    '</p>'
            ),
          ]
      ),

      KonspektStepGroup(
          title: 'Czynniki i mechanizmy kształtowania duchowości',
          steps: steps_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci.map((step) => step.copyWithNamePrefix('Czynniki duchowości - ')).toList()
      ),

      KonspektStepGroup(
          steps: [
            KonspektStep(
                title: 'Obiad',
                duration: Duration(minutes: 45),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Najlepiej już wcześniej zamówić pizzę, żeby jedzenie trwało niewiele czasu i by można było po nim chwilę odpocząć.'
                    '</p>',
                materials: [
                  material_obiad,
                ]
            ),
          ]
      ),

      step_group_neutralnosc_duchowa,

      step_group_duchowosc_powszechna,

      step_group_duchowosc_w_zhp,

      step_zalozenia_wyjsciowe_wychowania_duchowego,

      KonspektStepGroup(
        steps: [
          KonspektStep(
            title: 'Przerwa',
            duration: Duration(minutes: 10),
            activeForm: KonspektStepActiveForm.active,
            content: '<p style="text-align:justify;">'
              'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
              '</p>'
          ),
        ]
      ),

      KonspektStepGroup(
          title: 'Planowanie wychowania duchowego',
          steps: [

            KonspektStep(
                title: 'Planowanie wychowania duchowego - podział na grupy',
                duration: Duration(minutes: 5),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                  'Uczestnicy są dzieleni na 4 grupy. Każda grupa otrzymuje krótki opis drużyny z załącznika $_attach_html_planowanie_strategii_i_dzialan. Zadaniem każdej grupy jest stworzyć plan rozwoju duchowego jednostki.'
                  '<br>'
                  '<br>Każda z opisanych na kartce drużyn jest w innej metodyce (Z, H, HS, W). Prowadzący może podzielić uczestników tak, by każdy był w grupie pracującej nad metodyką, która jest uczestnikom najbliższa.'
                  '<br>'
                  '<br>Na początku prowadzący prosi każdą z grup, by zapoznała się z opisami.'
                  '</p>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - przykładowa strategia',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prezentuje uczestnikom przykładową strategię rozwoju duchowego drużyny, opisaną w załączniku $attach_html_poradnik_przykladowa_strategia_rozwoju_duchowego.'
                    '<br>'
                    '<br>Zadaniem uczestników jest stworzenie strategii o podobnej formie dla jednostek, które wybrali w poprzednim kroku.'
                    '<br>'
                    '<br>Prowadzący po zakończeniu przedstawiania przykładowej strategii mówi, że <b>jest dostępna w aplikacji HarcApp jako poradnik</b> i uczestnicy mogą w każdej chwili do niej zajrzeć.'
                    '</p>',
                materials: [
                  material_poradnik_przykladowa_strategia_rozwoju_duchowego
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - cele',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by wskazała <b>jeden cel w pracy duchowej</b>, który chce osiągnąć dla opisanej drużyny mając do dyspozycji 3 lata pracy harcerskiej.'
                    '<br>'
                    '<br>Uczestnicy powinni wybrać coś, co uważają za szczególnie ważnie: w razie czego prowadzący może im zasugerować jeden z następujacych celów:'
                    '</p>'
                    '<ul>'
                    '<li><p style="text-align:justify;">Wiara chrześcijańska</p></li>'
                    '<li><p style="text-align:justify;">Patriotyzm</p></li>'
                    '</ul>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - czynniki duchowości',
                duration: Duration(minutes: 15),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by w oparciu o przynajmniej <b>trzy czynniki duchowości</b> zaplanowała konkretne działania strategiczne, które przybliżą drużynę do wybranego celu.'
                    '<br>'
                    '<br>Wszystkie czynniki duchowości powinny być wyłożone w widocznym miejscu na kartkach z załącznika $attach_html_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci.'
                    '<br>'
                    '<br>Nie chodzi tu o wymyślanie zajęć dla harcerzy (zbiórek, gier, ognisk), lecz o decyzje dotyczące otoczenia i warunków, w jakich drużyna funkcjonuje, np.: <i>przekonanie rodziców zuchów, aby do 14 roku życia miały one na wyłączność dostęp tylko do prostych telefonów bez funkcji dotykowych, aby zwiększyć częstotliwość ich interakcji z niecyfrowym światem, który stawia większe wyzwania.</i>'
                    '<br>'
                    '<br>Prowadzący może zasugerować, by grupy skoncentrowały się na następujących czynnikach:'
                    '</p>'

                    '<p style="text-align:justify;">'
                    'Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
                    '</p>',
                materials: [
                  material_zal_planowanie_strategii_i_dzialan,
                  material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - omówienie postępu prac',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zbiera na chwilę w jedno miejsce wszystkich uczestników i prosi każdą z grup, by przedstawiła swoje opisane cele, wybrane czynniki duchowości i mechanizmy kształtowania duchowości. Po każdej z prezentacji może się odbyć krótka dyskusja nad planami.'
                    '<br>'
                    '<br>Ten punkt służy temu, aby prowadzący miał możliwość zareagować, jeśli któraś z grup zacznie błądzić w założeniach.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - działania bezpośrednie',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prosi każdą z grup, by jako ostatni element planowania strategii rozwoju duchowego wskazała <b>działania śródroczne</b> i <b>działania obozowe</b> z uwzględnieniem <b>niedzieli na obozie</b>. Można się w tym celu posiłkować pomysłami z załącznika $_attach_html_formy, które są dostępne w aplikacji <b>HarcApp</b>.'
                    '<br>'
                    '<br>Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
                    '<br>'
                    '<br>Grupy pracujące na opisie jednostek H, HS i W mogą także określić oczekiwania wychowawcze od jednostek niższego pionu, które przekazują im harcerzy w ciągu wychowawczym.'
                    '</p>',
                materials: [
                  material_zal_formy,
                ]
            ),

            KonspektStep(
                title: 'Planowanie wychowania duchowego - prezentacja',
                duration: Duration(minutes: 30),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Każda z grup ma kilka minut, aby <b>zaprezentować</b> swoje strategie i działania.'
                    '<br>'
                    '<br>Po każdej z prezentacji może się odbyć krótka dyskusja nad planami - prowadzący powinien zachęcać do krytyki, jeżeli ktoś się z czymś nie zgadza.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Niedziela na obozie',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.static,
                content: '<p style="text-align:justify;">'
                    'Prowadzący podsumowuje plany i strategie rozwoju duchowego związane z niedzielą obozową, prezentowane przez grupy w poprzednim punkcie. Uczestnicy mają możliwość dodania proponowanych form - ważne, by prowadzący prosił o podanie mechanizmu ich działania.'
                    '<br>'
                    '<br>Na końcu prowadzący uzupełnia zbiorczy plan niedzieli o elementy obecne w formie <i>“Msza (obozowa, lecz nie tylko)”</i> z załącznika $_attach_html_formy i krótko je omawia.'
                    '</p>'
            ),

          ]
      ),

      KonspektStepGroup(
          title: 'Formy wychowania duchowego',
          steps: [
            KonspektStep(
                title: 'Formy wychowania duchowego - kratka i przykłady',
                duration: Duration(minutes: 30),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Uczestnicy otrzymują w grupach po jednym załączniku $attach_html_kratka_minimow_rozwoju_duchowego. Otrzymują również wydrukowane i wycięte formy z załącznika $_attach_html_formy.'
                    '<br>'
                    '<br>Na podstawie zdobytej dotychczas wiedzy oraz załącznika $attach_html_kratka_minimow_rozwoju_duchowego, zadaniem uczestników jest:'
                    '</p>'
                    '<ol>'
                    '<li><p style="text-align:justify;">Przyporządkowanie poszczególnych form do <b>grupy</b> lub <b>grup wiekowych</b>.</p></li>'
                    '<li><p style="text-align:justify;">Określenie, jakie <b>poziomy duchowości</b> rozwijają.</p></li>'
                    '<li><p style="text-align:justify;">Określenie, jeśli to możliwe, jaki <b>mechanizm</b> wykorzystują.</p></li>'
                    '</ol>'
                    '<p style="text-align:justify;">'
                    '<br>'
                    '<br>Warto uczestników podzielić na grupy po 3-4 osoby, aby jak najbardziej zaangażować ich w dyskusję nad formami.'
                    '</p>',
                materials: [
                  material_zal_kratka_minimow_rozwoju_duchowego,
                  material_zal_formy,
                ]
            ),

            KonspektStep(
                title: 'Formy wychowania duchowego - kratka i przykłady - podsumowanie',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zbiera na powrót wszystkie grupy w jedno miejsce i prosi, by każda z grup przedstawiła po kilka wybranych form które:'
                    '</p>'

                    '<ul>'
                    '<li><p style="text-align:justify;">Najbardziej przypadły im do gustu.</p></li>'
                    '<li><p style="text-align:justify;">Najbardziej ich zaskoczyły.</p></li>'
                    '<li><p style="text-align:justify;">Wydały im się najbardziej kontrowersyjne.</p></li>'
                    '</ul>'

                    '<p style="text-align:justify;">'
                    'Po przedstawieniu najbardziej kontrowersyjnych form prowadzący może zauważyć, że harcerstwo opiera się na <b>wychowaniu poprzez stawianie wyzwań</b> i nie należy się łudzić, że można wychować kogoś w ciągłym, bezgranicznym bezpieczeństwie i komforcie. Lepiej, aby rozwój duchowy zakładał budowanie odporności na trudy i nieprzyjemne sytuacje, niż od nich izolował - harcerstwo nie wychowuje <b>pod kloszem</b>.'
                    '</p>'
            ),

            KonspektStep(
                title: 'Fantomowe działania wychowawcze i skuteczność wychowawcza',
                duration: Duration(minutes: 10),
                activeForm: KonspektStepActiveForm.static,
                required: false,
                content: '<p style="text-align:justify;">'
                    'Prowadzący prezentuje krótki opis obozu drużyny z załącznika $_attach_html_scenariusz_fantomowe_dzialania_wychowawcze i podejmowanych tam działań duchowych, które są zupełnie losowe. Na tej podstawie zadaje pytanie: "co jest nie tak z tą strategią?". Po krótkiej wymianie opinii prowadzący odpowiada wprowadzając pojęcie “<b>fantomowych działań wychowawczych</b>”.'
                    '<br>'
                    '<br>W oparciu o dotychczasowe pojęcia powinno paść hasło “<b>skuteczności wychowawczej</b>”.'
                    '<br>'
                    '<br>Prowadzący może posiłkować się pytaniami:'
                    '<br>'
                    '<br><b>Czy któraś z tych form nie kształtuje duchowości?</b>'
                    '<br>'
                    '<br><b>Jaki jest problem z tak skonstruowanym planem wychowania duchowego?</b>'
                    '</p>',
                materials: [
                  material_zal_scenariusz_fantomowe_dzialania_wychowawcze,
                ]
            ),
          ]
      ),

      KonspektStepGroup(
          steps: [

            step_szybkie_strzaly_dyskusyjne,

            KonspektStep(
                title: 'Podsumowanie warsztatów',
                duration: Duration(minutes: 20),
                activeForm: KonspektStepActiveForm.active,
                content: '<p style="text-align:justify;">'
                    'Prowadzący zaprasza uczestników do wspólnego kręgu w celu podsumowania warsztatów. Przy tej okazji warto skupić się na następujących rzeczach:'
                    '</p>'

                    '<ul>'
                    '<li><p style="text-align:justify;">Rozdanie dyplomów i przypinek uczestnikom.</p></li>'
                    '<li><p style="text-align:justify;">Poproszenie uczestników o podzielenie się wrażeniami związanymi z warsztatami.</p></li>'
                    '<li><p style="text-align:justify;">Prośba o uzupełnienie szczegółowej ankiety ewaluacyjnej - przesłanie jej uczestnikom na maila.</p></li>'
                    '<li><p style="text-align:justify;">Wspólne zdjęcie.</p></li>'
                    '<li><p style="text-align:justify;">Oddanie identyfikatorów przez uczestników.</p></li>'
                    '</ul>'
            ),
          ]
      ),
    ]
);