import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:html_pdf_widgets/html_pdf_widgets.dart';

import 'common.dart';

class _PrintAttachmentRef {
  final String title;
  final String url;
  const _PrintAttachmentRef(this.title, this.url);
}

/// Priority order for picking a URL when an attachment exposes the same
/// resource in several URL-typed formats (e.g. `urlPdf` + `urlDocx`). Plain
/// `url` first (most generic), then document formats, then images. Anything
/// not listed here is fallback-iterated last.
const List<FileFormat> _printUrlPreference = [
  FileFormat.url,
  FileFormat.urlPdf,
  FileFormat.urlDocx,
  FileFormat.urlPng,
  FileFormat.urlWebp,
  FileFormat.urlSvg,
];

/// Looks up the attachment referenced by [material.attachmentName] in
/// [konspekt.attachments] and — if it carries a URL viewable in print —
/// returns its title and URL. Returns null for materials without a referenced
/// attachment, or for attachments that have only local-asset formats (those
/// can't be followed from paper anyway).
_PrintAttachmentRef? _resolvePrintAttachment(Konspekt konspekt, KonspektMaterial material){
  final name = material.attachmentName;
  if(name == null) return null;
  final attachments = konspekt.attachments;
  if(attachments == null) return null;
  for(final att in attachments){
    if(att.name != name) continue;
    if(att is KonspektInternalLinkAttachment)
      return _PrintAttachmentRef(att.title, att.url);
    if(att is KonspektAttachment){
      for(final format in _printUrlPreference){
        final value = att.assets[format];
        if(value != null) return _PrintAttachmentRef(att.title, value);
      }
    }
    return null;
  }
  return null;
}

Widget MaterialTile(
    Konspekt konspekt,
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
    }) {
  final attachmentRef = _resolvePrintAttachment(konspekt, material);
  return ClipRRect(
      horizontalRadius: defRadius,
      verticalRadius: defRadius,
      child: Container(
          color: backgroundColor??cardColor,
          child: Padding(
              padding: EdgeInsets.all(6.0),
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
                      ),

                    if(attachmentRef != null)
                      SizedBox(height: elementSmallSeparator),

                    if(attachmentRef != null)
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
                                          'Załącznik online:',
                                          style: TextStyle(font: fontBold, fontSize: defTextSize),
                                        ),

                                        SizedBox(height: elementSmallSeparator),

                                        Text(
                                            attachmentRef.title,
                                            style: TextStyle(font: fontHalfBold, fontSize: defTextSize),
                                        ),

                                        SizedBox(height: 2.0),

                                        UrlLink(
                                            destination: attachmentRef.url,
                                            child: Text(
                                                attachmentRef.url,
                                                style: TextStyle(
                                                  font: font,
                                                  fontSize: defTextSize,
                                                  color: PdfColors.blue,
                                                  decoration: TextDecoration.underline,
                                                ),
                                            )
                                        ),
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
