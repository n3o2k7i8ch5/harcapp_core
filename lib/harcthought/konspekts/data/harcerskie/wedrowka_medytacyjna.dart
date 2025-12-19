import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';


Konspekt wedrowka_medytacyjna = const Konspekt(
    name: 'wedrowka_medytacyjna',
    title: 'Wędrówka medytacyjna',
    additionalSearchPhrases: ['wedrowki', 'medytacja'],
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
              }
          ),
          ...levelSilaCharakteru
        },
      )
    },
    metos: [Meto.hs, Meto.wedro],
    coverAuthor: 'Freepik (stockgiu)',
    author: DANIEL_IWANICKI,
    aims: [
      'Wyciszenie uczestników i refleksja nad wybranym zagadnieniem'
    ],
    summary: 'Uczestnicy wyruszają na wędrówkę w ciszy, otrzymując od prowadzącego zagadnienie, które powinni rozważać w trakcie drogi.',
    description: '<p style="text-align:justify;">Harcerze wybierają lub otrzymują jakiś temat do przemyślenia (np. “z jakiego powodu i po co są harcerzami”, “co by zrobili w jakimś przypadku”, “kim jest dla nich Bóg”), fragment rozważania lub Pisma Świętego i wybierają się na całodniową wędrówkę. Forma realizowana jest pojedynczo, trasa powinna zapewniać ciszę i możliwą minimalizację kontaków z ludźmi. Po powrocie harcerze mogą, ale nie muszą opowiedzieć o swoich przemyśleniach i wnioskach np. drużynowemu, opiekunowi próby, zastępowi lub całej drużynie.</p>'
);