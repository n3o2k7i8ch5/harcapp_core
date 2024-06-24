import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/common.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';

Konspekt wstep_do_wychowania_duchowego = Konspekt(
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
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Uczestnicy odpowiadają na pytanie:'
              '<br>'
              '<br><i>“Co najważniejszego chcecie przekazać harcerzom w procesie wychowawczym? W czym te sprawy, idee, czy wartości mają swoje źródło? Co sprawiło, że uważasz to za ważne?”</i>.'
              '<br>'
              '<br>W przypadku dużej liczby uczestników prowadzący dzieli uczestników na 5 osobowe grupy i prosi uczestników o wymienienie się swoimi odpowiedziami (po 1-2 minuty na uczestnika). Prowadzący, jeśli chce poznać odpowiedzi uczestników może między nimi “krążyć” i nadstawiać ucha - warto z grubsza poznać uczestników zajęć.'
              '</p>'
      ),

      KonspektStep(
          title: 'Skrót tematu zajęć',
          duration: Duration(minutes: 2),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący informuje uczestników o czym będą, a o czym nie będą niniejsze zajęcia.'
              '<br>'
              '<br>Zajęcia służą temu, żeby:'
              '</p>'
              '<ul>'

              '<li>'
              '<p style="text-align:justify;">holistycznie zdefiniować i zrozumieć czym jest duchowość,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">określić relację między duchowością, a religijnością,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">określić relację między duchowością a wychowaniem,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">określić jaka jest i skąd się bierze duchowość harcerska.</p>'
              '</li>'

              '</ul>'
              '<p style="text-align:justify;">'
              'Podczas zajęć nie będzie poruszana kwestia tego jak konkretnie pracować z duchowością - nie starczy na to czasu. Pod koniec zajęć zostanie jednak udostępnione kompendium konspektów chętnym osobom.'
              '</p>'
      ),

      KonspektStep(
          title: 'Sfery rozwoju i ich relacje',
          duration: Duration(minutes: 15),
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
              'Umiejętność gry na trąbce - <i>Sfera umysłu (koordynacja) i ciała (płuca)</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność marszu przez tydzień przy -20°C - <i>Sfera ciała</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Kontrolowanie swoich reakcji będąc wściekłym - <i>Sfera emocji</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Umiejętność zdyskredytowania kogoś w oczach wspólnoty - <i>Sfera relacji</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Postępowanie zgodnie ze swoimi przekonaniami w środowisku stresogennym - <i>Sfera ducha (chęć postępowania) i emocji (panowanie nad stresem)</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Posiadanie spójnego światopoglądu - <i>Sfera ducha</i>'
              '</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">'
              'Zdolność zbudowania ładnej bramy obozowej - <i>Sfera umysłu</i>'
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

      KonspektStep(
          title: 'Poziomy i etapy rozwoju duchowości',
          duration: Duration(minutes: 20),
          activeForm: false,
          contentBuilder: ({required bool isDark}) => '<p style="text-align:justify;">'
              'Prowadzący na podstawie załącznika $attach_html_o_strukturze_i_ksztaltowaniu_duchowosci opisuje <b>etapy rozwoju duchowego</b> - w pierwszym etapie dzieci są uczone jedynie zachowań, które budują u nich postawy, w wieku ok. 10 lat rozpoczyna się myślenie abstrakcyjne i konceptualizują się wartości, które następnie, w wieku ok. 15 lat są porządkowane w światopogląd i internalizowane jest pojęcie aksjomatu.'
              '<br>'
              '<br>Ważne, by w procesie opisu prowadzący narysował we wspólnym miejscu odwróconą piramidę, tak jak poniżej:</p>'
              '${piramidaDuchowosciHtml(isDark: isDark)}'
              '<p style="text-align:justify;">'
              '<br>'
              '<br>W dalszej kolejności prowadzący wprowadza pojęcie <b>integracji duchowości</b> - sposobu w jaki poziomy duchowości kształtują się w procesie rozwoju.'
              '<br>'
              '<br>Ważne, by prowadzący zaznaczył, że struktura wartości nie zależy jedynie od środowiska i wychowania, ale także od <b>natury człowieka</b>, m.in. od jego <b>temperamentu</b>.'
              '</p>'

              '<img src="https://upload.wikimedia.org/wikipedia/commons/b/b0/Apple_Pay_logo.svg" alt="Some text 1"/>'
              '<img src="https://upload.wikimedia.org/wikipedia/commons/b/b0/Apple_Pay_logo.svg" width="100" alt="Some text 1"/>'

              '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.webp" alt="Some text 2"/>'
              '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.webp" width="100" alt="Some text 2"/>'

              '<img src="packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.webp" alt="Some text 3"/>'
              '<img src="packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.webp" width="100" alt="Some text 3"/>'

              '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" alt="Some text 4"/>'
              '<img src="asset:packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" width="100" alt="Some text 4"/>'

              '<img src="packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" alt="Some text 5"/>'
              '<img src="packages/harcapp_core/assets/konspekty/common/warsztaty_duchowe/piramida_duchowosci_light.svg" width="100" alt="Some text 5"/>'

      ),

    ]
);