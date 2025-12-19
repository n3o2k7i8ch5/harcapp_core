import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';

Konspekt wieczorne_przeprosiny_i_podziekowania = const Konspekt(
    name: 'wieczorne_przeprosiny_i_podziekowania',
    title: 'Wieczorne przeprosiny i podziękowania',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaPrzebaczenie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja
                  },
                  postawaWdziecznosc: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja
                  },
                  postawaOtwartoscNaLudzi: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja
                  },
                }
            ),
          }
      ),
      KonspektSphere.relacje: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.other: KonspektSphereFields(
                fields: {
                  relPrzyznanieSieDoBledow: null,
                  relBudowanieRelacjiZaufania: null,
                }
            )
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: '',
    author: DANIEL_IWANICKI,
    customDuration: Duration(minutes: 15),
    aims: [
      'Kształtowanie u uczestników postawy wdzięczności',
      'Kształtowanie u uczestników postawy przepraszania',
      'Kształtowanie u uczestników postawy przebaczania',
      'Kształtowanie u uczestników wartości życia w zgodzie',
      'Kształtowanie u uczestników wartości odpuszczania win',
      'Kształtowanie u uczestników wartości rozmowy o relacjach z bliskimi ludźmi'
    ],
    summary: 'Pod koniec dnia uczestnicy mają kilka minut przed położeniem się spać, w trakcie których mogą do siebie podejść, podziękować za coś lub przeprosić.',
    description: '<p style="text-align:justify;">Podczas formy wyjazdowej pod koniec każdego dnia (np. po obrzędowym zakończeniu dnia w kręgu) wszyscy zostają jeszcze na chwilę na wspólnej przestrzeni (np. na placu apelowym). Każda osoba może w tym czasie podejść do wybranych osób i podziękować im za coś, co się tego dnia działo lub za coś przeprosić. Ważne jest, by uczestnictwo w tej formie zawsze pozostawiać dobrowolnym.</p>',
    howToFail: [
      'Uczynić formę obowiązkową, np. "każdy musi podejść do min. jednej osoby"',
    ]
);