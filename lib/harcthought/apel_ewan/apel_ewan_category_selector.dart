import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

import 'apel_ewan_loader.dart';

class ApelEwanCategorySelector extends StatelessWidget{

  static const double height = Dimen.iconFootprint;
  static const double leadingPadding = 0;
  static const double trailingPadding = 0;
  /// Horizontal padding `dropdown_button2` adds inside the button before the
  /// item text starts (`_kMenuItemPadding`, applied when both button width and
  /// dropdown width are null). Hosts can use it to align outside labels with
  /// the selector's text.
  static const double internalTextPadding = 16.0;

  final List<String> allVariantIds;
  final String selVariantIds;

  final void Function(String?) onChanged;

  const ApelEwanCategorySelector({
    required this.allVariantIds,
    required this.selVariantIds,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
            'Wariant pytań',
            style: AppTextStyle(color: hintEnab_(context))
        ),
        items: allVariantIds.map((variantId) =>
            DropdownItem<String>(
              value: variantId,
              child: Text(
                  apelEwansVariantNameMap[variantId]!,
                  style: AppTextStyle(fontWeight: variantId == selVariantIds?weightHalfBold:weightNormal)
              ),
            ))
            .toList(),
        valueListenable: ValueNotifier(selVariantIds),
        onChanged: onChanged,
        iconStyleData: IconStyleData(
          icon: Icon(MdiIcons.dotsVertical),
          iconSize: Dimen.iconSize,
        ),

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(left: leadingPadding, right: trailingPadding),
        ),

        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
          ),
        ),
      )
  );

}
