import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/comm_widgets/gradient_icon.dart';
import 'package:harcapp_core/comm_widgets/save_pdf.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef SavePdfDataBuilder = Future<({Uint8List bytes, String filename})> Function();

class SavePdfDialogContent extends StatefulWidget {

  final SavePdfDataBuilder generatePdf;
  final bool Function()? isStillMounted;
  final Widget? topWidget;
  final bool buttonEnabled;
  final Color? textColor;
  final Color? iconColor;
  final Color? iconEndColor;

  const SavePdfDialogContent({
    super.key,
    required this.generatePdf,
    this.isStillMounted,
    this.topWidget,
    this.buttonEnabled = true,
    this.textColor,
    this.iconColor,
    this.iconEndColor,
  });

  @override
  State<SavePdfDialogContent> createState() => _SavePdfDialogContentState();
}

class _SavePdfDialogContentState extends State<SavePdfDialogContent> {

  bool _busy = false;

  bool get _stillMounted => widget.isStillMounted?.call() ?? mounted;

  Future<void> _onTap() async {
    setState(() => _busy = true);
    showAppToast(context, text: 'Generowanie pliku...');

    ({Uint8List bytes, String filename}) data;
    try {
      data = await widget.generatePdf();
    } catch (_) {
      if(!_stillMounted) return;
      showAppToast(context, text: 'Wystąpił błąd');
      await popPage(context);
      return;
    }

    if(!_stillMounted) return;

    bool ok;
    try {
      ok = await savePdf(bytes: data.bytes, filename: data.filename);
    } catch (_) {
      ok = false;
    }

    if(!_stillMounted) return;
    if(!ok)
      showAppToast(context, text: 'Nie udało się zapisać pliku');
    await popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.buttonEnabled && !_busy;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        if(widget.topWidget != null)
          widget.topWidget!,

        SimpleButton(
          onTap: enabled ? _onTap : null,
          radius: AppCard.bigRadius,
          color: cardEnab_(context),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [

                const SizedBox(width: 2*Dimen.sideMarg),

                Expanded(
                  child: AutoSizeText(
                    'Stwórz PDF',
                    style: AppTextStyle(
                        fontSize: 24.0,
                        color: enabled ? widget.textColor : hintEnab_(context),
                        fontWeight: weightBold,
                    ),
                    maxLines: 1,
                  ),
                ),

                const SizedBox(width: Dimen.sideMarg),

                GradientIcon(
                  MdiIcons.printer,
                  colorStart: enabled
                      ? (widget.iconColor ?? widget.textColor ?? iconEnab_(context))
                      : hintEnab_(context),
                  colorEnd: enabled
                      ? (widget.iconEndColor ?? widget.textColor ?? iconEnab_(context))
                      : hintEnab_(context),
                  size: 80,
                ),

                const SizedBox(width: Dimen.sideMarg),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> showSavePdfDialog({
  required BuildContext context,
  String title = 'Stwórz plik PDF',
  required Widget child,
}) => openAppDialog(
    context: context,
    title: title,
    scrollable: true,
    child: child,
);
