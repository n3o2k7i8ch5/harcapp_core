import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/save_pdf_dialog.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt_to_pdf/konspekt_to_pdf.dart';
import 'package:harcapp_core/harcthought/konspekts/widgets/base_konspekt_widget.dart';
import 'package:harcapp_core/values/dimen.dart';

Future<void> showKonspektSavePdfDialog(
    BuildContext context,
    Konspekt konspekt, {
    TimeOfDay? startTime,
    List<TimeOfDay>? stepsTimeTable,
}) => showSavePdfDialog(
    context: context,
    child: KonspektSavePdfContent(konspekt, startTime: startTime, stepsTimeTable: stepsTimeTable),
);

class KonspektSavePdfContent extends StatefulWidget{

  final Konspekt konspekt;
  final TimeOfDay? startTime;
  final List<TimeOfDay>? stepsTimeTable;

  const KonspektSavePdfContent(this.konspekt, {this.startTime, this.stepsTimeTable, super.key});

  @override
  State<StatefulWidget> createState() => KonspektSavePdfContentState();

}

class KonspektSavePdfContentState extends State<KonspektSavePdfContent>{

  late bool withCover;
  late bool withMetadata;
  late bool withAims;
  late bool withMaterials;
  TimeOfDay? startTime;
  List<TimeOfDay>? stepsTimeTable;

  @override
  void initState() {
    withCover = true;
    withMetadata = true;
    withAims = true;
    withMaterials = true;
    startTime = widget.startTime;
    stepsTimeTable = widget.stepsTimeTable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SavePdfDialogContent(
    isStillMounted: () => mounted,
    generatePdf: () async {
      Uint8List bytes = await konspektToPdf(
        widget.konspekt,
        withCover: withCover,
        withMetadata: withMetadata,
        withAims: withAims,
        withMaterials: withMaterials,
        stepsTimeTable: stepsTimeTable,
      );
      return (bytes: bytes, filename: 'Konspekt - ${widget.konspekt.title}.pdf');
    },
    topWidget: Column(
      children: [

        SwitchListTile(
          title: Text('Zdjęcie okładki', style: settingsTextStyle(context)),
          value: withCover,
          onChanged: (value) => setState(() => withCover = value),
          activeThumbColor: accent_(context),
        ),

        SwitchListTile(
          title: Text('Metodyki, autor, czas, skrót', style: settingsTextStyle(context)),
          value: withMetadata,
          onChanged: (value) => setState(() => withMetadata = value),
          activeThumbColor: accent_(context),
        ),

        SwitchListTile(
          title: Text('Cele', style: settingsTextStyle(context)),
          value: withAims,
          onChanged: (value) => setState(() => withAims = value),
          activeThumbColor: accent_(context),
        ),

        SwitchListTile(
          title: Text('Lista materiałów', style: settingsTextStyle(context)),
          value: withMaterials,
          onChanged: (value) => setState(() => withMaterials = value),
          activeThumbColor: accent_(context),
        ),

        if(widget.konspekt.anySteps)
          SizedBox(height: Dimen.sideMarg),

        if(widget.konspekt.anySteps)
          StartTimeButton(
              widget.konspekt,
              startTime: startTime,
              expandStepGroups: true,
              onStartTimeChanged: (startTime, stepsTimeTable) =>
                  setState(() {
                    this.startTime = startTime;
                    this.stepsTimeTable = stepsTimeTable;
                  })
          ),

        SizedBox(height: Dimen.sideMarg),

      ],
    ),
  );

}
