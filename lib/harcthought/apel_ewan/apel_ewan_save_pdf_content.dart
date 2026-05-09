import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/save_pdf_dialog.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_folder.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_loader.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_pdf_builder.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_persistent_folder.dart';
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
  late List<String> _availableVariantIds;
  late String _selectedVariantId;
  final ScrollController _listScrollController = ScrollController();

  ApelEwanFolder get folder => widget.folder;

  @override
  void initState() {
    super.initState();
    _selectedSiglums = folder.apelEwans.map((a) => a.siglum).toSet();

    final f = folder;
    if (f is ApelEwanPersistentFolder) {
      _availableVariantIds = f.pdfVariantIds.isEmpty
          ? const [ogolneApelEwansVariantId]
          : f.pdfVariantIds;
      _selectedVariantId = _availableVariantIds.first;
    } else {
      _availableVariantIds = const [];
      _selectedVariantId = '';
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    super.dispose();
  }

  String _resolveVariantId(ApelEwan apel) {
    if (_availableVariantIds.isNotEmpty) {
      return apel.variants.containsKey(_selectedVariantId)
          ? _selectedVariantId
          : apel.variants.keys.first;
    }
    return widget.variantIdFor?.call(apel) ?? defaultApelEwanVariantId(folder, apel);
  }

  String? _displayedVariantName() {
    if (_availableVariantIds.isNotEmpty)
      return apelEwansVariantNameMap[_selectedVariantId];
    if (folder.apelEwans.isEmpty) return null;
    final id = _resolveVariantId(folder.apelEwans.first);
    return apelEwansVariantNameMap[id];
  }

  String _titleFor(ApelEwan apel){
    final String variantId = _resolveVariantId(apel);
    final variant = apel.variants[variantId] ?? apel.variants.values.first;
    return (variant.shortTitle ?? variant.title).replaceAll('\n', ' ');
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
      variantIdFor: _resolveVariantId,
      noteFor: widget.noteFor,
    );
    return (bytes: bytes, filename: pdfFileNameForFolder(folder));
  }

  @override
  Widget build(BuildContext context) {

    final apels = folder.apelEwans;
    final allSelected = _selectedSiglums.length == apels.length && apels.isNotEmpty;
    final noneSelected = _selectedSiglums.isEmpty;
    final variantName = _displayedVariantName();

    return SavePdfDialogContent(
      generatePdf: _generate,
      isStillMounted: () => mounted,
      buttonEnabled: _selectedSiglums.isNotEmpty,
      topWidgetExpands: true,
      topWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          if(widget.extraTopWidget != null) ...[
            widget.extraTopWidget!,
            const SizedBox(height: Dimen.sideMarg),
          ],

          if(variantName != null || _availableVariantIds.length > 1) ...[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppCard.defRadius),
                color: cardEnab_(context),
              ),
              padding: const EdgeInsets.all(Dimen.sideMarg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Wariant pytań:',
                    style: AppTextStyle(color: hintEnab_(context)),
                  ),
                  const SizedBox(height: Dimen.defMarg),
                  if(_availableVariantIds.length > 1)
                    DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedVariantId,
                      underline: const SizedBox.shrink(),
                      items: [
                        for(final id in _availableVariantIds)
                          DropdownMenuItem<String>(
                            value: id,
                            child: Text(
                              apelEwansVariantNameMap[id] ?? id,
                              style: AppTextStyle(
                                fontSize: Dimen.textSizeBig,
                                fontWeight: weightHalfBold,
                                color: iconEnab_(context),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (v){
                        if(v == null) return;
                        setState(() => _selectedVariantId = v);
                      },
                    )
                  else
                    Text(
                      variantName ?? '',
                      style: AppTextStyle(
                        fontSize: Dimen.textSizeBig,
                        fontWeight: weightHalfBold,
                        color: iconEnab_(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(height: Dimen.sideMarg),
          ],

          if(apels.isNotEmpty)
            Flexible(
              child: Container(
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
                        '${_selectedSiglums.length}/${apels.length}',
                        style: AppTextStyle(
                          fontWeight: weightBold,
                          fontSize: Dimen.textSizeBig,
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

                    Flexible(
                      child: Scrollbar(
                        controller: _listScrollController,
                        child: ListView.builder(
                          controller: _listScrollController,
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
                                maxLines: 1,
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
            ),

        ],
      ),
    );
  }
}
