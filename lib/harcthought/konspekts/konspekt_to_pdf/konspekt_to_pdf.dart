import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import 'common.dart';

double elementBigSeparator = 24.0;
double elementSmallSeparator = 6.0;
double konspektSeparator = 48.0;

double defTextTiny = Dimen.textSizeTiny;
double defTextSize = Dimen.textSizeSmall;
double headerTextSize = Dimen.textSizeBig;
double titleTextSize = Dimen.textSizeAppBar;


PdfColor cardColor = PdfColors.grey100;


Widget TitleWidget(Konspekt konspekt, Font fontBold) => Center(
  child: Text(
      konspekt.title,
      style: TextStyle(font: fontBold, fontSize: titleTextSize)
  ),
);

Future<Widget> CoverWidget(Konspekt konspekt, Font font, bool withCover) async {

  if(!withCover)
    return Container();

  return Column(
      children: [

        SizedBox(height: elementBigSeparator),

        ClipRRect(
          horizontalRadius: AppCard.defRadius,
          verticalRadius: AppCard.defRadius,
          child: Stack(
            children: [

              Image(await imageFromAssetBundle(konspekt.coverPath)),

              Positioned(
                bottom: elementSmallSeparator,
                right: elementSmallSeparator,
                child: ClipRRect(
                    horizontalRadius: AppCard.defRadius,
                    verticalRadius: AppCard.defRadius,
                    child: Container(
                      color: PdfColors.white,
                      child: Padding(
                        padding: EdgeInsets.all(elementSmallSeparator),
                        child: Text(
                          "Żródło: ${konspekt.coverAuthor}",
                          style: TextStyle(
                            font: font,
                            fontSize: defTextSize
                          )
                        )
                      )
                    )
                )
              ),

            ]
          ),
        ),

      ]
  );
}

Future<Widget> MetoTile(Meto meto, Font fontBold, {double iconSize = Dimen.iconSize}) async => ClipRRect(
    horizontalRadius: AppCard.defRadius,
    verticalRadius: AppCard.defRadius,
    child: Container(
        color: color(meto.color),
        child: Row(
          children: [

            SizedBox(width: Dimen.defMarg/2),

            SvgImage(
              svg: (await readStringFromAssets(meto.iconSvgPath))!,
              width: iconSize,
              height: iconSize,
            ),

            SizedBox(width: Dimen.defMarg/2),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  meto.shortDisplayName,
                  style: TextStyle(
                      font: fontBold,
                      fontSize: Dimen.textSizeNormal,
                      color: PdfColors.white
                  ),
                ),

                SizedBox(height: 3.0),

                Text(
                  meto.age,
                  style: TextStyle(
                      font: fontBold,
                      fontSize: Dimen.textSizeSmall,
                      color: PdfColors.white
                  ),
                )

              ],
            ),

            SizedBox(width: Dimen.iconMarg),

          ],
        )
    )
);

Future<Widget> MetoListWidget(Konspekt konspekt, Font fontBold) async => Row(
  children: [
    if(konspekt.metos.contains(Meto.zuch))
      await MetoTile(Meto.zuch, fontBold, iconSize: 42.0),
    if(konspekt.metos.contains(Meto.zuch))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.harc))
      await MetoTile(Meto.harc, fontBold, iconSize: 42.0),
    if(konspekt.metos.contains(Meto.harc))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.hs))
      await MetoTile(Meto.hs, fontBold, iconSize: 42.0),
    if(konspekt.metos.contains(Meto.hs))
      SizedBox(width: elementSmallSeparator),

    if(konspekt.metos.contains(Meto.wedro))
      await MetoTile(Meto.wedro, fontBold, iconSize: 42.0),

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

