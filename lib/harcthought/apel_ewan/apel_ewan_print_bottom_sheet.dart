import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/comm_widgets/bottom_sheet.dart';
import 'package:harcapp_core/comm_widgets/gradient_icon.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_folder.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_pdf_builder.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:printing/printing.dart';

class ApelEwanPrintBottomSheet extends StatefulWidget {

  final ApelEwanFolder folder;
  final ApelEwanVariantIdResolver? variantIdFor;
  final ApelEwanNoteResolver? noteFor;
  final Widget? extraTopWidget;
  final Color? textColor;
  final Color? iconColor;
  final Color? iconEndColor;

  const ApelEwanPrintBottomSheet({
    super.key,
    required this.folder,
    this.variantIdFor,
    this.noteFor,
    this.extraTopWidget,
    this.textColor,
    this.iconColor,
    this.iconEndColor,
  });

  @override
  State<ApelEwanPrintBottomSheet> createState() => _ApelEwanPrintBottomSheetState();
}

class _ApelEwanPrintBottomSheetState extends State<ApelEwanPrintBottomSheet> {

  late Set<String> _selectedSiglums;
  bool _generating = false;

  ApelEwanFolder get folder => widget.folder;

  @override
  void initState() {
    super.initState();
    _selectedSiglums = folder.apelEwans.map((a) => a.siglum).toSet();
  }

  String _resolveVariantId(ApelEwan apel) =>
      widget.variantIdFor?.call(apel) ?? defaultApelEwanVariantId(folder, apel);

  String _titleFor(ApelEwan apel){
    final String variantId = _resolveVariantId(apel);
    final variant = apel.variants[variantId] ?? apel.variants.values.first;
    return variant.shortTitle ?? variant.title;
  }

  void _toggle(String siglum, bool? value){
    setState((){
      if(value == true) _selectedSiglums.add(siglum);
      else _selectedSiglums.remove(siglum);
    });
  }

  void _selectAll(){
    setState(() => _selectedSiglums =
        folder.apelEwans.map((a) => a.siglum).toSet());
  }

  void _deselectAll(){
    setState(() => _selectedSiglums = <String>{});
  }

  Future<void> _generateAndShare() async {
    if(_selectedSiglums.isEmpty){
      showAppToast(context, text: 'Wybierz co najmniej jeden apel');
      return;
    }

    setState(() => _generating = true);
    showAppToast(context, text: 'Generowanie pliku...');

    Uint8List bytes;
    try {
      bytes = await buildApelEwanPdf(
        folder: folder,
        selectedSiglums: _selectedSiglums,
        variantIdFor: widget.variantIdFor,
        noteFor: widget.noteFor,
      );
    } catch (_) {
      if(!mounted) return;
      setState(() => _generating = false);
      showAppToast(context, text: 'Wystąpił błąd');
      await popPage(context);
      return;
    }

    if(!mounted) return;

    try {
      await Printing.sharePdf(
        bytes: bytes,
        filename: pdfFileNameForFolder(folder),
      );
    } catch (_) {
      if(!mounted) return;
      showAppToast(context, text: 'Nie udało się udostępnić pliku');
    }

    if(!mounted) return;
    await popPage(context);
  }

  @override
  Widget build(BuildContext context) {

    final apels = folder.apelEwans;
    final allSelected = _selectedSiglums.length == apels.length && apels.isNotEmpty;
    final noneSelected = _selectedSiglums.isEmpty;

    return BottomSheetDef(
      title: 'Stwórz plik PDF',
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          if(widget.extraTopWidget != null)
            widget.extraTopWidget!,

          if(apels.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.sideMarg),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Uwzględnione apele (${_selectedSiglums.length}/${apels.length})',
                      style: AppTextStyle(
                        fontWeight: weightHalfBold,
                        color: hintEnab_(context),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: allSelected ? null : _selectAll,
                    child: const Text('Zaznacz wszystkie', style: AppTextStyle()),
                  ),
                  TextButton(
                    onPressed: noneSelected ? null : _deselectAll,
                    child: const Text('Odznacz wszystkie', style: AppTextStyle()),
                  ),
                ],
              ),
            ),

          if(apels.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 320),
              child: Scrollbar(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: apels.length,
                  itemBuilder: (context, index){
                    final apel = apels[index];
                    final selected = _selectedSiglums.contains(apel.siglum);
                    return CheckboxListTile(
                      value: selected,
                      onChanged: (v) => _toggle(apel.siglum, v),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: accent_(context),
                      dense: true,
                      title: Text(
                        _titleFor(apel),
                        style: const AppTextStyle(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        apel.siglum,
                        style: AppTextStyle(
                          color: hintEnab_(context),
                          fontSize: Dimen.textSizeSmall,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: Dimen.sideMarg),

          SimpleButton(
            onTap: (_generating || _selectedSiglums.isEmpty) ? null : _generateAndShare,
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
                          color: _selectedSiglums.isEmpty
                              ? hintEnab_(context)
                              : widget.textColor,
                          fontWeight: weightBold
                      ),
                      maxLines: 1,
                    ),
                  ),

                  const SizedBox(width: Dimen.sideMarg),

                  GradientIcon(
                    MdiIcons.printer,
                    colorStart: _selectedSiglums.isEmpty
                        ? hintEnab_(context)
                        : (widget.iconColor ?? widget.textColor ?? iconEnab_(context)),
                    colorEnd: _selectedSiglums.isEmpty
                        ? hintEnab_(context)
                        : (widget.iconEndColor ?? widget.textColor ?? iconEnab_(context)),
                    size: 80,
                  ),

                  const SizedBox(width: Dimen.sideMarg),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
