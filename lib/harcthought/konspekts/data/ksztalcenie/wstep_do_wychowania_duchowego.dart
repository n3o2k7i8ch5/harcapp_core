import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/warsztaty_wychowania_duchowego.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

import '../common_attachments.dart';
import 'common_wychowanie_duchowe.dart';

List<String> wstep_do_wychowania_duchowego_aims = [
  'Przekazanie uczestnikom różnicy między rozwojem sfer funkcjonalnych od sfery ducha.',
  'Przekazanie uczestnikom rozróżnienia poziomów i etapów rozwoju sfery ducha.',
  'Zwrócenie uwagi uczestników na brak możliwości neutralności rozwoju duchowego.',
  'Przekazanie uczestnikom skutków wynikających z oparcia wartości ZHP o chrześcijaństwo.',
];

Konspekt konspekt_kszt_wstep_do_wychowania_duchowego = Konspekt(
    name: 'wstep_do_wychowania_duchowego',
    title: 'Wstęp do wychowania duchowego',
    additionalSearchPhrases: [
      'wychowanie duchowe'
    ],
    category: KonspektCategory.ksztalcenie,
    type: KonspektType.zajecia,
    spheres: {},
    metos: [Meto.kadra],
    coverAuthor: 'Freepik (al17)',
    author: DANIEL_IWANICKI,
    aims: wstep_do_wychowania_duchowego_aims,
    attachments: [
      attach_poradnik_o_strukturze_duchowosci,
      attach_poziomy_duchowosci,

      attach_aksjomaty_opisu_przyklady,
      attach_aksjomaty_opisu_i_sensu_przyklady,
      attach_aksjomaty_sensu_przyklady,
      attach_aksjomaty_bledne_przyklady,

      attach_neutralnosc_duchowa_przyklady,
      attach_cel_wychowania_duchowego_zhp_statut,
      attach_cel_wychowania_duchowego_zhp_uchwala,
      attach_kratka_minimow_rozwoju_duchowego,
    ],
    materials: [

      KonspektMaterial(
        name: 'Dostępny do przygotowania merytorycznego $attach_title_poradnik_o_strukturze_duchowosci',
        attachmentName: attach_name_poradnik_o_strukturze_duchowosci,
      ),

      KonspektMaterial(
        name: 'Duży arkusz papieru (flipchart)',
        amount: 1,
      ),

      KonspektMaterial(
        name: 'Kartka A4',
        amount: 4,
      ),

      KonspektMaterial(
        name: 'Długopis',
        amount: 4,
      ),

      material_zal_poziomy_duchowosci,

      material_zal_aksjomaty_opisu_przyklady,
      material_zal_aksjomaty_opisu_i_sensu_przyklady,
      material_zal_aksjomaty_sensu_przyklady,
      material_zal_aksjomaty_bledne_przyklady,

      KonspektMaterial(
        name: 'Wydrukowany załącznik “$attach_title_neutralnosc_duchowa_przyklady”',
        attachmentName: attach_name_neutralnosc_duchowa_przyklady,
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
    summary: 'Uczestnicy pochylają się nad zagadnieniem tego, czym jest duchowość, jakie mechanizmy nią rządzą i jak w praktyce prowadzić wychowanie duchowe.',
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
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący informuje uczestników o czym będą, a o czym nie będą niniejsze zajęcia.'
              '<br>'
              '<br>Zajęcia służą temu, żeby:'
              '</p>'

              '<ul>'

              '<li>'
              '<p style="text-align:justify;">Holistycznie zdefiniować i zrozumieć czym jest duchowość,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić relację między duchowością, a religijnością,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić relację między duchowością a wychowaniem,</p>'
              '</li>'

              '<li>'
              '<p style="text-align:justify;">Określić jaka jest i skąd się bierze duchowość harcerska.</p>'
              '</li>'

              '</ul>'
              '<p style="text-align:justify;">'
              'Podczas zajęć nie będzie poruszana kwestia tego jak konkretnie pracować z duchowością - nie starczy na to czasu. Pod koniec zajęć zostanie jednak udostępnione kompendium konspektów chętnym osobom.'
              '</p>'
      ),

      step_sfery_rozwoju_i_ich_relacje,

      step_poziomy_duchowosci,

      step_poziomy_duchowosci_aksjomat,

      step_poziomy_duchowosci_aksjomat_dopasowanie_przykladow,

      step_integracja_duchowosci,

      step_duchowosc_powszechna_madrosc_kultura_i_tradycja,

      step_duchowosc_religia_religijnosc_opinie_uczestnikow,

      step_duchowosc_religia_religijnosc,

      KonspektStep(
          title: 'Przerwa',
          duration: Duration(minutes: 5),
          activeForm: true,
          content: '<p style="text-align:justify;">'
              'Prowadzący zarządza przerwę celem rozprostowania starych kości, zażycia ruchu, skoczenia do toalety itd..'
      ),

      // Neutralność duchowa
      KonspektStep(
          title: 'Neutralność duchowa - wstęp',
          duration: Duration(minutes: 10),
          activeForm: false,
          aims: [
            'Przekazanie myśli, że "wychowanie to kształtowanie duchowości"',
          ],
          content: '<p style="text-align:justify;">'
              'Prowadzący zaczyna od postawienia pytania:'
              '<br>'
              '<br><i>"Wiemy, czym jest duchowość, dlatego zejdźmy na moment na ziemię i pomówmy o konkretach. Po co tworzymy harcerstwo? Oczywiście: żeby wychowywać młodego człowieka. Ale czym jest wychowanie w kontekście duchowości?"</i>'
              '<br>'
              '<br>Prowadzący pozostawia przestrzeń na chwilę dyskusji, która powinna doprowadzić uczestników do wnioisku, że <b>wychowanie to kształtowanie duchowości</b>.'
              '<br>'
              '<br>Jeśli uczestnicy mają problem, by do owego wniosku dojść, prowadzący może podsuwać pytania (na które odpowiedź jest w sposób oczywisty twierdząca):'
              '</p>'
              '<ol>'
              '<li><p style="text-align:justify;"><i>“Czy elementem wychowania jest kształtowanie zachowań?”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Czy elementem wychowania jest kształtowanie postaw?”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Czy elementem wychowania jest kształtowanie poglądów?”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Czy elementem wychowania jest kształtowanie wartości?”</i></p></li>'
              '<li><p style="text-align:justify;"><i>“Czy elementem wychowania jest zapoznawaniem z kulturą?”</i></p></li>'
              '</ol>'

              '<p style="text-align:justify;">'
              'Po ewentualnej krótkiej dyskusji, prowadzący pyta:'
              '<br>'
              '<br><i>Skoro wychowanie to kształtowanie zachowań, postaw, poglądów, wartości... to czyż wychowanie nie jest po prostu kształtowaniem duchowości?</i>'
              '</p>'
      ),

      step_neutralnosc_duchowa,

      step_neutralnosc_duchowa_w_przypadku_problemow,

      step_harcerstwo_analogia_do_ogrodnikow,

      step_zrodla_wartosci_w_zhp_dyskusja_o_scenariuszach,

      step_zrodla_wartosci_w_zhp_okreslonosc_wartosci,

      step_zrodla_wartosci_w_zhp_aksjoamty,

      step_neutralnosc_podsumowanie,

      KonspektStep(
          title: 'Kratka minimów rozwoju duchowego',
          duration: Duration(minutes: 5),
          activeForm: false,
          content: '<p style="text-align:justify;">'
              'Prowadzący przekazuje uczestnikom w grupach po jednym wydrukowanym egzemplarzu załącznika $attach_html_kratka_minimow_rozwoju_duchowego. Prowadzący tłumaczy uczestnikom co owa kratka reprezentuje - w każde pole odpowiada ogólnym zasadom, którymi prawidłowo rozwijający się w sferze duchowej harcerz powinien się cechować. Prowadzący informuje uczestników gdzie ten załącznik jest dostępny.'
              '<br>'
              '<br>Kratka nie jest omawiana podczas zajęć ze względu na brak czasu. Jest prezentowana jedynie w celu uświadomienia, że taka pomoc merytoryczna jest dla nich, uczestników, dostępna.'
              '</p>'
      ),

      step_szybkie_strzaly_dyskusyjne

    ],
    partOf: konspekt_kszt_warsztaty_wychowania_duchowego
);