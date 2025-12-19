import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

const Konspekt warta_nocna = Konspekt(
    name: 'warta_nocna',
    title: 'Warta nocna',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaOdpowiedzialnosc: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan
                  }
                }
            ),
            ...levelSilaCharakteru
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      'Kształtowanie u uczestników siły charakteru poprzez wstawanie w nocy na wartę, walkę z sennością, wartowaniem w chłodnej temperaturze',
      'Kształtowanie uważności uczestników poprzez spędzenie czasu w ciszy, w izolacji od bodźców dnia codziennego'
    ],
    summary: 'Uczestnicy w min. dwuosobowych grupach pełnią wymiennie nocną wartę, strzegąc obozowiska przed nieproszonymi gośćmi.',
    description: '<p style="text-align:justify;">Harcerze w dwuosobowych grupach podczas formy wyjazdowej pełnią wartę na terenie obozowania w celu zapewnienia bezpieczeństwa śpiącym uczestnikom od zewnętrznych czynników.'
        '<br>'
        '<br>Formę można z korzyścią połączyć z <a href="nocne_podkradanie@harcerskie.konspekt">nocnym podkradaniem</a>.</p>'
);