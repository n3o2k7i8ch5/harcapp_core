import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt wspolna_minuta_czosnku = const Konspekt(
    name: 'wspolna_minuta_czosnku',
    title: 'Wspólna minuta czosnku',
    additionalSearchPhrases: ['czosnek'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.cialo: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {
                  cialoWzmacnianieOdpornosciOrganizmu: null
                }
            )
          }
      ),
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaOtwartoscNaLudzi: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan
                  }
                }
            ),
            KonspektSphereLevel.duchWartosci: KonspektSphereFields(
                fields: {
                  wartoscZdrowie: {
                    KonspektSphereFactor.duchPerspektywa_Normalizacja,
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan
                  },
                }
            ),
            ...levelSilaCharakteru
          }
      ),
      KonspektSphere.relacje: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {
                  relRozmowaOWlasnychDoswiadczeniach: null,
                  relBudowanieWspolnotyPrzezIntensywneDoswiadczenia: null
                }
            )
          }
      )
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (frimufilms)',
    author: DANIEL_IWANICKI,
    customDuration: Duration(minutes: 1),
    aims: [
      'Kształtowanie u uczestników siły charakteru poprzez nieprzyjemne praktyki',
      'Kształtowanie u uczestników wartości funkcjonowania we wspólnocie poprzez wspólny trud',
      'Stwarzanie prowadzącemu okazji do wyśmiania alkoholu',
      'Kształtowanie u uczestników postaw dbania o zdrowie',
    ],
    summary: 'Uczestnicy wspólnie jedzą po jednym ząbku czosnku, jednak po jego rozgryzieniu nie mogą go przełknąć przez jedną minutę.',
    description: '<p style="text-align:justify;">Grupa osób bierze po ząbku czosnku i staje w kręgu. Na dany znak wszyscy zaczynają jeść ząbek czosnku (rozgryzając go), jednak przełknąć i popić go można dopiero po minucie. Przegrywają ci, którzy przełkną czosnek wcześniej. Ponieważ jest to forma wspólnego trudu, kształtuje też wartości związane ze wspólnotą.'
        '<br>'
        '<br>Jeśli prowadzący uzna to za stosowne, a uczestnicy są odpowiednio duzi (ok, 15+), może w ten sposób naturalnie skomentować podobieństwo jedzenia czosnku do picia wódki - oba pieką, oba trzeba popić, oba dezynfekują, ale jeden wzmacnia odporność, a drugi niszczy wątrobę i mózg.'
        '<br>'
        '<br>Szczególnie dla tej formy warto zadbać o jej dobrowolność - pomaga to budować poczucie elitarności osób podejmujących rywalizację i wspólne wyzwania.'
        '<br>'
        '<br>Formę można przeprowadzać <b>maksymalnie</b> raz dziennie - więcej niż jeden ząbek czosnku na dobę może podrażnić żołądek.</p>'
);