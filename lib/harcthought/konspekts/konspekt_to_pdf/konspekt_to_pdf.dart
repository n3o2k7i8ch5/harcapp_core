import 'package:flutter/material.dart' show Colors;
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';
import 'package:printing/printing.dart';

import 'common.dart';

double elementBigSeparator = 24.0;
double elementSmallSeparator = 6.0;
double konspektSeparator = 48.0;

double defRadius = 4;


PdfColor cardColor = PdfColors.grey100;


Widget TitleWidget(Konspekt konspekt, Font fontBold) => Center(
  child: Text(
      konspekt.title,
      style: TextStyle(font: fontBold, fontSize: titleTextSize),
      textAlign: TextAlign.center
  ),
);

Future<Widget> CoverWidget(Konspekt konspekt, Font font, bool withCover) async {

  if(!withCover)
    return Container();

  return Column(
      children: [

        SizedBox(height: elementBigSeparator),

        ClipRRect(
          horizontalRadius: defRadius,
          verticalRadius: defRadius,
          child: Stack(
            children: [

              Image(await imageFromAssetBundle(konspekt.coverPath)),

              Positioned(
                bottom: elementSmallSeparator,
                right: elementSmallSeparator,
                child: ClipRRect(
                    horizontalRadius: defRadius,
                    verticalRadius: defRadius,
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

Widget SphereWidget(KonspektSphere sphere, KonspektSphereDetails? details, Font font, Font fontBold) => ClipRRect(
  horizontalRadius: defRadius,
  verticalRadius: defRadius,
  child: Container(
    color: cardColor,
    child: Padding(
        padding: EdgeInsets.all(1.5*elementSmallSeparator),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                  children: [

                    Icon(
                      IconData(sphere.displayIcon.codePoint),
                      size: 18.0
                    ),

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

  if(konspekt.spheres.isEmpty)
    return Container();

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

Widget MaterialAmountWidget(
    KonspektMaterial material,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
  ){

  if(material.amountAttendantFactor != null)
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Text(
          'x',
          style: TextStyle(
            font: fontHalfBold,
            fontSize: headerTextSize,
          ),
        ),

        SizedBox(width: elementSmallSeparator/2),

        Text(
          '${material.amountAttendantFactor}',
          style: TextStyle(
            font: fontHalfBold,
            fontSize: headerTextSize,
          ),
        ),

        SizedBox(width: elementSmallSeparator),

        Text(
          'Liczba\nuczest.',
          style: TextStyle(
            font: fontHalfBold,
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

Widget MaterialWidget(
    KonspektMaterial material,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
    { bool showComment = true,
      bool showAdditionalPreparation = true,
      PdfColor? backgroundColor
    }
) => ClipRRect(
  horizontalRadius: defRadius,
  verticalRadius: defRadius,
  child: Container(
    color: backgroundColor??cardColor,
    child: Padding(
      padding: EdgeInsets.all(elementSmallSeparator),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Row(
                children: [
                  Expanded(
                      child: Text(
                          material.name,
                          style: TextStyle(font: font, fontSize: defTextSize)
                      )
                  ),
                  if(material.hasAmount)
                    SizedBox(width: elementSmallSeparator),
                  if(material.hasAmount)
                    MaterialAmountWidget(material, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic),
                ]
            ),

            if(material.comment != null && showComment)
              SizedBox(height: elementSmallSeparator),

            if(material.comment != null && showComment)
              Text(
                  material.comment!,
                  style: TextStyle(font: font, fontSize: defTextSize, height: 1.2, color: PdfColors.grey)
              ),

            if(material.additionalPreparation != null && showAdditionalPreparation)
              SizedBox(height: elementSmallSeparator),

            if(material.additionalPreparation != null && showAdditionalPreparation)
              ClipRRect(
                  horizontalRadius: defRadius,
                  verticalRadius: defRadius,
                  child: Container(
                      color: PdfColors.white,
                      child: Padding(
                          padding: EdgeInsets.all(elementSmallSeparator),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Text(
                                'Wymagane dodatkowe przygotowanie:',
                                style: TextStyle(font: fontBold, fontSize: defTextSize),
                              ),

                              SizedBox(height: elementSmallSeparator),

                              Text(
                                  material.additionalPreparation!,
                                  style: TextStyle(font: font, fontSize: defTextSize),
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

List<Widget> MaterialListWidget(
    List<KonspektMaterial> materials,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic,
    { bool showComment = true,
      bool showAdditionalPreparation = true,
      PdfColor? backgroundColor,
      bool withHeader = true,
    }
){

  List<Widget> widgets = [];

  if(withHeader)
    widgets.addAll(
        [

          SizedBox(height: elementBigSeparator),

          HeaderWidget('Materiały', fontBold),

          SizedBox(height: elementSmallSeparator),

        ]
    );


  for(int i=0; i<materials.length; i++){
    widgets.add(
        MaterialWidget(
            materials[i],
            font,
            fontHalfBold,
            fontBold,
            fontItalic,
            fontHalfBoldItalic,
            fontBoldItalic,
            showComment: showComment,
            showAdditionalPreparation: showAdditionalPreparation,
            backgroundColor: backgroundColor
        )
    );
    if(i < materials.length - 1)
      widgets.add(SizedBox(height: elementSmallSeparator));
  }

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

Future<List<Widget>> StepWidget(
    KonspektStep step,
    int index,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
) async {
  double numberFontSize = 16.0;
  double numberCircleSize = 2*elementSmallSeparator + numberFontSize;

  List<Widget> widgets = [
    Row(
      children: [

        SizedBox(
            width: numberCircleSize,
            height: numberCircleSize,
            child: ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
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

                SizedBox(width: 16),

                Text(
                    step.activeForm?'Forma aktywna':'Forma pasywna',
                    style: TextStyle(
                      font: fontBold,
                      fontSize: defTextSize,
                      color: color(step.activeForm?Colors.green:Colors.deepOrange),
                    )
                ),

                SizedBox(width: 16),

                if(!step.required)
                  Text(
                      '[opcjonalnie]',
                      style: TextStyle(
                        font: font,
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

  if(step.aims != null)
    widgets.add(
        Padding(
            padding: EdgeInsets.only(
              top: .5*elementBigSeparator,
              left: numberCircleSize + .5*elementBigSeparator,
            ),
            child: ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
                child: Container(
                    color: cardColor,
                    child: Padding(
                        padding: EdgeInsets.all(elementSmallSeparator),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            SizedBox(height: .5*elementSmallSeparator),

                            Padding(
                                padding: EdgeInsets.only(
                                  top: .5*elementSmallSeparator,
                                  left: .5*elementSmallSeparator,
                                  bottom: 1.5*elementSmallSeparator,
                                ),
                                child: Text(
                                    'Cele kroku',
                                    style: TextStyle(
                                      font: fontBold,
                                      fontSize: defTextSize,
                                    )
                                )
                            ),

                              ...await StringListWidget(
                                  step.aims!,
                                  font,
                                  fontHalfBold,
                                  fontBold,
                                  fontItalic,
                                  fontHalfBoldItalic,
                                  fontBoldItalic
                              ),

                            ]
                        )
                    )
                )
            )
        )
    );

  if(step.materials != null)
    widgets.add(
        Padding(
            padding: EdgeInsets.only(
              top: .5*elementBigSeparator,
              left: numberCircleSize + .5*elementBigSeparator,
            ),
            child: ClipRRect(
                horizontalRadius: defRadius,
                verticalRadius: defRadius,
                child: Container(
                    color: cardColor,
                    child: Padding(
                        padding: EdgeInsets.all(elementSmallSeparator),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              Padding(
                                  padding: EdgeInsets.only(
                                    top: .5*elementSmallSeparator,
                                    left: .5*elementSmallSeparator,
                                    bottom: 1.5*elementSmallSeparator,
                                  ),
                                  child: Text(
                                      'Materiały kroku',
                                      style: TextStyle(
                                        font: fontBold,
                                        fontSize: defTextSize,
                                      )
                                  )
                              ),

                              ...await MaterialListWidget(
                                  step.materials!,
                                  font,
                                  fontHalfBold,
                                  fontBold,
                                  fontItalic,
                                  fontHalfBoldItalic,
                                  fontBoldItalic,
                                  showComment: false,
                                  showAdditionalPreparation: false,
                                  backgroundColor: PdfColors.white,
                                  withHeader: false
                              ),

                            ]
                        )
                    )
                )
            )
        )
    );

  List<Widget> htmlWidgets = await fromHtml(
      htmlString: step.content??step.contentBuilder!(isDark: false),
      font: font,
      fontHalfBold: fontHalfBold,
      fontBold: fontBold,
      fontItalic: fontItalic,
      fontHalfBoldItalic: fontHalfBoldItalic,
      fontBoldItalic: fontBoldItalic,
      fontSize: defTextSize
  );

  widgets.add(SizedBox(height: .5*elementBigSeparator));

  for(Widget widget in htmlWidgets)
    widgets.add(
        Padding(
            padding: EdgeInsets.only(
                left: numberCircleSize + .5*elementBigSeparator
            ),
            child: widget
        )
    );

  return widgets;
}

Future<List<Widget>> StepListWidget(
    Konspekt konspekt,
    Font font,
    Font fontHalfBold,
    Font fontBold,
    Font fontItalic,
    Font fontHalfBoldItalic,
    Font fontBoldItalic
) async {

  if(konspekt.steps == null)
    return [];

  List<Widget> stepWidgets = [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Plan', fontBold),

    SizedBox(height: elementSmallSeparator),

  ];

  for(int i=0; i<konspekt.steps!.length; i++) {
    stepWidgets.addAll(
        await StepWidget(
            konspekt.steps![i],
            i,
            font,
            fontHalfBold,
            fontBold,
            fontItalic,
            fontHalfBoldItalic,
            fontBoldItalic
        )
    );
    if(i<konspekt.steps!.length - 1)
      stepWidgets.add(SizedBox(height: 1.5*elementBigSeparator));
  }

  return stepWidgets;

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

Future<Uint8List> konspektToPdf(Konspekt konspekt, {bool withCover = true}) async {

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

  multiPage.add(await MetoListWidget(konspekt, fontBold));

  multiPage.add(TypeWidget(konspekt, font, fontBold));

  multiPage.add(SphereListWidget(konspekt, font, fontBold));

  multiPage.add(AuthorWidget(konspekt, font, fontBold));

  multiPage.addAll(SummaryWidget(konspekt, font, fontBold));

  multiPage.add(DurationWidget(konspekt, font, fontBold));

  multiPage.addAll(await AimsWidget(konspekt, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  if(konspekt.materials != null)
    multiPage.addAll(MaterialListWidget(konspekt.materials!, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  multiPage.addAll(await IntroWidget(konspekt, font, fontBold, fontHalfBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  multiPage.addAll(await DescriptionWidget(konspekt, font, fontHalfBold, fontBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

  multiPage.addAll(await StepListWidget(konspekt, font, fontBold, fontHalfBold, fontItalic, fontHalfBoldItalic, fontBoldItalic));

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