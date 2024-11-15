import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import 'common_wychowanie_duchowe.dart';


const konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci = 'struktura_i_ksztaltowanie_duchowosci';
const konspekt_harc_title_struktura_i_ksztaltowanie_duchowosci = 'Struktura i kształtowanie duchowości';


const String attach_html_przyklady_poziomow_duchowosci = '<a href="$attach_name_przyklady_poziomow_duchowosci@attachment">$attach_title_przyklady_poziomow_duchowosci</a>';
const String attach_name_przyklady_poziomow_duchowosci = 'przyklady_poziomow_duchowosci';
const String attach_title_przyklady_poziomow_duchowosci = 'Przykłady poziomów duchowości';
KonspektAttachment attach_przyklady_poziomow_duchowosci = KonspektAttachment(
  name: attach_name_przyklady_poziomow_duchowosci,
  title: attach_title_przyklady_poziomow_duchowosci,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_przyklady_poziomow_duchowosci.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_przyklady_poziomow_duchowosci.docx',
  },
);

const String attach_html_mechanizmy_posrednie = '<a href="$attach_name_mechanizmy_posrednie@attachment">$attach_title_mechanizmy_posrednie</a>';
const String attach_name_mechanizmy_posrednie = 'mechanizmy_posrednie';
const String attach_title_mechanizmy_posrednie = 'Mechanizmy pośrednie';
KonspektAttachment attach_mechanizmy_posrednie = KonspektAttachment(
  name: attach_name_mechanizmy_posrednie,
  title: attach_title_mechanizmy_posrednie,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_mechanizmy_posrednie.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_mechanizmy_posrednie.docx',
  },
);

const String attach_html_scenariusz_fantomowe_dzialania_wychowawcze = '<a href="$attach_name_scenariusz_fantomowe_dzialania_wychowawcze@attachment">$attach_title_scenariusz_fantomowe_dzialania_wychowawcze</a>';
const String attach_name_scenariusz_fantomowe_dzialania_wychowawcze = 'scenariusz_fantomowe_dzialania_wychowawcze';
const String attach_title_scenariusz_fantomowe_dzialania_wychowawcze = 'Scenariusz fantomowe działania wychowawcze';
KonspektAttachment attach_scenariusz_fantomowe_dzialania_wychowawcze = KonspektAttachment(
  name: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
  title: attach_title_scenariusz_fantomowe_dzialania_wychowawcze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusz_fantomowe_dzialania_wychowawcze.docx',
  },
);

const String attach_html_formy = '<a href="$attach_name_formy@attachment">$attach_title_formy</a>';
const String attach_name_formy = 'formy';
const String attach_title_formy = 'Formy';
KonspektAttachment attach_formy = KonspektAttachment(
  name: attach_name_formy,
  title: attach_title_formy,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_formy.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_formy.docx',
  },
);

const String attach_html_planowanie_strategii_i_dzialan = '<a href="$attach_name_planowanie_strategii_i_dzialan@attachment">$attach_title_planowanie_strategii_i_dzialan</a>';
const String attach_name_planowanie_strategii_i_dzialan = 'planowanie_strategii_i_dzialan';
const String attach_title_planowanie_strategii_i_dzialan = 'Planowanie strategii i działań';
KonspektAttachment attach_planowanie_strategii_i_dzialan = KonspektAttachment(
  name: attach_name_planowanie_strategii_i_dzialan,
  title: attach_title_planowanie_strategii_i_dzialan,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_planowanie_strategii_i_dzialan.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_planowanie_strategii_i_dzialan.docx',
  },
);

const String attach_html_scenariusze = '<a href="$attach_name_scenariusze@attachment">$attach_title_scenariusze</a>';
const String attach_name_scenariusze = 'scenariusze';
const String attach_title_scenariusze = 'Scenariusze';
KonspektAttachment attach_scenariusze = KonspektAttachment(
  name: attach_name_scenariusze,
  title: attach_title_scenariusze,
  assets: {
    FileFormat.pdf: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusze.pdf',
    FileFormat.docx: 'ksztalcenie/$konspekt_harc_name_struktura_i_ksztaltowanie_duchowosci/$attach_name_scenariusze.docx',
  },
);