Widget SphereWidget(KonspektSphere sphere, KonspektSphereDetails? details, Font font, Font fontBold) => ClipRRect(
  horizontalRadius: AppCard.defRadius,
  verticalRadius: AppCard.defRadius,
  child: Container(
    color: cardColor,
    child: Padding(
        padding: EdgeInsets.all(2*elementSmallSeparator),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                  children: [

                    Icon(IconData(sphere.displayIcon.codePoint)),

                    SizedBox(width: elementSmallSeparator),

                    Text(sphere.displayName, style: TextStyle(font: font))

                  ]
              ),

              if(details != null)
                SizedBox(height: 2*elementSmallSeparator),

              if(details != null && details.level.isNotEmpty)
                Text(sphere == KonspektSphere.duch?'Poziom duchowości:':'Poziom:', style: TextStyle(font: font)),

              if(details != null && details.level.isNotEmpty)
                Builder(
                    builder: (context){

                      List<Widget> widgets = [];
                      for(int i=0; i<details.level.length; i++){
                        widgets.add(
                            Text(
                                details.level[i].displayName,
                                style: TextStyle(
                                    font: fontBold,
                                    color: color(details.level[i].color)
                                )
                            )
                        );
                        if(i<details.level.length -1)
                          widgets.add(SizedBox(width: elementSmallSeparator));
                      }

                      return Padding(
                        padding: EdgeInsets.only(top: elementSmallSeparator/2),
                        child: Row(children: widgets)
                      );
                    }
                ),

              if(details != null && details.level.isNotEmpty)
                SizedBox(height: 2*elementSmallSeparator),

              if(details != null && details.mechanism.isNotEmpty)
                Text('Mechanizmy:'),

              if(details != null && details.mechanism.isNotEmpty)
                Builder(
                  builder: (context){

                    List<Widget> widgets = [];
                    for(int i=0; i<details.mechanism.length; i++){
                      widgets.add(Text(details.mechanism[i].displayName, style: TextStyle(font: fontBold)));
                      if(i<details.mechanism.length -1)
                        widgets.add(SizedBox(width: elementSmallSeparator));
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: elementSmallSeparator/2),
                      child: Row(children: widgets)
                    );
                  }
                )

            ]
        )
    )
  )
);

Widget SphereListWidget(Konspekt konspekt, Font font, Font fontBold){

  List<Widget> widgets = [];

  for(int i=0; i<konspekt.spheres.length; i++) {
    KonspektSphere sphere = konspekt.spheres.keys.toList()[i];
    KonspektSphereDetails? details = konspekt.spheres[sphere];
    widgets.add(SphereWidget(sphere, details, font, fontBold));
    if(i<konspekt.spheres.length-1)
      widgets.add(SizedBox(width: elementSmallSeparator));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      SizedBox(height: elementBigSeparator),

      HeaderWidget('Sfery rozwoju', fontBold),

      SizedBox(height: elementSmallSeparator),

      Row(children: widgets, crossAxisAlignment: CrossAxisAlignment.start)

    ]
  );

}

List<Widget> SummaryWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.summary == null)
    return [];

  return [
    SizedBox(height: elementBigSeparator),

    HeaderWidget('W skrócie', fontBold),

    SizedBox(height: elementSmallSeparator),

    Text(
        konspekt.summary!,
        style: TextStyle(font: font, fontSize: defTextSize),
        textAlign: TextAlign.justify
    ),
  ];

}

Widget DurationWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.duration == null)
    return Container();

  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: elementBigSeparator),

        Row(
            children: [
              HeaderWidget('Czas: ', fontBold),
              Text(
                durationToString(konspekt.duration!),
                style: TextStyle(font: font, fontSize: headerTextSize),
              ),
            ]
        )

      ]
  );

}

List<Widget> AimsWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.aims.isEmpty)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Cele', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(StringListWidget(konspekt.aims, font));

  return widgets;

}

Widget MaterialAmountWidget(KonspektMaterial material, Font font, Font fontBold, Font fontItalic){

  if(material.amountAttendantFactor != null)
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Text(
          'x',
          style: TextStyle(
            font: fontBold,
            fontSize: headerTextSize,
          ),
        ),

        SizedBox(width: elementSmallSeparator),

        Text(
          '${material.amountAttendantFactor}',
          style: TextStyle(
            font: fontBold,
            fontSize: headerTextSize,
          ),
        ),

        SizedBox(width: elementSmallSeparator),

        Text(
          'Liczba\nuczest.',
          style: TextStyle(
            font: fontBold,
            fontSize: defTextTiny,
          ),
        )

      ],
    );

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [

      Text(
        'x',
        style: TextStyle(
          font: fontBold,
          fontSize: headerTextSize,
        ),
      ),

      SizedBox(width: elementSmallSeparator),

      Text(
        '${material.amount}',
        style: TextStyle(
          font: fontBold,
          fontSize: headerTextSize,
        ),
      ),

    ],
  );

}

