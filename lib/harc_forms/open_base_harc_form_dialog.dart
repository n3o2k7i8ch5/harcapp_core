import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

import 'data.dart';
import 'harc_form.dart';
import 'harc_form_widget.dart';

Future<void> openBaseHarcFormDialog({
  required BuildContext context,
  required String name,
}) async {

  HarcForm form;

  try {
    form = allForms.firstWhere((element) => element.filename == name);
  } on StateError {
    return;
  }

  await showDialog(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(Dimen.defMarg),
        child: Material(
          borderRadius: BorderRadius.circular(AppCard.bigRadius),
          clipBehavior: Clip.hardEdge,
          child: BaseHarcFormWidget(form)
        ),
      )
  );
}