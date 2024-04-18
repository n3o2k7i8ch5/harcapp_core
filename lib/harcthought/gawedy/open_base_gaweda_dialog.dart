import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

import 'base_gaweda_widget.dart';
import 'data.dart';
import 'gaweda.dart';

Future<void> openBaseGawedaDialog({
  required BuildContext context,
  required String gawedaName,
  double? maxWidth,
}) async {

  Gaweda gaweda;

  try {
    gaweda = allGawedy.firstWhere((element) => element.fileName == gawedaName);
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
                  child: BaseGawedaWidget(gaweda)
              ),
            )
        ),
      )
  );
}