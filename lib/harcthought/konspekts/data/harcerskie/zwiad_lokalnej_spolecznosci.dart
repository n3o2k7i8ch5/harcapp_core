import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/konspekts/data/level_examples.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../../konspekt.dart';
import '_consts.dart';

Konspekt zwiad_lokalnej_spolecznosci = const Konspekt(
    name: 'zwiad_lokalnej_spolecznosci',
    title: 'Zwiad lokalnej społeczności',
    category: KonspektCategory.harcerskie,
    type: KonspektType.zajecia,
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
            )
          }
      )
    },
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    coverAuthor: 'Daniel Iwanicki',
    author: DANIEL_IWANICKI,
    customDuration: Duration(hours: 5),
    aims: [
      'Kształtowanie u uczestników otwartości na kontakt z drugim człowiekiem',
      aimSzacunekDlaSkutecznegoDzialania
    ],
    summary: 'Uczestnicy w grupach udają się na rozpoznanie okolicy biwaku lub obozu, zbierają informacje na temat ciekawych, przydatnych lub ważnych miejsc w najbliższym otoczeniu.',
    description: '<p style="text-align:justify;">Harcerze w zastępach otrzymują zadanie, by rozpoznać okolicę biwaku lub obozu i zebrać informacje na temat ciekawych, przydatnych lub ważnych miejsc w najbliższym otoczeniu.'
        '<br>'
        '<br>Jednocześnie harcerze mają za zadanie zrealizowanie szeregu zadań związanych z lepszym poznaniem lokalnej społeczności. Przykładowe zadania służące temu celowi to:</p>'
        '<ul>'
        '<li><p style="text-align:justify;">Poproście o trzy osoby, żeby zrobiły sobie z Wami zdjęcie pod dowolnym pomnikiem i żeby wysłały je na maila drużynowego</p></li>'
        '<li><p style="text-align:justify;">Dowiedzcie się, jaka jest najciekawsza historia związana z parafią według jednego z księży</p></li>'
        '<li><p style="text-align:justify;">Ustalcie, ile kosztuje najtańsza woda gazowana w mieście</p></li>'
        '<li><p style="text-align:justify;">Dowiedzcie się, w którym roku założone zostało miasto</p></li>'
        '</ul>'
        '<p style="text-align:justify;">Zwiad może być uzupełniony o konkretne zadania lub pytania, na które harcerze podczas wyprawy muszą znaleźć odpowiedzi lub które muszą wykonać.'
        '<br>'
        '<br>Harcerze mogą otrzymać na początku mapę okolicy na której powinni uzupełnić punkty. Mogą także, w trudniejszym, wariancie otrzymać pustą kartkę, na której mapę powinni narysować od podstaw.</p>'
);