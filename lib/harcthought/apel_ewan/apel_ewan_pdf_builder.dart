import 'dart:typed_data';

import 'package:harcapp_core/comm_classes/pw_rich_text.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_folder.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_persistent_folder.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

typedef ApelEwanVariantIdResolver = String Function(ApelEwan apel);
typedef ApelEwanNoteResolver = String? Function(ApelEwan apel);

String defaultApelEwanVariantId(ApelEwanFolder folder, ApelEwan apel){
  if(folder is ApelEwanPersistentFolder && apel.variants.containsKey(folder.variantId))
    return folder.variantId;
  return apel.variants.keys.first;
}

String pdfFileNameForFolder(ApelEwanFolder folder) =>
    'Zbiór apeli ewangelicznych - ${folder.name}.pdf';

Future<Uint8List> buildApelEwanPdf({
  required ApelEwanFolder folder,
  required Set<String> selectedSiglums,
  ApelEwanVariantIdResolver? variantIdFor,
  ApelEwanNoteResolver? noteFor,
}) async {

  final pdf = pw.Document(pageMode: PdfPageMode.outlines);

  final font = pw.Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Lato/Lato-Regular.ttf'))!);
  final fontItalic = pw.Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Lato/Lato-Italic.ttf'))!);
  final fontBold = pw.Font.ttf((await readByteDataFromAssets('packages/harcapp_core/fonts/Lato/Lato-Bold.ttf'))!);

  final List<ApelEwan> selected = folder.apelEwans
      .where((a) => selectedSiglums.contains(a.siglum))
      .toList();

  if(selected.isEmpty){
    pdf.addPage(pw.Page(build: (context) => pw.Center(
        child: pw.Text('Koleżko, przecież tu niczego nie ma!', style: pw.TextStyle(font: font))
    )));
    return pdf.save();
  }

  for(ApelEwan apelEwan in selected){

    final String variantId = variantIdFor?.call(apelEwan)
        ?? defaultApelEwanVariantId(folder, apelEwan);

    ApelEwanVariant variant = apelEwan.variants[variantId]!;
    String title = variant.title;

    List<pw.Widget> questionLineWidgets = [];
    List<String> questionList = variant.questions;
    for(int i=0; i<questionList.length; i++)
      questionLineWidgets.add(pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 3),
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.SizedBox(
                    width: 36,
                    child: pw.Text(
                        '${i + 1}.',
                        style: pw.TextStyle(font: font)
                    )
                ),

                pw.Expanded(
                  child: getPwRichText(questionList[i], font, fontItalic, fontBold),
                )
              ]
          )
      ));

    pw.Widget questionsWidget = pw.Column(
        children: questionLineWidgets
    );

    List<String> textParagraphs = apelEwan.text.replaceAll('  ', ' ').split('\n');
    List<pw.Widget> textParagraphWidgets = [];
    for(int i=0; i<textParagraphs.length; i++)
      textParagraphWidgets.add(pw.Padding(
        padding: const pw.EdgeInsets.only(top: 4),
        child: getPwRichText(textParagraphs[i], font, fontItalic, fontBold, textAlign: pw.TextAlign.justify, height: 1.2),
      ));

    String? comment = variant.comment;

    List<pw.Widget> commentParagraphWidgets = [];
    if(comment != null) {
      List<String> commentParagraphs = comment.replaceAll('  ', ' ').split('\n');
      for (int i = 0; i < commentParagraphs.length; i++)
        commentParagraphWidgets.add(pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
          child: getPwRichText(
              commentParagraphs[i], font, fontItalic, fontBold,
              textAlign: pw.TextAlign.justify, height: 1.2),
        ));
    }

    final String? note = noteFor?.call(apelEwan);
    final bool showNote = note != null && note.isNotEmpty;

    pw.MultiPage page = pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (pw.Context pwContext) => [

          pw.Text(title, style: pw.TextStyle(font: font, fontSize: 22.0)),

          pw.SizedBox(height: 6),

          pw.Container(
              width: double.infinity,
              height: 1,
              color: const PdfColor(0, 0, 0, .3)
          ),

          pw.Text(
            apelEwan.siglum,
            style: pw.TextStyle(font: font, fontSize: 14.0),
          ),

          pw.SizedBox(height: 24.0),

          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: textParagraphWidgets
          ),

          pw.SizedBox(height: 12.0),

          pw.Text(
            'Oto słowo boże.',
            style: pw.TextStyle(font: font, fontSize: 14.0),
          ),

          if(showNote)
            pw.SizedBox(height: 24.0),

          if(showNote)
            pw.Text('Notatka', style: pw.TextStyle(font: font, fontSize: 18.0)),

          if(showNote)
            pw.SizedBox(height: 12.0),

          if(showNote)
            pw.Text(
              note,
              style: pw.TextStyle(
                  fontItalic: fontItalic,
                  fontSize: 14.0,
                  color: const PdfColor(0, 0, 0, .3),
                  fontStyle: pw.FontStyle.italic
              ),
            ),

          pw.SizedBox(height: 24.0),

          pw.Text('Pytania', style: pw.TextStyle(font: font, fontSize: 18.0)),

          pw.SizedBox(height: 12.0),

          questionsWidget,

          pw.SizedBox(height: 24.0),

          if(comment != null)
            pw.Text('Komentarze', style: pw.TextStyle(font: font, fontSize: 18.0)),

          if(comment != null)
            pw.SizedBox(height: 12.0),

          if(comment != null)
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: commentParagraphWidgets
            )

        ]

    );

    pdf.addPage(page);

  }

  return pdf.save();
}
