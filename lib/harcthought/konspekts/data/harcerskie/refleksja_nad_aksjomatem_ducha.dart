import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people.dart';

const String konspekt_harc_name_refleksja_nad_aksjomatem_ducha = 'refleksja_nad_aksjomatem_ducha';
const String konspekt_harc_title_refleksja_nad_aksjomatem_ducha = 'Refleksja nad aksjomatem ducha';
const String konspekt_harc_html_refleksja_nad_aksjomatem_ducha = '<a href="$konspekt_harc_name_refleksja_nad_aksjomatem_ducha@harcerskie.konspekt">$konspekt_harc_title_refleksja_nad_aksjomatem_ducha</a>';

Konspekt refleksja_nad_aksjomatem_ducha = const Konspekt(
  name: konspekt_harc_name_refleksja_nad_aksjomatem_ducha,
  title: konspekt_harc_title_refleksja_nad_aksjomatem_ducha,
  category: KonspektCategory.harcerskie,
  type: KonspektType.zajecia,
  spheres: {
    KonspektSphere.duch: KonspektSphereDetails(
        level: [KonspektSphereLevel.duchAksjomaty],
        mechanism: [KonspektSphereMechanism.duchBezposrednia]
    )
  },
  metos: [Meto.hs, Meto.wedro],
  coverAuthor: 'freepik.com (vectorpouch)',
  author: DANIEL_IWANICKI,
  customDuration: Duration(minutes: 4 * 20 + 30),
  aims: [
    'Refleksja nad poziomem aksjomatycznym swojej duchowości',
  ],
  materials: [
    KonspektMaterial(
        amountAttendantFactor: 2,
        name: 'Wydrukowany załącznik "pytania".',
        attachmentName: 'pytania',
        additionalPreparation: 'Każdy uczestnik powinien dostać 5 przygotowanych elementów: jeden "wstęp" oraz 4 "pytania".'
            '\n'
            '\nWydrukowany załącznik należy pociąć na części i zagiąć we wskazanych miejscach tak, by dolna część każdej wyciętej części kartki przykrywała treść pytania, lecz by odsłaniała nagłówek.'
    ),
  ],
  summary: 'Uczestnicy indywidualnie i w ciszy podejmują refleksję nad pytaniami dotyczącymi sensu ich życia. Po zakończeniu podsumowują je między sobą.',
  description: '<p>Harcerze otrzymują wydrukowane i pocięte pytania z załącznika <a href="pytania@attachment">pytania</a>.'
      '<br>'
      '<br>Każdy uczestnik znajduje ustronne miejsce, gdzie może w spokoju pomyśleć bez rozpraszania swojej uwagi. Może również udać się na spacer.'
      '<br>'
      '<br>Harcerze otwierają pierwsze pytanie, czytają je i przez kolejne 20 minut podejmują nad nim refleksję. Gdy czas ten upłynie, przechodzą do kolejnego pytania, nad którym również spędzają 20 minut. Proces ten jest powtarzany analogicznie dla trzeciego i czwartego pytania.'
      '<br>'
      '<br>Gdy skończą, wszyscy wracają w jedno miejsce i w zastępach, lub innych małych grupach (najlepiej po około 4 osoby) omawiają swoje refleksje. Jeżeli nie chcą się czymś dzielić - nie ma takiej konieczności.'
      '<br>'
      '<br>Forma ta ma na celu pracę nad duchowością na poziomie aksjomatu (a więc na poziomie najgłębszym, w przeciwieństwie do poziomu zachowań, postaw i wartości). Forma ta może być stosowana jako forma zastępca dla osób które na obozie nie uczestniczą we Mszy Świętej.</p>',
  attachments: [
    KonspektAttachment(
      name: 'pytania',
      title: 'Pytania',
      assets: {
        FileFormat.pdf: 'pytania.pdf',
        FileFormat.docx: 'pytania.docx'
      },
    )
  ],
);