import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';
import 'material_tile.dart';

List<Widget> MaterialTiles(
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
        MaterialTile(
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