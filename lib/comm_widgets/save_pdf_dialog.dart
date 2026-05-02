import 'dart:typed_data';

import 'package:flutter/material.dart' hide DialogRoute;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/dialog/base.dart';
import 'package:harcapp_core/comm_widgets/save_pdf.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef SavePdfDataBuilder = Future<({Uint8List bytes, String filename})> Function();

class SavePdfDialogContent extends StatefulWidget {

  final SavePdfDataBuilder generatePdf;
  final Widget? topWidget;
  final bool buttonEnabled;
  final bool Function()? isStillMounted;

  const SavePdfDialogContent({
    super.key,
    required this.generatePdf,
    this.topWidget,
    this.buttonEnabled = true,
    this.isStillMounted,
  });

  @override
  State<SavePdfDialogContent> createState() => _SavePdfDialogContentState();
}

class _SavePdfDialogContentState extends State<SavePdfDialogContent> {

  bool _busy = false;

  bool get _stillMounted => widget.isStillMounted?.call() ?? mounted;

  Future<void> _onTap() async {
    setState(() => _busy = true);

    ({Uint8List bytes, String filename}) data;
    try {
      data = await widget.generatePdf();
    } catch (_) {
      if(!_stillMounted) return;
      setState(() => _busy = false);
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
          Flexible(child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimen.sideMarg),
            child: widget.topWidget!,
          )),

        SimpleButton.from(
          context: context,
          iconWidget: _busy
              ? SpinKitChasingDots(color: textDisab_(context), size: Dimen.iconSize)
              : null,
          icon: _busy ? null : MdiIcons.printer,
          text: _busy ? 'Przygotowywanie pliku PDF...' : 'Pobierz PDF',
          color: cardEnab_(context),
          textColor: enabled ? iconEnab_(context) : iconDisab_(context),
          margin: EdgeInsets.zero,
          radius: 0,
          onTap: enabled ? _onTap : null,
        ),
      ],
    );
  }
}

Future<void> showSavePdfDialog({
  required BuildContext context,
  String title = 'Właściwości pliku PDF',
  required Widget child,
  double maxWidth = 500,
}) => openBaseDialog(
    context: context,
    maxWidth: maxWidth,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBarX(title: title),
        Flexible(child: child),
      ],
    ),
);
