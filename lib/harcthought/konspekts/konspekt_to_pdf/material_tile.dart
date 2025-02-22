import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

Widget MaterialTile(
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
    }) => ClipRRect(
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
