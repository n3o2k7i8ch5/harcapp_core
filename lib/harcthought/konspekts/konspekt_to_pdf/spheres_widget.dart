import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/sphere_widget.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

List<Widget> SphereListWidget(Konspekt konspekt, Font font, Font fontBold){

  if(konspekt.spheresEmpty)
    return [Container()];

  List<Widget> widgets = [];

  for(int i=0; i<konspekt.spheres.length; i++) {
    KonspektSphere sphere = konspekt.spheres.keys.toList()[i];
    KonspektSphereDetails? details = konspekt.spheres[sphere];
    if(details == null || details.isEmpty) continue;
    widgets.add(SphereWidget(sphere, details, font, fontBold));
  }

  return [

    SizedBox(height: elementBigSeparator),

    HeaderWidget('Sfery rozwoju', fontBold),

    SizedBox(height: elementSmallSeparator),

    ...spaceWidgets(
        children: widgets,
        spacing: elementSmallSeparator
    )

  ];

}