Widget MaterialWidget(KonspektMaterial material, Font font, Font fontBold, Font fontItalic) => ClipRRect(
  horizontalRadius: AppCard.defRadius,
  verticalRadius: AppCard.defRadius,
  child: Container(
    color: cardColor,
    child: Padding(
      padding: EdgeInsets.all(elementSmallSeparator),
      child: Column(
          children: [

            Row(
                children: [
                  Expanded(
                      child: Text(
                          material.name,
                          style: TextStyle(font: font, fontSize: defTextSize)
                      )
                  ),
                  if(material.amount != 0)
                    SizedBox(
                        width: 94,
                        child: MaterialAmountWidget(material, font, fontBold, fontItalic)
                    ),
                ]
            ),

            if(material.comment != null)
              SizedBox(height: elementSmallSeparator),

            if(material.comment != null)
              Text(
                  material.comment!,
                  style: TextStyle(fontSize: defTextSize, height: 1.2, color: PdfColors.grey)
              ),

            if(material.additionalPreparation != null)
              SizedBox(height: elementSmallSeparator),

            if(material.additionalPreparation != null)
              ClipRRect(
                  horizontalRadius: AppCard.defRadius,
                  verticalRadius: AppCard.defRadius,
                  child: Container(
                      color: PdfColors.white,
                      child: Padding(
                          padding: EdgeInsets.all(elementSmallSeparator),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Text(
                                'Wymagane dodatkowe przygotowanie:',
                                style: TextStyle(font: fontBold)
                              ),

                              SizedBox(height: elementSmallSeparator),

                              Text(
                                  material.additionalPreparation!,
                                  style: TextStyle(font: font),
                                  textAlign: TextAlign.justify
                              )
                            ]
                          )
                      )
                  )
              )

]
      )
    )
  )
);

List<Widget> MaterialListWidget(Konspekt konspekt, Font font, Font fontBold, Font fontItalic){

  if(konspekt.materials == null)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Materiały', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  for(int i=0; i<konspekt.materials!.length; i++){
    widgets.add(MaterialWidget(konspekt.materials![i], font, fontBold, fontItalic));
    if(i < konspekt.materials!.length - 1)
      widgets.add(SizedBox(height: elementSmallSeparator));
  }

  return widgets;

}

Future<List<Widget>> IntroWidget(Konspekt konspekt, Font font, Font fontBold, Font fontItalic) async {

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
        fontItalic: fontItalic,
        fontBold: fontBold,
      )
  );

  return widgets;

}

Future<List<Widget>> DescriptionWidget(Konspekt konspekt, Font font, Font fontBold, Font fontItalic) async {

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
          fontBold: fontBold,
          fontItalic: fontItalic
      )
  );

  return widgets;

}

Future<List<Widget>> StepWidget(KonspektStep step, int index, Font font, Font fontBold, Font fontItalic) async {
  double numberFontSize = 16.0;
  double numberCircleSize = 2*elementSmallSeparator + numberFontSize;

  List<Widget> widgets = [
    Row(
      children: [

        SizedBox(
            width: numberCircleSize,
            height: numberCircleSize,
            child: ClipRRect(
                horizontalRadius: AppCard.defRadius,
                verticalRadius: AppCard.defRadius,
                child: Container(
                  color: PdfColors.grey,
                  child: Center(
                    child: Text(
                        '${index + 1}.',
                        style: TextStyle(
                            fontSize: 16,
                            font: fontBold,
                            color: PdfColors.white
                        )
                    ),
                  ),
                )
            )
        ),

        SizedBox(width: .5*elementBigSeparator),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
                step.title,
                style: TextStyle(font: font, fontSize: defTextSize)
            ),

            SizedBox(height: 3.0),

            Row(
              children: [

                Text(durationToString(step.duration), style: TextStyle(font: font, fontSize: defTextSize)),

                SizedBox(width: 20),

                Text(
                    step.activeForm?'Forma aktywna':'Forma pasywna',
                    style: TextStyle(
                      color: color(step.activeForm?Colors.green:Colors.deepOrange),
                      font: fontBold,
                    )
                ),

                SizedBox(width: 20),

                if(!step.required)
                  Text(
                      '[opcjonalnie]',
                      style: TextStyle(
                          fontSize: defTextSize,
                          color: PdfColors.grey
                      )
                  ),

              ],
            ),

          ],
        )

      ],
    ),
  ];

  List<Widget> htmlWidgets = await fromHtml(htmlString: step.content, font: font, fontBold: fontBold, fontItalic: fontItalic);

  widgets.addAll(
      htmlWidgets.map(
              (widget) => Padding(
              padding: EdgeInsets.only(
                  top: .5*elementBigSeparator,
                  left: numberCircleSize + .5*elementBigSeparator
              ),
              child: widget
          )
      ).toList()
  );

  return widgets;
}

