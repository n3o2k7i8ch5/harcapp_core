import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/save_pdf_dialog.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_category_selector.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_loader.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_pdf_builder.dart';
import 'package:harcapp_core/values/dimen.dart';

/// PDF download dialog content for a single [apel] — used by per-apel "Pobierz
/// PDF" buttons. Variant picker is shown only when the apel has more than one
/// variant; otherwise the picker is hidden and the apel's sole variant is used.
/// Optional [onPdfGenerated] fires after the PDF bytes are built (for
/// analytics), without blocking the save flow.
class ApelEwanSingleSavePdfContent extends StatefulWidget {

  final ApelEwan apel;
  final String? initialVariantId;
  final String? note;
  final Widget? extraTopWidget;
  final void Function(ApelEwan apel, String variantId)? onPdfGenerated;

  const ApelEwanSingleSavePdfContent({
    super.key,
    required this.apel,
    this.initialVariantId,
    this.note,
    this.extraTopWidget,
    this.onPdfGenerated,
  });

  @override
  State<ApelEwanSingleSavePdfContent> createState() =>
      _ApelEwanSingleSavePdfContentState();
}

class _ApelEwanSingleSavePdfContentState
    extends State<ApelEwanSingleSavePdfContent> {

  late List<String> _availableVariantIds;
  late String _selectedVariantId;

  ApelEwan get apel => widget.apel;

  @override
  void initState() {
    super.initState();
    _availableVariantIds = apel.variants.keys.toList();
    final initial = widget.initialVariantId;
    _selectedVariantId = initial != null && apel.variants.containsKey(initial)
        ? initial
        : _availableVariantIds.first;
  }

  Future<({Uint8List bytes, String filename})> _generate() async {
    final bytes = await buildSingleApelEwanPdf(
      apel: apel,
      variantId: _selectedVariantId,
      note: widget.note,
    );
    widget.onPdfGenerated?.call(apel, _selectedVariantId);
    return (
      bytes: bytes,
      filename: pdfFileNameForApel(apel, variantId: _selectedVariantId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SavePdfDialogContent(
      generatePdf: _generate,
      isStillMounted: () => mounted,
      topWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.extraTopWidget != null) ...[
            widget.extraTopWidget!,
            const SizedBox(height: Dimen.sideMarg),
          ],
          if (_buildVariantCard(context) case final card?) card,
        ],
      ),
    );
  }

  Widget? _buildVariantCard(BuildContext context) {
    final hasPicker = _availableVariantIds.length > 1;
    final variantName = apelEwansVariantNameMap[_selectedVariantId];
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
}