Konspekt struktura_i_ksztaltowanie_duchowosci = Konspekt(
  name: 'struktura_i_ksztaltowanie_duchowosci',
  title: 'Struktura i kształtowanie duchowości',
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
      attach_mechanizmy_posrednie,
      attach_scenariusz_fantomowe_dzialania_wychowawcze,
      attach_formy,
      attach_planowanie_strategii_i_dzialan,
      attach_scenariusze
    ],
    materials: [

      KonspektMaterial(
        name: 'Dostępny do przygotowania merytorycznego poradnik “$attach_title_o_strukturze_i_ksztaltowaniu_duchowosci”',
        attachmentName: attach_name_o_strukturze_i_ksztaltowaniu_duchowosci,
      ),

      KonspektMaterial(
        name: 'Duży arkusz papieru (flipchart)',
        amount: 1,
      ),

      KonspektMaterial(
        name: 'Identyfikator',
        amountAttendantFactor: 1,
      ),

      KonspektMaterial(
        name: 'Długopis',
        amountAttendantFactor: 1,
      ),

      KonspektMaterial(
        name: 'Notatnik',
        amountAttendantFactor: 1,
      ),

      KonspektMaterial(
        name: 'Kartka A4',
        amount: 50,
      ),

      KonspektMaterial(
        name: 'Marker',
        amount: 5,
      ),

      KonspektMaterial(
        name: 'Nożyczki',
        amount: 2,
      ),

      KonspektMaterial(
        name: 'Obiad',
        amountAttendantFactor: 1,
      ),

      KonspektMaterial(
        name: 'Przekąski (jabłka, marchewki, ciastka)',
      ),

      KonspektMaterial(
        name: 'Miski na przekąski',
        amount: 3
      ),

      KonspektMaterial(
        name: 'Herbata',
      ),

      KonspektMaterial(
        name: 'Kubek',
        amountAttendantFactor: 1,
      ),

      KonspektMaterial(
        name: 'Czajnik',
        amount: 1,
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_poziomy_duchowosci”',
          attachmentName: attach_name_poziomy_duchowosci,
          amount: 1
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_przyklady_poziomow_duchowosci”',
        attachmentName: attach_name_przyklady_poziomow_duchowosci,
        additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii i potasować w ramach wyciętych czwórek.',
        amount: 1
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_mechanizmy_posrednie”',
          attachmentName: attach_name_mechanizmy_posrednie,
          additionalPreparation: 'Kartki należy przeciąć na pół wzdłuż przerywanych linii.',
          amount: 1
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_scenariusz_fantomowe_dzialania_wychowawcze”',
          attachmentName: attach_name_scenariusz_fantomowe_dzialania_wychowawcze,
          additionalPreparation: 'Kartkę należy przeciąć na pół wzdłuż przerywanych linii.',
          amount: 1
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_formy”',
        attachmentName: attach_name_formy,
        additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
        amount: 1
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_planowanie_strategii_i_dzialan”',
          attachmentName: attach_name_planowanie_strategii_i_dzialan,
          amount: 2,
          comment: 'Może się okazać, że chętni na jedną z metodyk będą tak liczni, że warto ich podzielić na dwie osobne grupy - dlatego warto wydrukować dwa razy.'
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_scenariusze”',
        attachmentName: attach_name_scenariusze,
        additionalPreparation: 'Kartki należy wyciąć wzdłuż przerywanych linii.',
        amount: 1
      ),

      KonspektMaterial(
          name: 'Przypinki z logiem warsztatów',
          amountAttendantFactor: 1
      ),

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
              'Uczestnicy zapisują przedstawione frazy (skojarzenia z duchowością) na mini-kartkach, które następnie są umieszczane na wspólnej, widocznej przestrzeni.'
              '</p>'
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
              '</ol>'
      ),

      step_poziomy_duchowosci,

      KonspektStep(
          title: 'Poziomy duchowości - sprawdzenie',
          duration: Duration(minutes: 15),
          activeForm: true,
          required: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący dzieli uczestników na pięć grup. Rozdaje każdej grupie po jednym komplecie przygotowanych kartek z załącznika $attach_html_przyklady_poziomow_duchowosci i prosi grupy o <b>posegregowanie kartek na zachowania, postawy, wartości i aksjomaty.</b>'
              '<br>'
              '<br>Gdy dana grupa jest gotowa, zgłasza się do prowadzącego, który podchodzi i sprawdza. Jeśli coś jest nie tak, prowadzący mówi który poziom duchowości wymaga poprawy. Gdy wszystkie grupy są gotowe, niezależnie od poprawności segregacji, prowadzący omawia na forum poprawne przyporządkowanie.'
              '</p>'
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
              '</p>'
      ),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - mechanizmy pośrednie',
          duration: Duration(minutes: 20),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący zaczyna od zadania oczywistego pytania:'
              '<br>'
              '<br><b><i>“Czyli tak: ustaliliśmy czym jest duchowość, jej poziomy i jej integracja, cel wychowania duchowego w ZHP - czyli wystarczy teraz powiedzieć zuchom jakie postawy, harcerzom jakie wartości, a wędrownikom jakie aksjomaty są dobre i essa? Co nie? Czy nie?”</i></b>'
              '<br>'
              '<br>Oczywiście ta propozycja jest absurdalna - celem jest rozpoczęcie dyskusji prowadzącej do wniosku, że od różnych pionów należy oczekiwać różnych celów w rozwoju duchowym.'
              '<br>'
              '<br><b><i>“Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje.”</i></b>'
              '<br>'
              '<br>Prowadzący zwraca uwagę, że wychowanie duchowe zaczyna się od sposobu myślenia. Przedstawia trzy punkty wyjścia i przy omawianiu każdego kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $attach_html_mechanizmy_posrednie.'
              '</p>'

              '<ol>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Duchowość jest najważniejszą sferą człowieka</b>.'
              '<br>Nadaje sens każdemu działaniu.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Nie istnieje próżnia duchowa</b>.'
              '<br>Jeśli duchowości nie ukształtuja rodzice, harcerstwo, czy Kościół, to zrobi to ulica, reklamy i internet.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>Duchowość nie jest sprawą prywatną. Nie należy jej cenzurować.</b>'
              '<br>Duchowość jest sprawą indywidualną i osobistą, ale dotyczy całego otoczenia, w którym człowiek żyje.'
              '</p>'
              '</li>'
              '</ol>'

              '<p style="text-align:justify;">'
              'Następnie prowadzący przedstawia <b>mechanizmy pośrednie</b>, które wpływają na duchowość. W celu wejścia w interakcję z uczestnikami przedstawia krótkie scenariusze na podstawie których uczestnicy powinni wywnioskować określony mechanizm (podobnie jak poprzednio, gdy uczestnicy poprawnie nazwą mechanizm, prowadzący kładzie w widocznym miejscu odpowiadającą mu kartkę z załącznika $attach_html_mechanizmy_posrednie):'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Przykład własny kadry]</b>'
              '<br>'
              '<br><i>Mamy harcerza z domu, gdzie poruszenie tematu światopoglądowego lub politycznego zawsze kończy się gigantyczną kłótnią. Chcemy wychować go w przekonaniu, że warto wyrażać swoje zdanie oraz dyskutować na ważne sprawy, zwłaszcza dotyczące Polski, geopolityki, społeczeństwa i wiary. Czy jeżeli ów harcerz będzie świadkiem jak jego drużynowy prowadzi takie dyskusje ze swoimi kumplami z kadry szczepu, to czy pomoże to w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Wpływ rodziców]</b>'
              '<br>'
              '<br><i>Mamy harcerza, którego chcemy wychować w sumienności i odpowiedzialności za powierzone mu zadania. Kadra drużyny robi w tym kierunku ile może, ale gdy młody wraca do domu, rodzice za niego sprzątają, gotują mu i pozwalają mu nie robić zadań domowych gdy mówi, że jest zmęczony. Czy doprowadzenie do sytuacji w której rodzice zaczynają koordynować swoje działania tym aspekcie wychowania z kadrą drużyny pomoże  w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Wzajemność oddziaływań]</b>'
              '<br>'
              '<br><i>Mamy harcerza z blokowisk z Łódzkiego Widzewa. Jego typowi koledzy albo siedzą w domu i grają na kompie, albo chodzą na mecze, organizują ustawki, dealują marychą i piją wódkę za szkołą. Chcemy wychować go w duchu szacunku dla prawa. Czy zwiększenie wśród jego bliskich znajomych liczby osób, które szanują prawo w tym pomoże, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Wspólnota zasad, wspólnota wartości i wspólnota aksjomatu]</b>'
              '<br>'
              '<br><i>Mamy białoruskiego, prawosławnego harcerza, którego najbliższe otoczenie (poza rodziną) jest laickie. Chcemy wychować go w wierze prawosławnej. W harcerstwie część wartości i postaw jest z jego wiarą zgodna, część niekoniecznie. Czy sprawienie, że pozna i polubi ludzi z prawosławnego duszpasterstwa w cerkwii i będzie częścią ich wspólnoty pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Kultura, media i technologia]</b>'
              '<br>'
              '<br><i>Mamy harcerskę starszą, która od kiedy poszła do technikum zaczęła tak jak jej nowe koleżanki oglądać Netflixa, oglądać kiczowate reality-show typu “Trudne sprawy” i słuchać depresyjnej muzyki - w szkole idzie jej średnio, marnuje dużo czasu na fejsie i Tick-Tock. Chcemy wychować ją do postawy pozytywnego myślenia, zaradności i sumienności. Czy sprawienie, że z Netflixa i “Trudnych spraw” przerzuci się na “Ojca Mateusza” i “Pingwiny z Madagaskaru", drużyna zainspiruje ją szantami, T.Love i Kaczmarskim, a w miejsce fejsa i tik-toka zacznie czytać Dukaja pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
              '</p>'
              '</li>'

              '</ul>'

              '<p style="text-align:justify;">'
              'Jako ostatni element, już bez scenariusza, prowadzący opisuje zjawisko "<b>trzeciego miejsca</b>", z którym wychowanek może być zwiazany, które może budować jego tożsamość, które nie jest ani jego pracą (obowiazkiem), ani jego domem. Miejscem takim może być wspólnota religijna, drużyna, zespół muzyczny, czy hipisowski skłot.'
              '<br>'
              '<br>Na końcu prowadzący może dodać, że wszystkie te mechanizmy nie są wzięte z sufitu - są obecne w <b>stopniach harcerskich</b>.'
              '</p>'
      ),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - Opowieść Przewodnia',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący opisuje ostatni pośredni mechanizm kształtowania duchowości, czyli <b>Opowieść Przewodnią</b> na podstawie poradnika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci. Podobnie jak w przypadku poprzednich mechanizmów, do pozostałych dodaje przy tym odpowiadającą kartkę z załącznika $attach_html_mechanizmy_posrednie'
              '<br>'
              '<br><i>Opowieść Przewodnia jest szczególnie silnym mechanizmem w momencie <b>rozpoczęcia integracji świadomej</b>, jednak gra rolę także później. Jest to opowieść, nadająca człowiekowi tożsamość, sens i cel.'
              '<br>'
              '<br>Na przykład:</i>'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;"><i>“Bóg umarł z miłości do każdego człowieka. Za mnie także. Tego doświadczenia raz poznanego nie da się zakopać - jest tak głębokie i dojmujące, że muszę się nim podzielić z każdym człowiekiem.”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Jesteśmy na skraju katastrofy klimatycznej - jeżeli nie zrobimy czegoś natychmiast, cały świat spłonie i na Ziemi nie będzie się dało dłużej żyć. Muszę działać. Natychmiast.”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Jestem Polakiem. Spadkobiercą tysiącletniego narodu i wielo-tysiącletniej cywilizacji judeo-chrześcijańskiej. Potomkiem poległych w obronie ojczyzny mężów i kobiet. Muszę od siebie wymagać, by kiedyś dźwignąć naszą polską, poszarpaną państwowość - w obecnej sytuacji geopolitycznej to jest być albo nie być polskiego narodu.”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Społeczeństwo jest rasistowskie, mizoginiczne i homofobiczne do szpiku kości. Codziennie przez falę hejtu i działań eksterminacyjnych giną niewinne kobiety, geje, osoby trans i inni ludzie LGBTQIAP2+. Muszę coś z tym zrobić. Muszę manifestować, zmienić język, obalić patriarchat i heteronormatywność, zmienić społeczeństwo nawet jeśli oznaczałoby to poświęcenie temu całego swojego życia. Krew się leje w tym momencie.”</i></p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Prowadzący zwraca uwagę, że harcerstwo też może nosić znaczenie Opowieści Przewodniej, szczególnie dla młodej kadry i instruktorów, którzy wierzą, że na ich barkach spoczywa wychowanie i szczęście młodych ludzi.'
              '<br>'
              '<br>Warto także zwrócić uwagę, że harcerstwo może nosić znamiona subkutlury: ma swoje obrzędy, symbole, wartości i ścisłe gorono. Widać to przykładowo po harcerzach, którzy chodzą na każdą zbiórkę, jeżdżą na każdy wyjazd, uczą się po nocach grać Kaczmarskiego na gitarze, a do szkoły w bojówkach i harcerskim pasie. Owo zaangażowanie i tożsamość może być niezwykle efektywnym mechanizmem kształtowania duchowości.'
              '</p>'
      ),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - kratka',
          duration: Duration(minutes: 45),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Wstęp - przedstawienie tego jakie cechy mogą spełniać poszczególne formy.'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Hartowanie ducha</p></li>'
              '<li><p style="text-align:justify;">Kształtowanie postaw</p></li>'
              '<li><p style="text-align:justify;">Kształtowanie wartości (normalizacja, wartości wtórne)</p></li>'
              '<li><p style="text-align:justify;">Kształtowanie aksjomatów</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Uczestnicy otrzymują w grupach po jednym załączniku $attach_html_kratka_minimow_rozwoju_duchowego.'
              '<br>'
              '<br>Otrzymują również wydrukowane i wycięte formy z załącznika $attach_html_formy. Na tej podstawie ich zadaniem jest przyporządkowanie poszczególnych form do grupy lub <b>grup wiekowych</b> oraz do określenia jakie <b>poziomy duchowości</b> rozwijają oraz, jeśli to możliwe, w jaki <b>mechanizm</b> wykorzystują.'
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
              '</p>'
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - podział na grupy',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Uczestnicy w grupach są dzieleni na 4 grupy. Każda grupa otrzymuje krótki opis drużyny z załącznika $attach_html_planowanie_strategii_i_dzialan. Zadaniem każdej grupy jest stworzyć plan rozwoju duchowego jednostki.'
              '<br>'
              '<br>Każda z opisanych na karce drużyn jest w innej metodyce (Z, H, HS, W). Prowadzący może podzielić uczestników tak, by każdy był w grupie pracującej nad metodyką, która jest uczestnikom najbliższa.'
              '<br>'
              '<br>Na początku prowadzący prosi każdą z grup, by zapoznałą się z opisami.'
              '</p>'
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - cele',
          duration: Duration(minutes: 15),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący prosi każdą z grup, by wskazała, jakie <b>cele w pracy duchowej</b> chce osiągnąć dla opisanej drużyny. Należy założyć, że praca z opisaną grupą bedzie trwała 3 lata.'
              '</p>'
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - mechanizmy pośrednie',
          duration: Duration(minutes: 20),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący prosi każdą z grup, by skupiła się na trzech mechanizmach pośrednich i aby grupy wskazały, jakie działania, zwyczaje, czy normy należy podjąć lub wprowadzić, aby zrealizować wyłonione uprzednio cele.'
              '<br>'
              '<br>Wszystkie mechanizmy pośrednie powinny być wyłożone w widocznym miejscu na kartkach z załącznika $attach_html_mechanizmy_posrednie.'
              '<br>'
              '<br>Na tym etapie zadaniem grup <b>nie jest wymyślanie żadnych zajęć</b> dla harcerzy. Chodzi o podjęcie działania w stylu: <i>przekonanie rodziców zuchów, aby do 14 roku życia miały one na wyłączność dostęp tylko do prostych telefonów bez funkcji dotykowych, aby zwiększyć częstotliwość ich interakcji z niecyfrowym światem, który stawia większe wyzwania.</i>'
              '<br>'
              '<br>Prowadzący może zasugerować, by grupy skoncentrowały się na następujących mechanizmach:'
              '</p>'

              '<ul>'
              '<li><p style="text-align:justify;">Wpływ rodziców na harcerzy</p></li>'
              '<li><p style="text-align:justify;">Wpływ osobistego przykładu kadry na harcerzy</p></li>'
              '<li><p style="text-align:justify;">Wpływ kultury, mediów i technologii na harcerzy</p></li>'
              '</ul>'

              '<p style="text-align:justify;">'
              'Jeżeli jednak grupy uznają, że są w stanie wykorzystać inne mechanizmy do osiągnięcia celów, mogą ich użyć.'
              '<br>'
              '<br>Jeżeli w ramach grup pojawi się konflikt poglądów, który nie zostanie ujednolicony wskutek dyskusji, należy zachować wszystkie perspektywy do późniejszego ich omówienia na forum.'
              '</p>'
      ),

      KonspektStep(
          title: 'Planowanie strategii rozwoju duchowego - omówienie postępu prac',
          duration: Duration(minutes: 10),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący zbiera na chwilę w jedno miejsce wszystkich uczestników i prosi każdą z grup, by przedstawiła swoje opisane cele i mechanizmy pośrednie. Po każdej z prezentacji może się odbyć krótka dyskusja nad planami.'
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
              '</p>'
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
              '</p>'
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