import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/spheres_widget.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/steps_widget.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';
import 'cover_widget.dart';
import 'material_tiles.dart';


Widget TitleWidget(Konspekt konspekt, Font fontBold) => Center(
  child: Text(
      konspekt.title,
      style: TextStyle(font: fontBold, fontSize: titleTextSize),
      textAlign: TextAlign.center
  ),
);


Future<Widget> MetoTile(Meto meto, Font fontBold) async => ClipRRect(
    horizontalRadius: defRadius,
    verticalRadius: defRadius,
    child: Container(
        color: color(meto.color),
        child: Row(
          children: [

            SizedBox(width: 3.0),

            SvgImage(
              svg: (await readStringFromAssets(meto.iconSvgPath))!,
              width: defTextSize + 1 + defTextSize + 2*3,
              height: defTextSize + 1 + defTextSize + 2*3,
            ),

            SizedBox(width: 3.0),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  meto.shortDisplayName,
                  style: TextStyle(
                      font: fontBold,
                      fontSize: defTextSize,
                      color: PdfColors.white
                  ),
                ),

                SizedBox(height: 1),

                Text(
                  meto.age,
                  style: TextStyle(
                      font: fontBold,
                      fontSize: defTextSize,
                      color: PdfColors.white
                  ),
                )

              ],
            ),

            SizedBox(width: 6.0),

          ],
        )
    )
);

Future<Widget> MetoListWidget(Konspekt konspekt, Font fontBold) async => Row(
  children: [
    if(konspekt.metos.contains(Meto.zuch))
      await MetoTile(Meto.zuch, fontBold),
    if(konspekt.metos.contains(Meto.zuch))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.harc))
      await MetoTile(Meto.harc, fontBold),
    if(konspekt.metos.contains(Meto.harc))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.hs))
      await MetoTile(Meto.hs, fontBold),
    if(konspekt.metos.contains(Meto.hs))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.wedro))
      await MetoTile(Meto.wedro, fontBold),
    if(konspekt.metos.contains(Meto.wedro))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.kadra))
      await MetoTile(Meto.kadra, fontBold),

  ],
);

Widget TypeWidget(Konspekt konspekt, Font font, Font fontBold) => Column(
  children: [

    SizedBox(height: elementBigSeparator),

    Row(
        children: [
          HeaderWidget('Rodzaj: ', fontBold),
          Text(
              konspekt.type.displayName,
              style: TextStyle(font: font, fontSize: headerTextSize)
          ),
        ]
    )

  ]
);

List<Widget> SummaryWidget(Konspekt konspekt, Font font, Font fontBold) =>
  [
    SizedBox(height: elementBigSeparator),

    HeaderWidget('W skrócie', fontBold),

    SizedBox(height: elementSmallSeparator),

    Text(
        konspekt.summary,
        style: TextStyle(font: font, fontSize: defTextSize),
        textAlign: TextAlign.justify
    ),
  ];

Widget DurationWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.duration == null)
    return Container();

  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: elementBigSeparator),

        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget('Czas: ', fontBold),

              if(konspekt.duration == konspekt.requiredDuration)
                Text(durationToString(konspekt.duration), style: TextStyle(font: font, fontSize: headerTextSize))
              else
                Row(
                  children: [
                    Text('od ', style: TextStyle(font: font, fontSize: headerTextSize)),
                    Text('${durationToString(konspekt.requiredDuration)}', style: TextStyle(font: fontBold, fontSize: headerTextSize)),
                    Text(' do ', style: TextStyle(font: font, fontSize: headerTextSize)),
                    Text('${durationToString(konspekt.duration)}', style: TextStyle(font: fontBold, fontSize: headerTextSize))
                  ]
                )

            ]
        )

      ]
  );

}

Future<List<Widget>> AimsWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
) async {

  if(konspekt.aims.isEmpty)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Cele', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(
      await StringListWidget(
        konspekt.aims,
        font,
        fontHalfBold,
        fontBold,
        fontItalic,
        fontHalfBoldItalic,
        fontBoldItalic
      )
  );

  return widgets;

}

Future<List<Widget>> IntroWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
) async {

  if(konspekt.intro == null)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Wstęp', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(
      await fromHtml(
        htmlString: konspekt.intro!,
        font: font,
        fontHalfBold: fontHalfBold,
        fontBold: fontBold,
        fontItalic: fontItalic,
        fontHalfBoldItalic: fontHalfBoldItalic,
        fontBoldItalic: fontBoldItalic,
        fontSize: defTextSize
      )
  );

  return widgets;

}

