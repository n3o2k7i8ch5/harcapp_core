import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';

Konspekt wstep_do_wychowania_duchowego = const Konspekt(
    name: 'wstep_do_wychowania_duchowego',
    title: 'Wstęp do wychowania duchowego',
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Freepik (al17)',
    author: DANIEL_IWANICKI,
    aims: [
      'Przekazanie uczestnikom różnicy między rozwojem sfer funkcjonalnych od sfery ducha',
      'Przekazanie uczestnikom rozróżnienia poziomów i etapów rozwoju sfery ducha',
      'Zwrócenie uwagi uczestników na brak możliwości neutralności rozwoju duchowego',
      'Zrozumienie co wynika z oparcia wartości ZHP o chrześcijaństwo'
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
        name: 'Dostępny do przygotowania merytorycznego załącznik “$attach_title_o_strukturze_i_ksztaltowaniu_duchowosci”',
        attachmentName: attach_name_o_strukturze_i_ksztaltowaniu_duchowosci,
      ),

      KonspektMaterial(
        name: 'Duży arkusz papieru (flipchart)',
        amount: 1,
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_neutralnosc_duchowa_przyklady”',
        attachmentName: attach_name_neutralnosc_duchowa_przyklady,
      ),

      KonspektMaterial(
        name: 'Kartka A4',
        amount: 4,
      ),

      KonspektMaterial(
        name: 'Długopis',
        amount: 4,
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_statut”',
        attachmentName: attach_name_cel_wychowania_duchowego_zhp_statut,
        amount: 4
      ),

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_cel_wychowania_duchowego_zhp_uchwala”',
        attachmentName: attach_name_cel_wychowania_duchowego_zhp_uchwala,
        amount: 4
      ),

      KonspektMaterial(
          name: 'Wydrukowany załącznik “$attach_title_kratka_minimow_rozwoju_duchowego”',
          attachmentName: attach_name_kratka_minimow_rozwoju_duchowego,
          amount: 4
      ),

    ],
    steps: [

      KonspektStep(
          title: 'Pytanie wstępne',
          duration: Duration(minutes: 10),
          required: false,
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący opierając się na wiedzy z załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci wprowadza podział człowieka na 5 sfer rozwoju - 4 sfery funkcjonalne: <b>ciało</b>, <b>umysł</b>, <b>emocje</b>, <b>relacje</b> i jedną sferę centralną: sferę <b>ducha</b>.'
              '<br>'
              '<br>Prowadzący opisuje zależności między sferami - sfery funkcjonalne dostarczają człowiekowi <b>zdolności</b>, zaś sfera ducha jest <b>sposobem</b> ich zarządzania.'
              '<br>'
              '<br>Jeżeli prowadzący uzna, że poprawi to poziom zrozumienia, może skorzystać z analogii opisanej sfer funkcjonalnych i centralnych do samochodu i kierowcy opisanego w załączniku $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci.'
              '<br>'
              '<br>Następnie prowadzący hasłowo wymienia uczestnikom kilka elementów poszczególnych sfer i prosi uczestników o podanie do jakiej sfery należą, np.:'
              '</p>'
              '<ul>'
              '<li>'
              '<p style="text-align:justify;">'
              'Umiejętność gry na trąbce'
              '<br>Sfera umysłu (koordynacja) i ciała (płuca)'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność marszu przez tydzień przy -20°C'
              '<br>Sfera ciała'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Kontrolowanie swoich reakcji będąc wściekłym'
              '<br>Sfera emocji'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Umiejętność zdyskredytowania kogoś w oczach wspólnoty'
              '<br>Sfera relacji'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Postępowanie zgodnie ze swoimi przekonaniami w środowisku stresogennym'
              '<br>Sfera ducha (chęć postępowania) i emocji (panowanie nad stresem)'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Posiadanie spójnego światopoglądu'
              '<br>Sfera ducha'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność zbudowania ładnej bramy obozowej'
              '<br>Sfera umysłu'
              '</p>'
              '</li>'

              '</ul>'
              '<p style="text-align:justify;">'
              'Prowadzący może zwrócić uwagę na fakt, że jest różnica między <b>emocjami</b> a <b>doświadczeniem duchowym</b>. Czasami przestrzenie te są mylone, ponieważ doświadczenie duchowe często rodzi silne emocje, ale jest doświadczeniem najgłębszego sensu bycia, jedności z Bogiem, etc..'
              '<br>'
              '<br>Ważne, by prowadzący na końcu wprowadzenia zaznaczył:'
              '<br>'
              '<br><b><i>“Duchowość nie jest umiejętnością, dlatego nie należy sądzić że można ją rozwinąć tymi samymi metodami co intelekt, ciało, czy emocje.”</i></b>'
              '<br>'
              '<br>Przechodząc do kolejnego punktu prowadzący oświadcza, że <b>przedmiotem tych zajęć będzie jedynie sfera ducha</b>. Inne sfery nie będą tutaj głębiej rozpatrywane.'
              '</p>'
      ),

    ]
);