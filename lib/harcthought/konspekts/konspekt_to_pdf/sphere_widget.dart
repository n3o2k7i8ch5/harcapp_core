import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'common.dart';

Widget SphereDetailFactorWidget(String detail, Set<KonspektSphereFactor>? factors, Font font, Font fontBold) => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text(detail, style: TextStyle(font: fontBold, fontSize: defTextSize)),
    if(factors != null && factors.length > 0)
      Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: Wrap(
            spacing: defMarg,
            runSpacing: defMarg,
            children: <Widget>[
              Text(
                  factors.length == 1?
                  'Metoda:':
                  'Metody:',
                  style: TextStyle(font: font, fontSize: defTextSize)
              )
            ] + factors.map((f) => f.pdfWidget(font, defTextSize)).toList()
        ),
      )
  ],
);

List<Widget> SphereDetailLevelWidget(KonspektSphereLevel level, KonspektSphereFields data, Font font, Font fontBold) =>  [
  if(level != KonspektSphereLevel.other)
    level.pdfWidget(fontBold, defTextSize),

  if(level != KonspektSphereLevel.other)
    SizedBox(height: .5*defMarg),

  ...spaceWidgets(
    spacing: defMarg,
    children: data.fields.keys.map((detail) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Icon(IconData(MdiIcons.circleMedium.codePoint), size: defTextSize),
        ),

        Expanded(
          child: SphereDetailFactorWidget(detail, data.fields[detail], font, fontBold),
        ),
      ],
    )).toList(),
  )
];

List<Widget> SphereDetailsWidget(KonspektSphereDetails details, Font font, Font fontBold){

  if(details.levels.isEmpty)
    return [Container()];

  List<Widget> result = [];

  result.add(SizedBox(height: 2*defMarg));

  for(MapEntry<KonspektSphereLevel, KonspektSphereFields> entry in details.levels.entries){
    KonspektSphereLevel level = entry.key;
    KonspektSphereFields data = entry.value;

    List<Widget> children = SphereDetailLevelWidget(level, data, font, fontBold);
    children = children.map(
      (child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 2*defMarg),
        child: child
      )
    ).toList();

    result.addAll(children);
    result.add(SizedBox(height: 2*defMarg));
  }

  return result;

}

Widget SphereWidget(KonspektSphere sphere, KonspektSphereDetails? details, Font font, Font fontBold) => Material(
  borderRadius: BorderRadius.circular(defRadius),
  color: cardColor,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Padding(
          padding: const EdgeInsets.only(
              top: 2*defMarg,
              left: 2*defMarg
          ),
          child: Row(
            children: [

              Icon(IconData(sphere.displayIcon.codePoint), size: iconSize),

              SizedBox(width: iconMarg),

              Expanded(
                  child: Text(
                      sphere.displayName,
                      style: TextStyle(font: font, fontSize: headerTextSize)
                  )
              )

            ],
          )
      ),

      SizedBox(height: defMarg),

      if(details != null && sphere == KonspektSphere.duch)
        ...SphereDetailsWidget(details, font, fontBold)
      else if(details != null)
        ...SphereDetailsWidget(details, font, fontBold)

    ],
  ),
);
