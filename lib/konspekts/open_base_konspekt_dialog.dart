import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

import 'data.dart';
import 'konspekt.dart';
import 'base_konspekt_widget.dart';

Future<void> openBaseKonspektDialog({
  required BuildContext context,
  required String konspektName,
  final void Function()? onDuchLevelInfoTap,
  final void Function()? onDuchMechanismInfoTap,
  double? maxWidth,
}) async {

  Konspekt konspekt;

  try {
    konspekt = allKonspekts.firstWhere((element) => element.name == konspektName);
  } on StateError {
    return;
  }

  await showDialog(
      context: context,
      builder: (context) => Center(
        child: Padding(
            padding: const EdgeInsets.all(Dimen.defMarg),
            child: SizedBox(
              width: maxWidth,
              child: Material(
                  borderRadius: BorderRadius.circular(AppCard.bigRadius),
                  clipBehavior: Clip.hardEdge,
                  child: BaseKonspektWidget(
                      konspekt,
                      onDuchLevelInfoTap: onDuchLevelInfoTap,
                      onDuchMechanismInfoTap: onDuchMechanismInfoTap
                  )
              ),
            )
        ),
      )
  );
}