import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';
import '_consts.dart';

const String konspekt_name = 'wedrowka';
const String konspekt_title = 'Wędrówka';

const String konspekt_ref = '<a href="${konspekt_name}@harcerskie.konspekt">Wędrówka</a>';

Konspekt wedrowka = const Konspekt(
    name: konspekt_name,
    title: konspekt_title,
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
                  postawaOdpowiedzialnosc: {KonspektSphereFactor.duchBezposrednieDoswiadczenie}
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
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      aimSilaCharakteruWedrowanie,
      aimUmiejetnoscWedrowania,
      'Stworzenie naturalnej okazji do dyskusji na ważne tematy'
    ],
    summary: 'Uczestnicy udają się wspólnie na wędrówkę do wyznaczonego miejsca, podczas której powstają natualne okazje do rozmów, wzajemnej pomocy i sprawdzenia zdolności terenoznawczych.',
    description: '<p style="text-align:justify;">Prowadzący wyznacza określoną trasę (samemu lub we współudziale uczestników), uczestnicy przygotowują niezbędny ekwipunek potrzebny do marszu i ew. obozowania, po czym uczestnicy wraz z prowadzącym udają się w trasę.'
        '<br>'
        '<br>Forma, jeżeli odbywa się w odpowiednio dostosowanych warunkach, wpływa znakomicie na siłę charakteru zwłaszcza, jeśli pomimo trudności nie ma możliwości skrócenia trasy, bo celem jest dojście do noclegu. Głównym mechanizmem kształtowania siły charakteru jest konfrontacja uczestnika z własnymi oporami (takimi jak: zmęczenie, spocenie, dyskomfort termiczny, ciążenie plecaka), które musi przezwyciężyć, by nie znaleźć się w sytuacji dużo trudniejszej niż ta w której jest teraz (perspektywa przedłużenia obecnego stanu bez uzyskania czegokolwiek w zamian).'
        '<br>'
        '<br>Odpowiednio długa wędrówka pozwala także wpaść w swego rodzaju trans, mantrę stawiania kroków i wyciszenia umysłu. W sposób oczywisty wpływa także na rozwój sfery ciała.</p>'
);