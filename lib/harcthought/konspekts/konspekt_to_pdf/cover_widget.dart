import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';
import 'package:printing/printing.dart';

import 'common.dart';

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
                                    "Źródło: ${konspekt.coverAuthor}",
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