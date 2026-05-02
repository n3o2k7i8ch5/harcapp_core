import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
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
      mainAxisSize: MainAxisSize.min,
      children: [

        _SwitchCard(
          title: 'Zdjęcie okładki',
          value: withCover,
          onChanged: (value) => setState(() => withCover = value),
        ),
        SizedBox(height: Dimen.sideMarg),

        _SwitchCard(
          title: 'Metodyki, autor, czas, skrót',
          value: withMetadata,
          onChanged: (value) => setState(() => withMetadata = value),
        ),
        SizedBox(height: Dimen.sideMarg),

        _SwitchCard(
          title: 'Cele',
          value: withAims,
          onChanged: (value) => setState(() => withAims = value),
        ),
        SizedBox(height: Dimen.sideMarg),

        _SwitchCard(
          title: 'Lista materiałów',
          value: withMaterials,
          onChanged: (value) => setState(() => withMaterials = value),
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

      ],
    ),
  );

}

class _SwitchCard extends StatelessWidget {

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchCard({required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppCard.defRadius),
      color: cardEnab_(context),
    ),
    child: SwitchListTile(
      title: Text(title, style: AppTextStyle(color: iconEnab_(context))),
      value: value,
      onChanged: onChanged,
      activeThumbColor: accent_(context),
    ),
  );

}
