import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt wlasny_nagrobek = const Konspekt(
    name: 'wlasny_nagrobek',
    title: 'Własny nagrobek',
    additionalSearchPhrases: ['grob', 'śmierć', 'cmentarz'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.duchAksjomaty: KonspektSphereFields(
              fields: {
                aksjoRozwazanieSensuICeluZycia: {
                  KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  KonspektSphereFactor.duchPerspektywa_Normalizacja
                },
              }
          )
        },
      )
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (vecstock)',
    author: DANIEL_IWANICKI,
    aims: [
      'Refleksja uczestników nad sensem i celem własnego życia',
      'Refleksja uczestników nad hierarchia wartości w perspektywie własnej śmierci',
      'Refleksja uczestników nad spójnością między celem własnego życia i jego obecnym kształtem',
    ],
    materials: [
      KonspektMaterial(
          name: 'Materiały na nagrobki (deski, gwoździe, pineski, kartony, kartki, nożyczki, klej, brokat, długopisy, markery, itp.)',
          amount: 0
      )
    ],
    description: '<p style="text-align:justify;">'
        'Forma dobrze się nadaje na okres świąt Wszystkich Świętych.'
        '<br>'
        '<br>Prowadzący, obawiając się, czy perspektywa śmierci nie przytłoczy części uczestników powinien spojrzeć na ten dylemat z dwóch perspektyw:'
        '</p>'
        '<ul>'
        '<li><p style="text-align:justify;">forma może być przeprowadzona z wyraźnym zaznaczeniem uczestnikom jej dobrowolności.</p></li>'
        '<li><p style="text-align:justify;">śmierć jest i będzie obecna w otoczeniu uczestników. Zamiast ją cenzurować, lepiej ich do niej przygotować w kontrolowanym środowisku.</p></li>'
        '</ul>',
    summary: 'Uczestnicy wykonują z dostępnych materiałów dwa modele własnych nagrobków - pierwszy to taki, jakby chcieliby by podsumowywał ich życie, drugi to taki, który uważają, że teraz by im postawiono, gdyby umarli jutro.',
    steps: [

      KonspektStep(
          title: 'Wprowadzenie - nagrobek idealny',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący wprowadza uczestników w cel pierwszej części zadania - mają zaprojektować i zbudować nagrobek, który chcieliby by im postawiono na końcu życia.'
              '<br>'
              '<br>Prowadzący informuje uczestników, że na końcu zajęć każdy będzie mógł opowiedzieć o swoim nagrobku idealnym - jeśli tylko będzie chciał.</p>'
      ),


      KonspektStep(
          title: 'Rozdanie materiałów',
          duration: Duration(minutes: 10),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący rozdaje uczestnikom materiały, z których będą budowali nagrobki. Część materiałów warto zostawić na środku, tak by były dostępne dla tych, którzy będą potrzebowali ich więcej.'
              '<br>'
              '<br>Prowadzący informuje uczestników, że na przemyślenie i stworzenie nagrobka będą mieli 60 minut.</p>'
      ),


      KonspektStep(
          title: 'Projektowanie i budowanie nagrobka idealnego',
          duration: Duration(minutes: 60),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Uczestnicy projektują i budują swój nagrobek idealny.</p>'
      ),


      KonspektStep(
          title: 'Wprowadzenie - nagrobek rzeczywisty',
          duration: Duration(minutes: 5),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Prowadzący wprowadza uczestników w cel drugiej części zadania - mają zaprojektować i zbudować nagrobek, który sądzą, że postawiono by im, gdyby umarli jutro.'
              '<br>'
              '<br>Ważne, by zawarli w nim te same <b>kategorie informacji</b> (np. imię, lata życia, opis kto ich żegna i jak żyli), które zawarli w nagrobku idealnym.'
              '<br>'
              '<br>Prowadzący informuje uczestników, że nagrobek rzeczywisty tylko dla nich i że nikt nie będzie go podsumowywał, widział ani oceniał.</p>'
      ),


      KonspektStep(
          title: 'Projektowanie i budowanie nagrobka rzeczywistego',
          duration: Duration(minutes: 60),
          activeForm: KonspektStepActiveForm.active,
          content: '<p style="text-align:justify;">Uczestnicy projektują i budują swój nagrobek rzeczywisty.</p>'
      ),


      KonspektStep(
          title: 'Podsumowanie nagrobków idealnych',
          duration: Duration(minutes: 20),
          activeForm: KonspektStepActiveForm.static,
          content: '<p style="text-align:justify;">Uczestnicy wspólnie z prowadzącym podsumowują swoje nagrobki idealne. Nie ma konieczności prezentowania swojego przygotowanego nagrobka.</p>'
      ),

    ]
);