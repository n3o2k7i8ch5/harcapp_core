import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';
import '_consts.dart';

Konspekt zimowiskowe_apele_przed_osrodkiem = const Konspekt(
    name: 'zimowiskowe_apele_przed_osrodkiem',
    title: 'Zimowiskowe apele przed ośrodkiem',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zwyczaj,
    spheres: {
      KonspektSphere.duch: KonspektSphereDetails(
        levels: {
          ...levelSilaCharakteru
        },
      )
    },
    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    aims: [
      aimSilaCharakteruZimno
    ],
    summary: 'Uczestnicy odbywają w trakcie zimowiska apel przed ośrodkiem mając na sobie jedynie mundury.',
    description: '<p style="text-align:justify;">Podczas zimowej formy wyjazdowej (obóz lub zimowisko) drużyna codziennie przeprowadza apele na zewnątrz na śniegu. Ponadto w bardzo czytelny sposób obrazuje harcerzom dlaczego dyscyplina jest ważna - jeżeli nie chcą marznąć, muszą sprawnie działać.'
        '<br>'
        '<br>Warto także rozważyć prowadzenie apelu bez kurtek z widocznym mundurem, jeśli mróz nie jest za duży.</p>'
);