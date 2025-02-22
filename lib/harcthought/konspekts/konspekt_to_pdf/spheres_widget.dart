import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/sphere_widget.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

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
