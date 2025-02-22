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
                  style: TextStyle(font: font)
              )
            ] + factors.map((f) => f.pdfWidget(font)).toList()
        ),
      )
  ],
);

Widget SphereDetailLevelWidget(KonspektSphereLevel level, Map<String, Set<KonspektSphereFactor>?> data, Font font, Font fontBold){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if(level != KonspektSphereLevel.other)
        level.pdfWidget(fontBold),

      if(level != KonspektSphereLevel.other)
        SizedBox(height: .5*defMarg),

      ColumnSpacing(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: defMarg,
        children: data.keys.map((detail) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(IconData(MdiIcons.circleMedium.codePoint), size: TextStyle.defaultStyle().fontSize),
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
    child: ColumnSpacing(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 2*defMarg,
      children: details.levels!.keys.map((level) =>
          SphereDetailLevelWidget(
            level,
            details.levels![level]!,
            font,
            fontBold
          )
      ).toList(),
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

              Icon(IconData(sphere.displayIcon.codePoint)),

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


//
// Widget SphereWidget(KonspektSphere sphere, KonspektSphereDetails? details, Font font, Font fontBold) => ClipRRect(
//   horizontalRadius: defRadius,
//   verticalRadius: defRadius,
//   child: Container(
//     color: cardColor,
//     child: Padding(
//         padding: EdgeInsets.all(1.5*elementSmallSeparator),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Row(
//                   children: [
//
//                     Icon(
//                       IconData(sphere.displayIcon.codePoint),
//                       size: 18.0
//                     ),
//
//                     SizedBox(width: elementSmallSeparator),
//
//                     Text(sphere.displayName, style: TextStyle(font: font))
//
//                   ]
//               ),
//
//               if(details != null)
//                 SizedBox(height: 2*elementSmallSeparator),
//
//               if(details != null && details.level.isNotEmpty)
//                 Text(sphere == KonspektSphere.duch?'Poziom duchowości:':'Poziom:', style: TextStyle(font: font)),
//
//               if(details != null && details.level.isNotEmpty)
//                 Builder(
//                     builder: (context){
//
//                       List<Widget> widgets = [];
//                       for(int i=0; i<details.level.length; i++){
//                         widgets.add(
//                             Text(
//                                 details.level[i].displayName,
//                                 style: TextStyle(
//                                     font: fontBold,
//                                     color: color(details.level[i].color)
//                                 )
//                             )
//                         );
//                         if(i<details.level.length -1)
//                           widgets.add(SizedBox(width: elementSmallSeparator));
//                       }
//
//                       return Padding(
//                         padding: EdgeInsets.only(top: elementSmallSeparator/2),
//                         child: Row(children: widgets)
//                       );
//                     }
//                 ),
//
//               if(details != null && details.level.isNotEmpty)
//                 SizedBox(height: 2*elementSmallSeparator),
//
//               if(details != null && details.mechanism.isNotEmpty)
//                 Text('Mechanizmy:'),
//
//               if(details != null && details.mechanism.isNotEmpty)
//                 Builder(
//                   builder: (context){
//
//                     List<Widget> widgets = [];
//                     for(int i=0; i<details.mechanism.length; i++){
//                       widgets.add(Text(details.mechanism[i].displayName, style: TextStyle(font: fontBold)));
//                       if(i<details.mechanism.length -1)
//                         widgets.add(SizedBox(width: elementSmallSeparator));
//                     }
//
//                     return Padding(
//                       padding: EdgeInsets.only(top: elementSmallSeparator/2),
//                       child: Row(children: widgets)
//                     );
//                   }
//                 )
//
//             ]
//         )
//     )
//   )
// );