Future<List<Widget>> StepListWidget(Konspekt konspekt, Font font, Font fontBold, Font fontItalic) async {

  if(konspekt.steps == null)
    return [];

  List<Widget> stepWidgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Plan', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  for(int i=0; i<konspekt.steps!.length; i++) {
    stepWidgets.addAll(await StepWidget(konspekt.steps![i], i, font, fontBold, fontItalic));
    if(i<konspekt.steps!.length - 1)
      stepWidgets.add(SizedBox(height: 1.5*elementBigSeparator));
  }

  return stepWidgets;

}

List<Widget> HowToFailWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.howToFail == null)
    return [];

  List<Widget> widgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Jak to spartolić?', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  widgets.addAll(StringListWidget(konspekt.howToFail!, font));

  return widgets;

}

Widget AuthorWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.author == null)
    return Container();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [

      SizedBox(height: elementBigSeparator),

      Row(
        children: [

          HeaderWidget('Autor: ', fontBold),

          Text(
              konspekt.author!.name,
              style: TextStyle(
                  font: font,
                  fontSize: headerTextSize
              )
          ),

        ],
      ),

    ]
  );

}

Future<OpenResult> konspektToPdf(Konspekt konspekt, {bool withCover = true}) async {

  final pdf = Document(pageMode: PdfPageMode.outlines);
  final font = await PdfGoogleFonts.latoRegular();
  final fontItalic = await PdfGoogleFonts.latoItalic();
  final fontBold = await PdfGoogleFonts.latoBold();

  List<Widget> multiPage =  [];

  multiPage.add(TitleWidget(konspekt, fontBold));

  multiPage.add(await CoverWidget(konspekt, font, withCover));

  if(withCover)
    multiPage.add(SizedBox(height: elementSmallSeparator));
  else
    multiPage.add(SizedBox(height: elementBigSeparator));

  multiPage.add(await MetoListWidget(konspekt, fontBold));

  multiPage.add(TypeWidget(konspekt, font, fontBold));

  multiPage.add(SphereListWidget(konspekt, font, fontBold));

  multiPage.add(AuthorWidget(konspekt, font, fontBold));

  multiPage.addAll(SummaryWidget(konspekt, font, fontBold));

  multiPage.add(DurationWidget(konspekt, font, fontBold));

  multiPage.addAll(AimsWidget(konspekt, font, fontBold));

  multiPage.addAll(MaterialListWidget(konspekt, font, fontBold, fontItalic));

  multiPage.addAll(await IntroWidget(konspekt, font, fontBold, fontItalic));

  multiPage.addAll(await DescriptionWidget(konspekt, font, fontBold, fontItalic));

  multiPage.addAll(await StepListWidget(konspekt, font, fontBold, fontItalic));

  multiPage.addAll(HowToFailWidget(konspekt, font, fontBold));

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
          footer: (context) => Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Strona ${context.pageNumber} z ${context.pagesCount}',
              style: TextStyle(
                fontSize: defTextSize,
                color: PdfColors.grey,
              ),
            ),
          ),
          maxPages: 100
      )
  );

  final output = await getTemporaryDirectory();

  final file = File(join(output.path, 'Konspekt - ${konspekt.title}.pdf'));
  file.writeAsBytesSync(await pdf.save());

  return await OpenFilex.open(file.path);

}