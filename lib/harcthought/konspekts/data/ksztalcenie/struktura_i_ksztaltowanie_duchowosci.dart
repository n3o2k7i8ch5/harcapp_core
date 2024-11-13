import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common_attachments.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/wstep_do_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

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

      KonspektStep(
          title: 'Sfery rozwoju',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący opierając się na wiedzy z załącznika “o strukturze i kształtowaniu duchowości” wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
              '<br>'
              '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
              '<br>'
              '<br>Jeżeli prowadzący uzna, że poprawi to poziom zrozumienia, może skorzystać z analogii opisanej sfer funkcjonalnych i centralnych do samochodu i kierowcy opisanego w poradniku $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci.'
              '<br>'
              '<br>Następnie prowadzący hasłowo wymienia uczestnikom kilka elementów poszczególnych sfer i prosi uczestników o podanie do jakiej sfery należą, np.:'
              '</p>'

              '<table border="1" style="border-collapse: collapse; width: 100%;">'
              '<tr>'
              '<th style="padding-left: 8px; padding-right: 8px;"><p>Hasło</p></th>'
              '<th style="padding-left: 8px; padding-right: 8px;"><p>Sfera rozwoju</p></th>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Umiejętność gry na trąbce</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera umysłu (koordynacja) i ciała (płuca)</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Zdolność marszu przez tydzień przy -20°C</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera ciała</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Kontrolowanie swoich reakcji będąc wściekłym</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera emocji</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Umiejętność zdyskredytowania kogoś w oczach wspólnoty</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera relacji</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Postępowanie zgodnie ze swoimi przekonaniami w środowisku stresogennym</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera ducha (chęć postępowania) i emocji (panowanie nad stresem)</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Posiadanie spójnego światopoglądu</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera ducha</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Zdolność zbudowania ładnej bramy obozowej</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Sfera umysłu</p></td>'
              '</tr>'
              '</table>'

              '<p style="text-align:justify;">'
              'Jest różnica między <b>emocjami</b>, a <b>doświadczeniem duchowym</b> - to drugie często rodzi silne emocje, ale jest doświadczeniem najgłębszego sensu bycia, jedności z Bogiem, etc..'
              '<br>'
              '<br>Ważne, by prowadzący na końcu wprowadzenia zaznaczył:'
              '<br>'
              '<br><b><i>“Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje.”</i></b>'
              '<br>'
              '<br>Przechodząc do kolejnego punktu prowadzący oświadcza, że <b>przedmiotem tych zajęć będzie jedynie sfera ducha</b>.'
              '</p>'
      ),

      KonspektStep(
          title: 'Poziomy (warstwy) rozwoju duchowego',
          duration: Duration(minutes: 15),
          activeForm: false,
          required: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący na podstawie pradnika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci wprowadza rozróżnienie poziomów duchowości kolejno na poziom aksjomatu, poziom wartości, poziom postaw i poziom zachowań (kolejność definiowania jest ważna). Każdorazowo po zdefiniowaniu określonego poziomu duchowości prowadzący kładzie w widocznym miejscu kartkę z nazwą poziomu duchowości i jego hasłową definicją z załącznika “poziomy duchowości”. Dzięki temu uczestnicy mogą zawsze wrócić podczas warsztatów do definicji poziomu duchowości.'
              '<br>'
              '<br>Dodatkowo prowadzący definiuje duchowość <b>wymierną</b> (poziom zachowań i postaw) i <b>głęboką</b> (poziom wartości i aksjomatów).'
              '<br>'
              '<br>Prowadzący powinien wyraźnie zaznaczyć, że “poziom duchowości” nie odnosi się do słowa “poziom” w sensie poziomu zaawansowania, np. poziom w grze komputerowej, ale poziomu w sensie warstwy, piętra, hierarchii etc..'
              '<br>'
              '<br>Prowadzący może w procesie definiowania posiłkować się przykładem:'
              '</p>'

              '<table border="1" style="border-collapse: collapse; width: 100%;">'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Zachowanie</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Oddanie własnego obiadu bezdomnemu</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Postawa</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Ofiarność</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Wartość</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Godne życie każdego człowieka</p></td>'
              '</tr>'
              '<tr>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Aksjomat</p></td>'
              '<td style="padding-left: 8px; padding-right: 8px;"><p>Bóg z miłości stworzył każdego człowieka na swój obraz</p></td>'
              '</tr>'
              '</table>'

              '<p style="text-align:justify;">'
              'Po zdefiniowaniu poziomów prowadzący prosi uczestników o podanie kilku przykładowych elementów do każdego z poziomów duchowości. Prowadzący każdorazowo ocenia, czy przykłady są trafne - jeśli nie, podaje powód, dla którego nie są.'
              '<br>'
              '<br><u>Uwagi o wartościach:</u>'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">'
              'Stwierdzenie pokroju: <i>“dla mnie wartością jest czytanie książek swoim dzieciom”</i> w istocie nie jest deklaracją wartości, a deklaracją czynu, który warto podjąć. Wartością jest stan, do którego ów czyn prowadzi. <i>“Warto czytać książki dzieciom, bo zacieśnia to więzi w rodzinie”</i> - zatem wartością w tym przypadku jest stan trwania bliskich relacji rodzinnych.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Potoczne określenie <i>“wartością jest dla mnie rodzina”</i> nie jest deklaracją wartości, bowiem nie określa preferowanego stanu z nią związanego: czy chodzi o posiadanie rodziny, o jej majętność, długowieczność, szczęście, dużą liczebność, przyjemność członków rodziny? W sposób domyślny podanie jedynie przedmiotu wartości oznacza: <i>“w staraniach o preferowany stan rzeczywistości wynikający z moich aksjomatów, najbardziej interesuje mnie poprawa fragmentu rzeczywistości związana z moją rodziną”</i>.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Stwierdzenie pokroju: <i>“dla mnie wartością jest czytanie książek swoim dzieciom”</i> w istocie nie jest deklaracją wartości, a deklaracją czynu, który warto podjąć. Wartością jest stan, do którego ów czyn prowadzi. <i>“Warto czytać książki dzieciom, bo zacieśnia to więzi w rodzinie”</i> - zatem wartością w tym przypadku jest stan trwania bliskich relacji rodzinnych.'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Wartości nie muszą być wcale przemyślane, górnolotne i głębokie. Chwilowo człowiek może jako preferowany stan określić stan przyjemności wynikający ze zjedzenia cukierka, zaśnięcie, czy euforię po kupieniu nowych ciuchów.'
              '<br>'
              '<br>To także są wartości wpisane w strukturę wartości człowieka.'
              '</p>'
              '</li>'

              '</ul>'

      ),

      KonspektStep(
          title: 'Sfery rozwoju',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              '</p>'
      )
    ]
);