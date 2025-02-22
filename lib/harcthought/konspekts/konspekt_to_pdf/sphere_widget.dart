import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'common.dart';

Widget SphereDetailFactorWidget(String detail, Set<KonspektSphereFactor>? factors, Font font, Font fontBold) => Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text(detail, style: TextStyle(font: fontBold)),
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

Widget SphereDetailLevelWidget(KonspektSphereLevel level, Map<String, Set<KonspektSphereFactor>?> data, Font font, Font fontBold){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if(level != KonspektSphereLevel.other)
        level.pdfWidget(fontBold, defTextSize),

      if(level != KonspektSphereLevel.other)
        SizedBox(height: .5*defMarg),

      ...spaceWidgets(
        spacing: defMarg,
        children: data.keys.map((detail) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(IconData(MdiIcons.circleMedium.codePoint), size: defTextSize),
            ),

            Expanded(
              child: SphereDetailFactorWidget(detail, data[detail], font, fontBold),
            ),
          ],
        )).toList(),
      )
    ],
  );
  
}

Widget SphereDetailsWidget(KonspektSphereDetails details, Font font, Font fontBold){

  if(details.levels == null || details.levels!.isEmpty)
    return Container();

  return Padding(
    padding: const EdgeInsets.all(2*defMarg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: spaceWidgets(
        spacing: 2*defMarg,
        children: details.levels!.keys.map((level) =>
          SphereDetailLevelWidget(
            level,
            details.levels![level]!,
            font,
            fontBold
          )
        ).toList(),
      )
    ),
  );

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

      SizedBox(height: 2*defMarg),

      if(details != null && sphere == KonspektSphere.duch)
        SphereDetailsWidget(details, font, fontBold)
      else if(details != null)
        SphereDetailsWidget(details, font, fontBold)

    ],
  ),
);
