import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/app_mdi_icons.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/save_pdf_dialog.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_category_selector.dart';
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
  final void Function(ApelEwanFolder folder, int selectedCount)? onPdfGenerated;

  const ApelEwanSavePdfContent({
    super.key,
    required this.folder,
    this.variantIdFor,
    this.noteFor,
    this.extraTopWidget,
    this.onPdfGenerated,
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
      // Only the variants the folder itself advertises — pdfVariantIds when
      // set, otherwise the folder's default variantId. Apels missing the
      // chosen variant fall back to their first variant in the generated PDF.
      _availableVariantIds = f.pdfVariantIds.isNotEmpty
          ? f.pdfVariantIds
          : [f.variantId];
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

  String? _displayedVariantName() => apelEwansVariantNameMap[_selectedVariantId];

  String _titleFor(ApelEwan apel) =>
      apel.variantOrFirst(_resolveVariantId(apel)).oneLineLabel;

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
    widget.onPdfGenerated?.call(folder, _selectedSiglums.length);
    return (bytes: bytes, filename: pdfFileNameForFolder(folder));
  }

  @override
  Widget build(BuildContext context) {
    final apels = folder.apelEwans;

    return SavePdfDialogContent(
      generatePdf: _generate,
      isStillMounted: () => mounted,
      buttonEnabled: _selectedSiglums.isNotEmpty,
      topWidgetExpands: true,
      icon: AppMdiIcons.filePdfBoxMultiple,
      topWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.extraTopWidget != null) ...[
            widget.extraTopWidget!,
            const SizedBox(height: Dimen.sideMarg),
          ],
          if (_buildVariantCard(context) case final card?) ...[
            card,
            const SizedBox(height: Dimen.sideMarg),
          ],
          if (apels.isNotEmpty) Flexible(child: _buildApelList(context, apels)),
        ],
      ),
    );
  }

  Widget? _buildVariantCard(BuildContext context) {
    if (_availableVariantIds.isEmpty) return null;
    final variantName = _displayedVariantName();
    final hasPicker = _availableVariantIds.length > 1;
    if (variantName == null && !hasPicker) return null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        color: cardEnab_(context),
      ),
      padding: const EdgeInsets.only(
        top: ApelEwanCategorySelector.internalTextPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: ApelEwanCategorySelector.internalTextPadding,
            ),
            child: Text(
              'Wariant pytań:',
              style: AppTextStyle(
                fontSize: Dimen.textSizeBig,
                color: hintEnab_(context),
              ),
            ),
          ),
          if (hasPicker)
            ApelEwanCategorySelector(
              allVariantIds: _availableVariantIds,
              selVariantIds: _selectedVariantId,
              onChanged: (v) {
                if (v == null || v == _selectedVariantId) return;
                setState(() => _selectedVariantId = v);
              },
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimen.sideMarg,
                Dimen.defMarg,
                Dimen.sideMarg,
                ApelEwanCategorySelector.internalTextPadding,
              ),
              child: Text(
                variantName ?? '',
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
      ),
    );
  }

  Widget _buildApelList(BuildContext context, List<ApelEwan> apels) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        color: cardEnab_(context),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSelectAllTile(context, apels),
          Flexible(
            child: Scrollbar(
              controller: _listScrollController,
              child: ListView.builder(
                controller: _listScrollController,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: apels.length,
                itemBuilder: (context, index) =>
                    _buildApelTile(context, apels[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // First text line is `fontSize * height` tall (AppTextStyle defaults to
  // height ≈ 1.4). The checkbox is wrapped in a SizedBox of this height so its
  // center aligns with the title's center — siglum naturally lands below.
  static const double _titleLineHeight = Dimen.textSizeBig * 1.4;

  Widget _checkbox({
    required bool? value,
    required ValueChanged<bool?> onChanged,
    bool tristate = false,
  }) =>
      SizedBox(
        height: _titleLineHeight,
        width: 24,
        child: Align(
          alignment: Alignment.center,
          child: Checkbox(
            tristate: tristate,
            value: value,
            onChanged: onChanged,
            activeColor: accent_(context),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
      );

  Widget _buildSelectAllTile(BuildContext context, List<ApelEwan> apels) {
    final allSelected = _selectedSiglums.length == apels.length && apels.isNotEmpty;
    final noneSelected = _selectedSiglums.isEmpty;
    return InkWell(
      onTap: () => allSelected ? _deselectAll() : _selectAll(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimen.sideMarg,
          vertical: Dimen.iconMarg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _checkbox(
              tristate: true,
              value: allSelected ? true : (noneSelected ? false : null),
              onChanged: (_) => allSelected ? _deselectAll() : _selectAll(),
            ),
            const SizedBox(width: Dimen.sideMarg),
            Expanded(
              child: Text(
                '${_selectedSiglums.length}/${apels.length}',
                style: AppTextStyle(
                  fontWeight: weightBold,
                  fontSize: Dimen.textSizeBig,
                  color: iconEnab_(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApelTile(BuildContext context, ApelEwan apel) {
    final selected = _selectedSiglums.contains(apel.siglum);
    return InkWell(
      onTap: () => _toggle(apel.siglum, !selected),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimen.sideMarg,
          vertical: Dimen.iconMarg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _checkbox(
              value: selected,
              onChanged: (v) => _toggle(apel.siglum, v),
            ),
            const SizedBox(width: Dimen.sideMarg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _titleFor(apel),
                    style: const AppTextStyle(fontSize: Dimen.textSizeBig),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    apel.siglum,
                    style: AppTextStyle(
                      color: hintEnab_(context),
                      fontSize: Dimen.textSizeSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
