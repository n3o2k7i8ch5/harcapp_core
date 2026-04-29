import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'apel_ewan_loader.dart';

class ApelEwanCategorySelector extends StatelessWidget{

  static const double height = Dimen.iconFootprint;
  static const double leadingPadding = 6;
  static const double trailingPadding = 14;

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
          ),
        ),
      )
  );

}
