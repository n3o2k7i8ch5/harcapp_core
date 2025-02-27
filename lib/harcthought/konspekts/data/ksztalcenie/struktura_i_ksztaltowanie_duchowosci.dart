import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import 'common_wychowanie_duchowe.dart';
import 'czynniki_i_mechanizmy_ksztaltowania_duchowosci.dart';


const konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci = 'struktura_i_ksztaltowanie_duchowosci';
const konspekt_kszt_title_struktura_i_ksztaltowanie_duchowosci = 'Struktura i kształtowanie duchowości';


const String attach_html_przyklady_poziomow_duchowosci = '<a href="$attach_name_przyklady_poziomow_duchowosci@attachment">$attach_title_przyklady_poziomow_duchowosci</a>';
const String attach_name_przyklady_poziomow_duchowosci = 'przyklady_poziomow_duchowosci';
const String attach_title_przyklady_poziomow_duchowosci = 'Przykłady poziomów duchowości';
KonspektAttachment attach_przyklady_poziomow_duchowosci = KonspektAttachment(
  name: attach_name_przyklady_poziomow_duchowosci,
  title: attach_title_przyklady_poziomow_duchowosci,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_przyklady_poziomow_duchowosci.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_przyklady_poziomow_duchowosci.docx',
  },
);

const String attach_html_scenariusz_fantomowe_dzialania_wychowawcze = '<a href="$attach_name_scenariusz_fantomowe_dzialania_wychowawcze@attachment">$attach_title_scenariusz_fantomowe_dzialania_wychowawcze</a>';
const String attach_name_scenariusz_fantomowe_dzialania_wychowawcze = 'scenariusz_fantomowe_dzialania_wychowawcze';
const String attach_title_scenariusz_fantomowe_dzialania_wychowawcze = 'Scenariusz fantomowe działania wychowawcze';
KonspektAttachment attach_scenariusz_fantomowe_dzialania_wychowawcze = KonspektAttachment(
  name: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
  title: attach_title_scenariusz_fantomowe_dzialania_wychowawcze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.docx',
  },
);

const String attach_html_formy = '<a href="$attach_name_formy@attachment">$attach_title_formy</a>';
const String attach_name_formy = 'formy';
const String attach_title_formy = 'Formy';
KonspektAttachment attach_formy = KonspektAttachment(
  name: attach_name_formy,
  title: attach_title_formy,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_formy.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_formy.docx',
  },
);

const String attach_html_planowanie_strategii_i_dzialan = '<a href="$attach_name_planowanie_strategii_i_dzialan@attachment">$attach_title_planowanie_strategii_i_dzialan</a>';
const String attach_name_planowanie_strategii_i_dzialan = 'planowanie_strategii_i_dzialan';
const String attach_title_planowanie_strategii_i_dzialan = 'Planowanie strategii i działań';
KonspektAttachment attach_planowanie_strategii_i_dzialan = KonspektAttachment(
  name: attach_name_planowanie_strategii_i_dzialan,
  title: attach_title_planowanie_strategii_i_dzialan,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_planowanie_strategii_i_dzialan.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_planowanie_strategii_i_dzialan.docx',
  },
);

const String attach_html_scenariusze = '<a href="$attach_name_scenariusze@attachment">$attach_title_scenariusze</a>';
const String attach_name_scenariusze = 'scenariusze';
const String attach_title_scenariusze = 'Scenariusze';
KonspektAttachment attach_scenariusze = KonspektAttachment(
  name: attach_name_scenariusze,
  title: attach_title_scenariusze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusze.docx',
  },
);

KonspektMaterial material_poradnik_o_strukturze_i_ksztaltowaniu_duchowosci = KonspektMaterial(
  name: 'Dostępny do przygotowania merytorycznego $attach_title_o_strukturze_i_ksztaltowaniu_duchowosci',
  attachmentName: attach_name_o_strukturze_i_ksztaltowaniu_duchowosci,
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

KonspektMaterial material_zal_przyklady_poziomow_duchowosci = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_przyklady_poziomow_duchowosci”',
    attachmentName: attach_name_przyklady_poziomow_duchowosci,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i potasować w ramach wyciętych czwórek.',
    amount: 1
);

KonspektMaterial material_zal_kratka_minimow_rozwoju_duchowego = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_kratka_minimow_rozwoju_duchowego”',
    attachmentName: attach_name_kratka_minimow_rozwoju_duchowego,
    amount: 4
);

