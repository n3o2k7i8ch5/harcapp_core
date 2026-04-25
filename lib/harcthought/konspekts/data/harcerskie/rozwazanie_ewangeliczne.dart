import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';


Konspekt rozwazanie_ewangeliczne = const Konspekt(
    name: 'rozwazanie_ewangeliczne',
    title: 'Rozważanie ewangeliczne',
    additionalSearchPhrases: ['rozważania ewangeliczne', 'ewangelia', 'apel ewangeliczny', 'pismo święte', 'biblia'],
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
          levels: {
            KonspektSphereLevel.duchAksjomaty: KonspektSphereFields(
                fields: {
                  aksjoSwietoscHistoriiBiblijnych: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                  },
                  aksjoRozwazanieSensuICeluZycia: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  aksjoAksjomatyChrzescijanskie: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchPerspektywa_Normalizacja,
                  },
                }
            ),
            KonspektSphereLevel.duchPostawy: KonspektSphereFields(
                fields: {
                  postawaSpojnoscZWartosciamiChrzescijanskimi: {
                    KonspektSphereFactor.duchWlasnaRefleksja,
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                  postawaWyciszenie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                    KonspektSphereFactor.duchWspolnota_WzajemnoscOddzialywan,
                  },
                  postawaSkupienie: {
                    KonspektSphereFactor.duchBezposrednieDoswiadczenie,
                  },
                }
            ),
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (fijulanam468)',
    author: DANIEL_IWANICKI,
    aims: [
      'Stworzenie uczestnikom czasu do budowania ich relacji z Bogiem',
      'Budowanie u uczestników nawyku regularnego sięgania po Słowo Boże',
      'Normalizacja wspólnotowego rozważania fragmentów Ewangelii',
      'Kształtowanie u uczestników zdolności refleksji nad treściami biblijnymi i ich odniesieniem do własnego życia',
      'Budowanie wspólnoty aksjomatu wokół chrześcijańskiej wizji świata',
    ],
    summary: 'Uczestnicy wspólnie czytają krótki fragment Ewangelii, a następnie w ciszy lub w rozmowie odnoszą jego treść do własnego życia.',
    description: '<p style="text-align:justify;">Rozważanie ewangeliczne (zwane też „apelem ewangelicznym”) to krótka forma duchowa polegająca na wspólnym wysłuchaniu fragmentu Ewangelii i zatrzymaniu się nad jego treścią. Może być realizowana codziennie (np. wieczorem na obozie), tygodniowo lub okazjonalnie - przy ognisku, przed zbiórką, na wyjeździe.'
        '<br>'
        '<br><b>Przebieg:</b></p>'
        '<ol>'
        '<li><p style="text-align:justify;">Prowadzący wybiera fragment - najlepiej krótki (kilka wersetów), z Ewangelii na dany dzień lub dobrany tematycznie.</p></li>'
        '<li><p style="text-align:justify;">Jedna z osób czyta fragment na głos - powoli, z wyczuciem.</p></li>'
        '<li><p style="text-align:justify;">Następuje chwila ciszy (1-3 minuty), w której uczestnicy w głowie odpowiadają sobie na pytanie: <i>„co ten fragment mówi do mnie dzisiaj?”</i>.</p></li>'
        '<li><p style="text-align:justify;">Opcjonalnie: chętni dzielą się krótko swoją refleksją - bez dyskusji, bez oceniania, bez „prawidłowych odpowiedzi”.</p></li>'
        '<li><p style="text-align:justify;">Forma kończy się krótką modlitwą lub po prostu „Amen”.</p></li>'
        '</ol>'
        '<p style="text-align:justify;">Fragmenty Ewangelii na każdy dzień roku liturgicznego są dostępne w aplikacji w sekcji <i>Rozważania ewangeliczne</i>.'
        '<br>'
        '<br>Forma sprawdza się szczególnie w drużynach starszoharcerskich i wędrowniczych, gdzie uczestnicy są w stanie samodzielnie podjąć refleksję. W metodyce harcerskiej warto pomóc uczestnikom pytaniami naprowadzającymi.</p>'
);