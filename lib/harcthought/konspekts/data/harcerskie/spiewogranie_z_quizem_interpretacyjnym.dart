import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

const String konspekt_harc_name_spiewogranie_z_quizem_interpretacyjnym = 'spiewogranie_z_quizem_interpretacyjnym';
const String konspekt_harc_title_spiewogranie_z_quizem_interpretacyjnym = 'Śpiewogranie z quizem interpretacyjnym';
const String konspekt_harc_html_spiewogranie_z_quizem_interpretacyjnym = '<a href="$konspekt_harc_name_spiewogranie_z_quizem_interpretacyjnym@harcerskie.konspekt">$konspekt_harc_title_spiewogranie_z_quizem_interpretacyjnym</a>';

Konspekt spiewogranie_z_quizem_interpretacyjnym = const Konspekt(
  name: konspekt_harc_name_spiewogranie_z_quizem_interpretacyjnym,
  title: konspekt_harc_title_spiewogranie_z_quizem_interpretacyjnym,
  additionalSearchPhrases: ['śpiewowisko', 'śpiewanie', 'piosenki', 'interpretacja', 'quiz'],
  category: KonspektCategory.harcerskie,
  type: KonspektType.zajecia,
  spheres: {
    KonspektSphere.duch: KonspektSphereDetails(
      levels: {
        KonspektSphereLevel.duchWartosci: {
          'Wartości zawarte w piosenkach': {KonspektSphereFactor.duchNormalizacja},
        },
      },
    )
  },
  metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
  coverAuthor: 'freepik.com (artefacti)',
  author: DANIEL_IWANICKI,
  customDuration: Duration(minutes: 90),
  aims: [
    'Refleksja nad historiami i wynikającymi z nich wartościami i postawami w piosenkach.',
  ],
  materials: [
    KonspektMaterial(
      amountAttendantFactor: 1,
      name: 'Teksty śpiewanych piosenek',
    ),
  ],
  summary: 'Prowadzący wybiera piosenki opowiadające o postawach i wartościach, które chce przybliżyć uczestnikom - uczestnicy owe piosenki poznają, po czym dokonują interpretacji ich słów.',
  description: '<p style="text-align:justify;">Prowadzący wybiera kilka piosenek, które niosą nieoczywiste na pierwszy “rzut oka (ucha?)” przesłanie w swojej treści lub które wymagają do ich zrozumienia znajomości kontekstu historycznego lub kulturowego.'
      '<br>'
      '<br>Uczestnicy otrzymują wydrukowane wybranych piosenek (by oszczędzić zasoby i wprowadzić element współpracy można wprowadzić rozdać teksty po jednym komplecie na dwie osoby).'
      '<br>'
      '<br>Uczestnicy dzieleni są na grupy. Dla każdej piosenki uczestnicy najpierw się jej uczą poprzez wspólnie zaśpiewanie jej z prowadzącym, po czym prowadzący przeprowadza quiz z tematu dotyczącego treści piosenki.'
      '<br>'
      '<br>Quiz może dotyczyć znaczenia różnych niecodziennych słów, wyrażeń, czy tego, co autor piosenki miał na myśli używając pewnego wyrażenia. Na końcu quizu uczestnicy wspólnie próbują podsumować sens piosenki.'
      '<br>'
      '<br>Wskazane jest, by kilka razy przeprowadzeniem formy uczestnicy mieli okazję zaśpiewać piosenki, które będą interpretowane.'
      '<br>'
      '<br>Szczególną wersją tej formy jest “kolędowanie z quizem interpretacyjnym”, gdzie zbiorem piosenek są kolędy.'
      '<br>'
      '<br><b>Przykładowe piosenki dla zuchów</b>:</p>'
      '<ul>'
      '<li><p style="text-align:justify;">Hej przyjaciele <i>(Zayazd)</i></p></li>'
      '<li><p style="text-align:justify;">Wieczorne śpiewogranie</p></li>'
      '</ul>'
      '<br><p style="text-align:justify;"><b>Przykładowe piosenki dla harcerzy</b>:</p>'
      '<ul>'
      '<li><p style="text-align:justify;">A my nie chcemy uciekać stąd <i>(P. Gintrowski)</i></p></li>'
      '<li><p style="text-align:justify;">Czarny chleb i czarna kawa <i>(Strachy na lachy)</i></p></li>'
      '<li><p style="text-align:justify;">Dni, których nie znamy <i>(Marek Grechuta)</i></p></li>'
      '<li><p style="text-align:justify;">Eldorado <i>(Sanah, D. Zawiałow)</i></p></li>'
      '<li><p style="text-align:justify;">Hej przyjaciele <i>(Zayazd)</i></p></li>'
      '<li><p style="text-align:justify;">Hymn <i>(J. Słowacki, Sanah)</i></p></li>'
      '<li><p style="text-align:justify;">Major ponury</p></li>'
      '<li><p style="text-align:justify;">Moja litania <i>(Leszek Wójtowicz)</i></p></li>'
      '<li><p style="text-align:justify;">Niebieski cyrkiel <i>(Stare Dobre Małżeństwo)</i></p></li>'
      '<li><p style="text-align:justify;">Pójdę boso <i>(Zakopower)</i></p></li>'
      '<li><p style="text-align:justify;">Rozwijając Rilkego <i>(Sahan)</i></p></li>'
      '<li><p style="text-align:justify;">Zielony dom <i>(Stare Dobre Małżeństwo)</i></p></li>'
      '</ul>'
      '<p style="text-align:justify;">Forma, aby miała sens, powinna być prowadzona przez osobę, które umie i lubi grać na gitarze i która przynajmniej minimalnie "czuje" temat interpretacji sztuki. Osoba prowadząca powinna się do niej zawczasu przygotować - rozpoczęcie przygotowań godzinę przed rozpoczęciem nie ma sensu.'
      '<br>'
      '<br>Forma ta ma na celu pracę nad duchowością na poziomie aksjomatu i wartości poprzez normalizację. Forma ta może być stosowana jako forma zastępcza dla osób w pionie Z i H, które na obozie nie uczestniczą we Mszy Świętej.</p>',
);