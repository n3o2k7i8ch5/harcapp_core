import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';

/// Stadium-shaped pill showing the poradnik's page count
/// (e.g. "37 stron"). Sits typically below the cover.
class PoradnikPageCountPill extends StatelessWidget {
  final int pageCount;

  const PoradnikPageCountPill(this.pageCount, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimen.iconMarg,
          vertical: Dimen.defMarg,
        ),
        decoration: ShapeDecoration(
          color: cardEnab_(context),
          shape: const StadiumBorder(),
        ),
        child: Text(
          '$pageCount stron',
          style: AppTextStyle(
            fontSize: Dimen.textSizeBig,
            fontWeight: weightHalfBold,
            color: hintEnab_(context),
          ),
        ),
      );
}
