import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt zakwaterowanie_pod_namiotem = const Konspekt(
    name: 'zakwaterowanie_pod_namiotem',
    title: 'Zakwaterowanie pod namiotem',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
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
                wartoscWspolnota: {
                  KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan
                }
              }
          ),
          ...levelSilaCharakteru
        },
      )
    },
    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      'Kształtowanie u uczestników siły charakteru poprzez funkcjonowanie w warunkach obniżonego komfortu',
      'Budowanie u uczestników wspólnoty poprzez codzienne funkcjonowanie na ograniczonej przestrzeni'
    ],
    summary: 'Uczestnicy spędzają formę obozową lub biwakową pod namiotem nie mając dostępu do bieżącej wody, prądu, czy wygód życia w budynku.',
    description: '<p style="text-align:justify;">Głównym źródłem skuteczności formy jest funkcjonowanie uczestników w warunkach obniżonego komfortu: brak możliwości ogrzania namiotu, brak dobrego światła w namiocie, brak całkowitej izolacji od warunków atmosferycznych (głównie deszczu i upału), obecność robaczków, komarów, pająków, wszechobecność ściółki i kurzu, konieczność korzystania z zewnętrznej latryny, ograniczona przestrzeń na rzeczy w namiocie i brak możliwości całkowitego odizolowania się od pozostałych mieszkańców namiotu.</p>'
);