KonspektMaterial material_zal_scenariusz_fantomowe_dzialania_wychowawcze = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_scenariusz_fantomowe_dzialania_wychowawcze”',
    attachmentName: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
    additionalPreparation: 'Kartkę należy przeciąć na pół wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_formy = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_formy”',
    attachmentName: attach_name_formy,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_planowanie_strategii_i_dzialan = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_planowanie_strategii_i_dzialan”',
    attachmentName: attach_name_planowanie_strategii_i_dzialan,
    amount: 2,
    comment: 'Może się okazać, że chętni na jedną z metodyk będą tak liczni, że warto ich podzielić na dwie osobne grupy - dlatego warto wydrukować dwa razy.'
);

KonspektMaterial material_zal_scenariusze = KonspektMaterial(
    name: 'Wydrukowany załącznik “$attach_title_scenariusze”',
    attachmentName: attach_name_scenariusze,
    additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
    amount: 1
);

KonspektMaterial material_zal_przypinki = KonspektMaterial(
    name: 'Przypinki z logiem warsztatów',
    amountAttendantFactor: 1
);

Konspekt struktura_i_ksztaltowanie_duchowosci = Konspekt(
  name: konspekt_kszt_name_struktura_i_ksztaltowanie_duchowosci,
  title: konspekt_kszt_title_struktura_i_ksztaltowanie_duchowosci,
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
      attach_o_strukturze_i_ksztaltowaniu_duchowosci,
      attach_poziomy_duchowosci,
      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,

      attach_przyklady_poziomow_duchowosci,
      ...konspekt_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci.attachments!,
      attach_scenariusz_fantomowe_dzialania_wychowawcze,
      attach_formy,
      attach_planowanie_strategii_i_dzialan,
      attach_scenariusze
    ],
    materials: [

      material_poradnik_o_strukturze_i_ksztaltowaniu_duchowosci,

      material_identyfikator,

      material_dlugopis,

      material_notatnik,

      material_nozyczki,

      material_mini_kartki_biurowe,

      material_kartka_a4,

      material_flipchart,

      material_marker,

      material_obiad,

      material_przekaski,

      material_miski_na_przekaski,

      material_herbata,

      material_kubek,

      material_czajnik,

      material_zal_poziomy_duchowosci,

      material_zal_przyklady_poziomow_duchowosci,

      material_zal_neutralnosc_duchowa_przyklady,

      material_zal_cel_wychowania_duchowego_zhp_statut,

      material_zal_cel_wychowania_duchowego_zhp_uchwala,

      material_zal_kratka_minimow_rozwoju_duchowego,

      ...konspekt_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci.materials!,

      material_zal_scenariusz_fantomowe_dzialania_wychowawcze,

      material_zal_formy,

      material_zal_planowanie_strategii_i_dzialan,

      material_zal_scenariusze,

      material_zal_przypinki,

    ],
    steps: [

      KonspektStep(
          title: 'Przyjście i ogarnięcie się',
          duration: Duration(minutes: 20),
          required: false,
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Nim rozpocznie się właściwa część warsztatów, warto pozwolić uczestnikom przyjść, zrobić hebratę i porozmawiwać o głupotach.'
              '</p>'
      ),

      KonspektStep(
          title: 'Rozpoczęcie',
          duration: Duration(minutes: 30),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozdaje uczestnikom <b>identyfikatory</b>, <b>długopisy</b> i <b>notatniki</b> (uczestnicy mogą tam zapisywać swoje wnioski i myśli z warsztatów). Na identyfikatorach uczestnicy wypisują swoje imię i zawieszają na szyi lub przypinają je na ubraniu.'
              '<br>'
              '<br>Następnie, w kręgu, uczestnicy się <b>przedstawiają</b> - jako ostatni przedstawia się prowadzący. W ramach przedstawienia prowadzący prosi, by każdy uczestnik odpowiedział na następujące zagadnienia:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Co robię w harcerstwie?</p></li>'
              '<li><p style="text-align:justify;">Jakie mam harcerskie doświadczenie z duchowością i religią?</p></li>'
              '<li><p style="text-align:justify;">Słowo lub fraza - skojarzenie z duchowością.</p></li>'
              '</ol>'

              '<p style="text-align:justify;">'
              'Uczestnicy zapisują przedstawione frazy (skojarzenia z duchowością) na <b>mini-kartkach</b>, które następnie są umieszczane na wspólnej, widocznej przestrzeni.'
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
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący informuje uczestników o celu warsztatów:'
              '<br>'
              '<br><b><i>Warsztaty nie służą indywidualnej pracy nad duchowością uczestników. Służą opisaniu i zrozumieniu natury rozwoju duchowego, jego zasad, pojęciom z nim związanych oraz nabyciu kompetencji pracy z duchowością harcerzy w drużynach.</i></b>'
              '<br>'
              '<br>Warsztaty dzielą się na trzy części:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Pojęcia i opis rozwoju duchowego - forma statyczna.</p></li>'
              '<li><p style="text-align:justify;">Duchowość w kontekście wychowania harcerskiego - forma dyskusyjna.</p></li>'
              '<li><p style="text-align:justify;">Praca z duchowością w poszczególnych metodykach - forma pracy w małych grupach.</p></li>'
              '</ol>',
      ),

      step_poziomy_duchowosci,

      step_poziomy_duchowosci_aksjomat,

      KonspektStep(
          title: 'Poziomy (warstwy) rozwoju duchowego - sprawdzenie',
          duration: Duration(minutes: 15),
          activeForm: true,
          required: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący dzieli uczestników na pięć grup. Rozdaje każdej grupie po jednym komplecie przygotowanych kartek z załącznika $attach_html_przyklady_poziomow_duchowosci i prosi grupy o <b>posegregowanie kartek na zachowania, postawy, wartości i aksjomaty.</b>'
              '<br>'
              '<br>Gdy dana grupa jest gotowa, zgłasza się do prowadzącego, który podchodzi i sprawdza. Jeśli coś jest nie tak, prowadzący mówi który poziom duchowości wymaga poprawy. Gdy wszystkie grupy są gotowe, niezależnie od poprawności segregacji, prowadzący omawia na forum poprawne przyporządkowanie.'
              '</p>',
          materials: [
            material_zal_przyklady_poziomow_duchowosci,
          ]
      ),

      step_integracja_duchowosci,

      step_duchowosc_powszechna_madrosc_kultura_i_tradycja,

      step_duchowosc_religia_religijnosc_opinie_uczestnikow,

      step_duchowosc_religia_religijnosc,

      KonspektStep(
          title: 'Przerwa',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
              '</p>'
      ),

      // Neutralność

      step_neutralnosc_duchowa,

      step_neutralnosc_duchowa_w_przypadku_problemow,

      step_harcerstwo_analogia_do_ogrodnikow,

      step_zrodla_wartosci_w_zhp_dyskusja_o_scenariuszach,

      step_zrodla_wartosci_w_zhp_okreslonosc_wartosci,

      step_zrodla_wartosci_w_zhp_aksjoamty,

      step_neutralnosc_podsumowanie,

      KonspektStep(
          title: 'Obiad',
          duration: Duration(minutes: 45),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Najlepiej już wcześniej zamówić pizzę, żeby jedzenie trwało niewiele czasu i by można było po nim chwilę odpocząć.'
              '</p>',
          materials: [
            material_obiad,
          ]
      ),

      ...konspekt_kszt_czynniki_i_mechanizmy_ksztaltowania_duchowosci.steps!.map((step) => step.copyWithNamePrefix('Czynniki duchowości - ')).toList(),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - kratka i formy',
          duration: Duration(minutes: 45),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Uczestnicy otrzymują w grupach po jednym załączniku $attach_html_kratka_minimow_rozwoju_duchowego. Otrzymują również wydrukowane i wycięte formy z załącznika $attach_html_formy.'
              '<br>'
              '<br>Na podstawie zdobytej dotychczas wiedzy oraz załącznika $attach_html_kratka_minimow_rozwoju_duchowego, zadaniem uczestników jest przyporządkowanie poszczególnych form do <b>grupy</b> lub <b>grup wiekowych</b>, określenie jakie <b>poziomy duchowości</b> rozwijają oraz, jeśli to możliwe, w jaki <b>mechanizm</b> wykorzystują.'
              '<br>'
              '<br>Warto uczestników podzielić na grupy po 3-4 osoby, aby jak najbardziej zaangażować ich w dyskusję nad formami.'
              '</p>',
          materials: [
            material_zal_kratka_minimow_rozwoju_duchowego,
            material_zal_formy,
          ]
      ),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - kratka i formy - podsumowanie',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący zbiera na powrót wszystkie grupy w jedno miejsce i prosi, by każda z grup przestawiła po kilka wybranych form które:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Najbardziej przypadły im do gustu.</p></li>'
              '<li><p style="text-align:justify;">Najbardziej ich zaskoczyły.</p></li>'
              '<li><p style="text-align:justify;">Wydały im się najbardziej kontrowersyjne.</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Prowadzący może skorzystać z okazji, po przedstawieniu najbardziej kontrowesyjnych form zauważyć, że harcerstwo opiera się na <b>wychowaniu poprzez stawianie wyzwań</b> i nie należy się łudzić, że można wychować kogoś w ciągłym, bezgranicznym bezpieczeństwie i komforcie. Lepiej, aby rozwój duchowy zakładał budowanie odporności na trudy i nieprzyjemne sytuacje, niż od nich izolował - harcerstwo nie wychowuje <b>pod kloszem</b>.'
              '</p>'
      ),

      KonspektStep(
          title: 'Fantomowe działania wychowawcze i skuteczność wychowawcza',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący prezentuje krótki opis obozu drużyny z załącznika $attach_html_scenariusz_fantomowe_dzialania_wychowawcze i podejmowanych tam działań duchowych, które są zupełnie losowe. Na tej podstawie zapoczątkowuje krótką dyskusję zadając pytanie: “co jest nie tak z tą strategią?”. Po krótkiej wymianie opinii prowadzący odpowiada wprowadzając pojęcie “<b>fantomowych działań wychowawczych</b>”.'
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

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - podział na grupy',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Uczestnicy w grupach są dzieleni na 4 grupy. Każda grupa otrzymuje krótki opis drużyny z załącznika $attach_html_planowanie_strategii_i_dzialan. Zadaniem każdej grupy jest stworzyć plan rozwoju duchowego jednostki.'
              '<br>'
              '<br>Każda z opisanych na karce drużyn jest w innej metodyce (Z, H, HS, W). Prowadzący może podzielić uczestników tak, by każdy był w grupie pracującej nad metodyką, która jest uczestnikom najbliższa.'
              '<br>'
              '<br>Na początku prowadzący prosi każdą z grup, by zapoznałą się z opisami.'
              '</p>',
          materials: [
            material_zal_planowanie_strategii_i_dzialan,
          ]
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - cele',
          duration: Duration(minutes: 15),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący prosi każdą z grup, by wskazała, jakie <b>cele w pracy duchowej</b> chce osiągnąć dla opisanej drużyny. Należy założyć, że praca z opisaną grupą bedzie trwała 3 lata.'
              '</p>',
          materials: [
            material_zal_planowanie_strategii_i_dzialan,
          ]
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - czynniki duchowości',
          duration: Duration(minutes: 15),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący prosi każdą z grup, by wskazała mechanizmy oparte o trzy czynniki duchowości, za pomocą których można zrealizować wyłonione uprzednio cele.'
              '<br>'
              '<br>Wszystkie czynniki duchowości powinny być wyłożone w widocznym miejscu na kartkach z załącznika $material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci.'
              '<br>'
              '<br>Na tym etapie zadaniem grup <b>nie jest wymyślanie żadnych zajęć</b> dla harcerzy. Chodzi o podjęcie działania w stylu: <i>przekonanie rodziców zuchów, aby do 14 roku życia miały one na wyłączność dostęp tylko do prostych telefonów bez funkcji dotykowych, aby zwiększyć częstotliwość ich interakcji z niecyfrowym światem, który stawia większe wyzwania.</i>'
              '<br>'
              '<br>Prowadzący może zasugerować, by grupy skoncentrowały się na następujących czynnikach:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Przykład własny autorytetów</p></li>'
              '<li><p style="text-align:justify;">Oczekiwania uznanych autorytetów</p></li>'
              '<li><p style="text-align:justify;">Normy</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Jeżeli jednak grupy uznają, że są w stanie wykorzystać inne czynniki do osiągnięcia celów, mogą ich użyć.'
              '<br>'
              '<br>Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
              '</p>',
          materials: [
            material_zal_planowanie_strategii_i_dzialan,
            material_zal_poradnik_czynniki_i_mechanizmy_ksztaltowania_duchowosci,
          ]
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - omówienie postępu prac',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący zbiera na chwilę w jedno miejsce wszystkich uczestników i prosi każdą z grup, by przedstawiła swoje opisane cele, wybrane czynniki duchowości i mechanizmy kształtowania duchowości. Po każdej z prezentacji może się odbyć krótka dyskusja nad planami.'
              '<br>'
              '<br>Ten punkt służy temu, aby prowadzący miał możliwość zareagować, jeśli któraś z grup zacznie błądzić w założeniach.'
              '</p>'
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - działania bezpośrednie',
          duration: Duration(minutes: 20),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący prosi każdą z grup, by jako ostatni element planowania strategii rozwoju duchowego wskazała <b>działania śródroczne</b> i <b>działania obozowe</b> z uwzględnieniem <b>niedzieli na obozie</b>. Można się w tym celu posiłkować pomysłami z załącznika $attach_html_formy, które są dostępne w apliakcji <b>HarcApp</b>.'
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
          title: 'Planowanie strategii rozwoju duchowego - prezentacja',
          duration: Duration(minutes: 40),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Każda z grup ma kilka minut, aby <b>zaprezentować</b> swoje strategie i działania.'
              '<br>'
              '<br>Po każdej z prezentacji może się odbyć krótka dyskusja nad planami - prowadzący powinien zachęcać do krytyki, jeżeli ktoś się z czymś nie zgadza.'
              '</p>'
      ),

      KonspektStep(
          title: 'Niedziela na obozie',
          duration: Duration(minutes: 20),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zanotowawszy plany i strategie rozwoju duchowego związane z niedzielą obozową prezentowane w poprzednim punkcie przez grupy podsumowuje je. Uczestnicy mają możliwość dodania proponowanych form - ważne, by prowadzący prosił o podanie mechanizmu ich działania.'
              '<br>'
              '<br>Na końcu prowadzący uzupełnia zbiorczy plan niedzieli o elementy obecne w formie <i>“Msza (obozowa, lecz nie tylko)”</i> z załącznika $attach_html_formy i krótko je omawia.'
              '</p>'
      ),

      KonspektStep(
          title: 'Scenariusze w grupach',
          duration: Duration(minutes: 40),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący dzieli uczestników na grupy po ok. 4 osób. Każda z grup otrzymuje po 2-4 scenariusze z $attach_html_scenariusze i w swoim gronie je omawia. Celem omówienia każdego scenariusza jest zaproponowanie rozwiązania zgodnego z harcerskimi celami wychowania duchowego. Na jeden scenariusz grupa powinna poświęcić 10-15 min. Ważne, by prowadzący zaznaczył, że <b>grupy nie muszą osiągnąć jednomyślności</b>.'
              '<br>'
              '<br>Po zakończeniu dyskusji grupy referują scenariusze i wnioski z nich płynące na forum wszystkich uczestników. Jeżeli któryś scenariusz zakończył się różnicą stanowisk dyskutujących, może zostać poruszony wspólnie przez wszystkich uczestników.'
              '<br>'
              '<br><i>Prowadzący, w przypadku gdy zaczyna brakować czasu, może skrócić czas tej formy</i>.'
              '</p>',
        materials: [
          material_zal_scenariusze,
        ]
      ),

      step_szybkie_strzaly_dyskusyjne,

      KonspektStep(
          title: 'Podsumowanie warsztatów',
          duration: Duration(minutes: 20),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący zaprasza uczestników do wspólnego kręgu w celu podsumowania warsztatów. Przy tej okazji warto skupić się na następujących rzeczach:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Rozdanie dyplomów i przypinek uczestnikom.</p></li>'
              '<li><p style="text-align:justify;">Poproszenie uczestników o podzielenie się wrażeniami związanymi z warsztatami.</p></li>'
              '<li><p style="text-align:justify;">Prośba o uzupełnienie szczegółowej ankiety ewaluacyjnej - przesłanie jej uczestnikom na maila.</p></li>'
              '<li><p style="text-align:justify;">Wspólne zdjęcie.</p></li>'
              '<li><p style="text-align:justify;">Oddanie indetyfikatorów przez uczestników.</p></li>'
              '</ul>'
      ),

    ]
);