import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/values/people/data.dart';

import '../level_examples.dart';

const String attach_html_wycinki_informacji = '<a href="${attach_name_wycinki_informacji}@attachment">${attach_title_wycinki_informacji}</a>';
const String attach_name_wycinki_informacji = "wycinki_informacji";
const String attach_title_wycinki_informacji = "Wycinki informacji";
const KonspektAttachment attach_wycinki_informacji = KonspektAttachment(
  name: attach_name_wycinki_informacji,
  title: attach_title_wycinki_informacji,
  assets: {
    FileFormat.pdf: 'wycinki_informacji.pdf'
  },
);

Konspekt gang_potencjalnych_porywaczy = Konspekt(
  name: 'gang_potencjalnych_porywaczy',
  title: 'Gang potencjalnych porywaczy',
  category: KonspektCategory.harcerskie,
  type: KonspektType.zajecia,
  spheres: {
    KonspektSphere.umysl: KonspektSphereDetails(
      levels: {
        KonspektSphereLevel.other: KonspektSphereFields(
          fields: {
          umyslLogiczneMyslenie: null,
        }
        )
      },
    ),
    KonspektSphere.relacje: KonspektSphereDetails(
      levels: {
        KonspektSphereLevel.other: KonspektSphereFields(
          fields: {
          relWspolpracaWGrupie: null,
        }
        )
      },
    )
  },

  metos: [Meto.harc, Meto.hs],
  coverAuthor: 'freepik.com (vector_corp)',
  author: JULIA_JAROSZ,
  customDuration: Duration(hours: 3),
  aims: [
    'Poprawa umiejętności pracy w zespole i przyjmowania potrzebnych w zespole ról.',
    'Poprawa umiejętności koordynowania działań w zespole.',
    'Poprawa umiejętności analizy i dyskryminowania między informacjami ważnymi i nieważnymi.',
  ],

  materials: [
    KonspektMaterial(
      amount: 1,
      name: 'Wydrukowany załącznik “$attach_title_wycinki_informacji”',
      additionalPreparation: 'Wydrukowany załącznik należy pociąć wzdłuż przerywanych linii.',
      attachmentName: attach_name_wycinki_informacji,
    ),
  ],

  summary: 'Harcerze dowiadują się, że dokonano porwania. Zdobywają liczne informacje na ten temat, po czym ich zadaniem jest dokonać ich syntezy i ustalić tożsamość porywaczy.',

  intro: '<p style="text-align:justify;">Harcerze dowiadują się, że <b>nad ranem</b> w <b>weekend</b> dokonano porwania ważnej osoby. Policja ustaliła już, że za porwaniem stoi jeden z działających w okolicy gangów.'
      '<br>'
      '<br>Harcerze wyruszają, by zdobyć informacje o gangach. Ich zadaniem jest zebrać jak najwięcej informacji, przeanalizować je i wskazać, który gang, ich zdaniem, dokonał porwania. Wnioski harcerzy muszą być poparte argumentami.</p>',
  description: '<p style="text-align:justify;">Lista okolicznych gangów:</p>'
      '<ul>'
      '<li><p>Gang Olszaka</p></li>'
      '<li><p>Szajka Łysego</p></li>'
      '<li><p>Świnki trzy</p></li>'
      '<li><p>Łaciata paczka</p></li>'
      '<li><p>Grupa Mariana</p></li>'
      '<li><p>Nowa ekipa</p></li>'
      '<li><p>Dzika wataha</p></li>'
      '<li><p>Robaczek i spółka</p></li>'
      '<li><p>Kolorowe irokezy</p></li>'
      '</ul>'
      '<p style="text-align:justify;">Harcerze mają do zdobycia 64 wycinki informacji (załącznik: $attach_html_wycinki_informacji). Spośród nich jedynie 8 wycinków ma znaczenie dla sprawy, ponieważ dają alibi niektórym gangom - pozostałe wycinki nie mają żadnego znaczenia.'
      '<br>'
      '<br>Alibi posiadają następujące gangi:</p>'
      '<ul>'
      '<li><p>Gang Olszaka</p></li>'
      '<li><p>Szajka Łysego</p></li>'
      '<li><p>Świnki trzy</p></li>'
      '<li><p>Łaciata paczka</p></li>'
      '<li><p>Dzieci ulicy</p></li>'
      '<li><p>Grupa Mariana</p></li>'
      '<li><p>Nowa ekipa</p></li>'
      '<li><p>Dzika wataha</p></li>'
      '</ul>'
      '<p style="text-align:justify;">Alibi nie posiadają następujące gangi:</p>'
      '<ul>'
      '<li><p>Robaczek i spółka</p></li>'
      '<li><p>Kolorowe irokezy</p></li>'
      '</ul>'
      '<p style="text-align:justify;">Trudność gry polega na odpowiednim skoordynowaniu działań przez harcerzy i uporządkowaniu zebranych informacje.'
      '<br>'
      '<br><b>Grę można uprościć</b> podając harcerzom wskazówkę: wycinki informacji są opatrzone kolorami i w każdej grupie danego koloru kluczowy jest tylko jeden wycinek.'
      '<br>'
      '<br><b>Grę można utrudnić</b> sprawiając, by żadna osoba lub grupa nie zdobyła zbyt dużej liczby wycinków informacji i by była skazana na współpracę z innymi.'
      '<br>'
      '<br>Forma zdobywania wycinków informacji jest dowolna: mogą one być nagrodą w innej grze za wykonane zadania, mogą być schowane na określonym terenie, itp..</p>',
  attachments: [
    attach_wycinki_informacji
  ],
);