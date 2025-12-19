import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/harcthought/konspekts/data/harcerskie/wedrowka.dart' as konspekt_wedrowka;
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';
import '_consts.dart';

Konspekt wedrowka_bez_zasobow = const Konspekt(
    name: 'wedrowka_bez_zasobow',
    title: 'Wędrówka bez zasobów',
    additionalSearchPhrases: ['wedrowki'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
    spheres: {
      KonspektSphere.cialo: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.other: KonspektSphereFields(
              fields: {cialoZdolnoscMarszu: null}
          )
        },
      ),
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaSkupienie: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
                  postawaUwaznosc: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
                  postawaOdpowiedzialnosc: {KonspektSphereFactor.duchBezposrednieDoswiadczenie},
                  postawaOtwartoscNaLudzi: {KonspektSphereFactor.duchBezposrednieDoswiadczenie}
                }
            ),
            ...levelSilaCharakteru
          }
      ),
      KonspektSphere.umysl: KonspektSphereDetails(
        levels: {
          KonspektSphereLevel.other: KonspektSphereFields(
              fields: {umyslKoncentracja: null}
          )
        },
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (DenisW)',
    author: DANIEL_IWANICKI,
    aims: [
      aimSilaCharakteruWedrowanie,
      aimUmiejetnoscWedrowania,
      aimPostawaOdpowiedzialnosciZaCzynny,
      aimWlasnaSprawczosc,
      aimOtwartoscNaInterakcje,
    ],
    summary: 'Uczestnicy wyruszają na wędrówkę mając jedynie plecak i trochę wody. Muszą wejść w interakcję z lokalną społecznością, jeśli chcą zdobyć coś do jedzenia, picia, lub poznać kierunek, w którym powinni iść.',
    description: '<p style="text-align:justify;">Wariant konspektu ${konspekt_wedrowka.konspekt_ref}.'
        '<br>'
        '<br>Uczestnicy wędrują po terenie zamieszkałym (wsiach, miasteczkach) z ograniczonymi zasobami w celu zmuszenia uczestników do wejścia w interakcję z lokalną społecznością. Cel ów można osiągnąć przykładowo przez zaopatrzenie harcerzy w butelki lub bidony na wodę nie większe niż 0.5l (prowadzący powinien mieć w plecaku większy zapas wody dla uczestników na wszelki wypadek) lub poprzez określenie jedynie celu wędrówki bez zaopatrzenia ich w mapę. Mechanizmy te w sposób naturalny prowadzą uczestników do konieczności proszenia mieszkańców o uzupełnienie wody w pobliskich domach i do pytania o drogę napotykanych po drodze ludzi.</p>'
);