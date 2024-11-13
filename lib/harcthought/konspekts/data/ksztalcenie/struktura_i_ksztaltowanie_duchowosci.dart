import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import 'common_wychowanie_duchowe.dart';

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
      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,
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

      // TODO: add more materials
    ],
    steps: [

      KonspektStep(
          title: 'Przyjście i ogarnięcie się',
          duration: Duration(minutes: 20),
          required: false,
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Nim rozpocznie się właściwa część warsztatów, prowadzący pozwala uczestnikom przyjść, zrobić hebratę i porozmawiwać o głupotach.'
              '</p>'
      ),

      KonspektStep(
          title: 'Rozpoczęcie',
          duration: Duration(minutes: 30),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący rozdaje uczestnikom <b>identyfikatory</b>, <b>długopisy</b> i <b>notatniki</b> (notatniki są dla uczestników - mogą tam zapisywać swoje wnioski i myśli z warsztatów). Uczestnicy na identyfikatorach wypisują swoje imię i zawieszają na szyi lub przypinają je na ubraniu.'
              '<br>'
              '<br>Następnie, w kręgu, uczestnicy się <b>przedstawiają</b> - jako ostatni przedstawia się prowadzący formę. W ramach przedstawienia prowadzący prosi, by każdy uczestnik odpowiedział na następujące zagadnienia:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Co robię w harcerstwie?</p></li>'
              '<li><p style="text-align:justify;">Jakie mam harcerskie doświadczenie z duchowością i religią?</p></li>'
              '<li><p style="text-align:justify;">Słowo lub fraza - skojarzenie z duchowością.</p></li>'
              '</ol>'

              '<p style="text-align:justify;">'
              'Uczestnicy zapisują przedstawione frazy na mini-kartkach, które następnie są umieszczane na wspólnej, widocznej przestrzeni.'
              '</p>'
      ),

      KonspektStep(
          title: 'Oświadczenie wstępne',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący informuje uczestników o celu warsztatów:'
              '<br>'
              '<br><b><i>Warsztaty nie służą indywidualnej pracy nad duchowością uczestników. Służą próbie opisania i zrozumienia natury rozwoju duchowego, jej zasad, pojęciom z nią związanym oraz nabyciu kompetencji pracy duchowej w drużynach.</i></b>'
              '<br>'
              '<br>Warsztaty dzielą się na trzy części:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Pojęć i opis rozwoju duchowego - forma statyczna.</p></li>'
              '<li><p style="text-align:justify;">Duchowość w kontekście wychowania harcerskiego - forma dyskusyjna.</p></li>'
              '<li><p style="text-align:justify;">Praca z duchowością w poszczególnych metodykach - forma pracy w małych grupach.</p></li>'
              '</ol>'
      ),

      step_poziomy_duchowosci,

      KonspektStep(
          title: 'Poziomy duchowości - sprawdzenie',
          duration: Duration(minutes: 15),
          activeForm: false,
          required: false,
          content: '<p style="text-align:justify;">'
              'Na końcu prowadzący dzieli uczestników na około pięcioosobowe grupy. Rozdaje każdej grupie po jednym komplecie przygotowanych kartek z załącznika “przykłady poziomów duchowości” i prosi grupy o <b>posegregowanie kartek na zachowania, postawy, wartości i aksjomaty.</b>'
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
          activeForm: false,
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
              'Najlepiej zamówić pizzę, żeby jedzenie trwało niewiele czasu i by można było po nim chwilę odpocząć.'
              '</p>'
      ),

      KonspektStep(
          title: 'Praktyka wychowania duchowego - co pomaga?',
          duration: Duration(minutes: 10),
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
              '<br>Wychowanie duchowe zaczyna się od sposobu myślenia:'
              '</p>'

              '<ol>'
              '<li><p style="text-align:justify;">Duchowość jest najważniejszą sferą rozwoju - to ona nadaje sens i daje możliwość pełnego życia.</p></li>'
              '<li><p style="text-align:justify;">Nie istnieje próżnia wychowawcza. Jeśli duchowości nie przekażą dziecku rodzice, harcerstwo, czy Kościół, to zrobi to ulica, reklamy i internet.</p></li>'
              '<li><p style="text-align:justify;">Duchowość nie jest sprawą prywatną i nie należy jej cenzurować.</p></li>'
              '</ol>'

              '<p style="text-align:justify;">'
              'Prowadzący w celu wejścia w interakcję z uczestnikami przedstawia krótkie scenariusze na podstawie których uczestnicy powinni wywnioskować metody pośrednie:'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Przykład własny instruktora]</b>'
              '<br>'
              '<br><i>Mamy harcerza z domu, gdzie poruszenie tematu światopoglądowego lub politycznego zawsze kończy się gigantyczną kłótnią. Chcemy wychować go w przekonaniu, że warto wyrażać swoje zdanie oraz dyskutować na ważne sprawy, zwłaszcza dotyczące Polski, geopolityki, społeczeństwa i wiary. Czy jeżeli ów harcerz będzie świadkiem jak jego drużynowy prowadzi takie dyskusje ze swoimi kumplami z kadry szczepu, to czy pomoże to w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Rola rodziców]</b>'
              '<br>'
              '<br><i>Mamy harcerza, którego chcemy wychować w sumienności i odpowiedzialności za powierzone mu zadania. Kadra drużyny robi w tym kierunku ile może, ale gdy młody wraca do domu, rodzice za niego sprzątają, gotują mu i pozwalają mu nie robić zadań domowych gdy mówi, że jest zmęczony. Czy doprowadzenie do sytuacji w której rodzice zaczynają koordynować swoje działania tym aspekcie wychowania z kadrą drużyny pomoże  w osiągnięciu założonego celu wychowawczego, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Wzajemność oddziaływań]</b>'
              '<i>Mamy harcerza z blokowisk z Łódzkiego Widzewa. Chcemy wychować go w duchu szacunku dla prawa. Czy zwiększenie wśród jego bliskich znajomych liczby osób, które szanują prawo w tym pomoże, czy nie? Dlaczego?</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Wspólnota zasad, wspólnota wartości i wspólnota aksjomatu]</b>'
              'Mamy białoruskiego, prawosławnego harcerza, którego najbliższe otoczenie (poza rodziną) jest laickie. Chcemy wychować go w wierze prawosławnej. W harcerstwie część wartości i postaw jest z jego wiarą zgodna, część niekoniecznie. Czy sprawienie, że pozna i polubi ludzi z prawosławnego duszpasterstwa w cerkwii i będzie częścią ich wspólnoty pomoże w osiągnięciu celu wychowawczego? Dlaczego?'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              '<b>[Formy kultury]</b>'
              '<i>Mamy harcerskę starszą, która od kiedy poszła do technikum zaczęła tak jak jej nowe koleżanki oglądać Netflixa, oglądać kiczowate reality-show typu “Trudne sprawy” i słuchać depresyjnej muzyki - w szkole idzie jej średnio, marnuje dużo czasu na fejsie i Tick-Tock. Chcemy wychować ją do postawy pozytywnego myślenia, zaradności i sumienności. Czy sprawienie, że z Netflixa i “Trudnych spraw” przerzuci się na “Ojca Mateusza” i “Pingwiny z Madagaskaru", drużyna zainspiruje ją szantami, T.Love i Kaczmarskim, a w miejsce fejsa i Tick-Tocka zacznie czytać Dukaja pomoże w osiągnięciu celu wychowawczego? Dlaczego?</i>'
              '</p>'
              '</li>'

              '</ul>'

              '<p style="text-align:justify;">'
              'Jako ostatni element, już bez scenariusza, prowadzący opisuje metodę pośrednią jaką jest zaproponowanie <b>Opowieści Przewodniej</b> na podstawie załącznika “o strukturze i kształtowaniu duchowości”.'
              '</p>'
      ),
    ]
);