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

      KonspektStep(
          title: 'Przerwa',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Przerwa na rozprostowanie nóg, przewietrzenie się, siku itp..'
              '</p>'
      ),

      step_duchowosc_powszechna_madrosc_kultura_i_tradycja,

      step_duchowosc_religia_religijnosc_opinie_uczestnikow,

      step_duchowosc_religia_religijnosc,

      KonspektStep(
          title: 'Sfery rozwoju',
          duration: Duration(minutes: 10),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              '</p>'
      ),
    ]
);