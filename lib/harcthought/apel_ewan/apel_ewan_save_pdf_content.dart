import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/save_pdf_dialog.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_folder.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_pdf_builder.dart';
import 'package:harcapp_core/values/dimen.dart';

class ApelEwanSavePdfContent extends StatefulWidget {

  final ApelEwanFolder folder;
  final ApelEwanVariantIdResolver? variantIdFor;
  final ApelEwanNoteResolver? noteFor;
  final Widget? extraTopWidget;

  const ApelEwanSavePdfContent({
    super.key,
    required this.folder,
    this.variantIdFor,
    this.noteFor,
    this.extraTopWidget,
  });

  @override
  State<ApelEwanSavePdfContent> createState() => _ApelEwanSavePdfContentState();
}

class _ApelEwanSavePdfContentState extends State<ApelEwanSavePdfContent> {

  late Set<String> _selectedSiglums;

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

  Future<({Uint8List bytes, String filename})> _generate() async {
    final bytes = await buildApelEwanPdf(
      folder: folder,
      selectedSiglums: _selectedSiglums,
      variantIdFor: widget.variantIdFor,
      noteFor: widget.noteFor,
    );
    return (bytes: bytes, filename: pdfFileNameForFolder(folder));
  }

  @override
  Widget build(BuildContext context) {

    final apels = folder.apelEwans;
    final allSelected = _selectedSiglums.length == apels.length && apels.isNotEmpty;
    final noneSelected = _selectedSiglums.isEmpty;

    return SavePdfDialogContent(
      generatePdf: _generate,
      isStillMounted: () => mounted,
      buttonEnabled: _selectedSiglums.isNotEmpty,
      topWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          if(widget.extraTopWidget != null) ...[
            widget.extraTopWidget!,
            const SizedBox(height: Dimen.sideMarg),
          ],

          if(apels.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCard.defRadius),
                color: cardEnab_(context),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    tristate: true,
                    value: allSelected ? true : (noneSelected ? false : null),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: accent_(context),
                    title: Text(
                      'Uwzględnione apele (${_selectedSiglums.length}/${apels.length})',
                      style: AppTextStyle(
                        fontSize: Dimen.textSizeAppBar,
                        fontWeight: weightBold,
                        color: iconEnab_(context),
                      ),
                    ),
                    onChanged: (_) {
                      if (allSelected) {
                        _deselectAll();
                      } else {
                        _selectAll();
                      }
                    },
                  ),

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
                ],
              ),
            ),

        ],
      ),
    );
  }
}