Future<List<Widget>> DescriptionWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
) async {

  if(konspekt.description == null)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Opis', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(
      await fromHtml(
          htmlString: konspekt.description!,
          font: font,
          fontHalfBold: fontHalfBold,
          fontBold: fontBold,
          fontItalic: fontItalic,
          fontHalfBoldItalic: fontHalfBoldItalic,
          fontBoldItalic: fontBoldItalic,
          fontSize: defTextSize
      )
  );

  return widgets;

}

Future<List<Widget>> HowToFailWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
) async {

  if(konspekt.howToFail == null)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Jak to spartolić?', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(
      await StringListWidget(
        konspekt.howToFail!,
        font,
        fontHalfBold,
        fontBold,
        fontItalic,
        fontHalfBoldItalic,
        fontBoldItalic
      )
  );

  return widgets;

}

Widget AuthorWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.author == null)
    return Container();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      SizedBox(height: elementBigSeparator),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          HeaderWidget('Autor: ', fontBold),

          Expanded(
            child: Text(
              konspekt.author!.name,
              style: TextStyle(
                font: font,
                fontSize: headerTextSize
              )
            )
          )

        ],
      ),

    ]
  );

}

Future<Uint8List> konspektToPdf(
    Konspekt konspekt,
    { bool withCover = true,
      bool withMetadata = true,
      bool withAims = true,
      bool withMaterials = true,
      List<TimeOfDay>? stepsTimeTable
    }
) async {

  final pdf = Document(pageMode: PdfPageMode.outlines);

  final font = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-L.ttf'))!);
  final fontHalfBold = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-R.ttf'))!);
  final fontBold = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-M.ttf'))!);
  final fontItalic = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-LI.ttf'))!);
  final fontHalfBoldItalic = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-RI.ttf'))!);
  final fontBoldItalic = Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Ubuntu/Ubuntu-MI.ttf'))!);

  List<Widget> multiPage =  [];

  multiPage.add(TitleWidget(konspekt, fontBold));

  multiPage.add(await CoverWidget(konspekt, font, withCover));

  if(withCover)
    multiPage.add(SizedBox(height: elementSmallSeparator));
  else
    multiPage.add(SizedBox(height: elementBigSeparator));

  if(withMetadata)
    multiPage.add(await MetoListWidget(konspekt, fontBold));

  if(withMetadata)
    multiPage.add(TypeWidget(konspekt, font, fontBold));

  if(withMetadata)
    multiPage.addAll(SphereListWidget(konspekt, font, fontBold));

  if(withMetadata)
    multiPage.add(AuthorWidget(konspekt, font, fontBold));

  if(withMetadata)
    multiPage.addAll(SummaryWidget(konspekt, font, fontBold));

  if(withMetadata)
    multiPage.add(DurationWidget(konspekt, font, fontBold));

  if(withAims)
    multiPage.addAll(await AimsWidget(konspekt, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  if(konspekt.materials != null && withMaterials)
    multiPage.addAll(MaterialTiles(konspekt.materials!, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  if(withMetadata)
    multiPage.addAll(await IntroWidget(konspekt, font, fontBold, fontHalfBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  multiPage.addAll(await DescriptionWidget(konspekt, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  multiPage.addAll(await StepsWidget(konspekt, stepsTimeTable, font, fontBold, fontHalfBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  if(withMetadata)
    multiPage.addAll(await HowToFailWidget(konspekt, font, fontBold, fontHalfBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  ByteData fontByteData = await rootBundle.load('packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf');

  pdf.addPage(
      MultiPage(
          pageTheme: PageTheme(
            pageFormat: PdfPageFormat.a4,
            theme: ThemeData.withFont(
              icons: Font.ttf(fontByteData)
            ),
          ),
          build: (context) => multiPage,
          footer: (context) => Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Row(
                children: [
                  Text(
                    'Konspekt z aplikacji HarcApp',
                    style: TextStyle(
                      font: font,
                      fontSize: defTextSize,
                      color: PdfColors.grey,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Strona ${context.pageNumber} z ${context.pagesCount}',
                    style: TextStyle(
                      font: font,
                      fontSize: defTextSize,
                      color: PdfColors.grey,
                    ),
                  )
                ]
            )
          ),
          maxPages: 100
      )
  );

  return await pdf.save();

}