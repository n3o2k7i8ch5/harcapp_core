import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';

import 'data.dart';
import 'harc_form.dart';
import 'base_harc_form_widget.dart';

Future<void> openBaseHarcFormDialog({
  required BuildContext context,
  required String name,
  double? maxWidth,
}) async {

  HarcForm form;

  try {
    form = allForms.firstWhere((element) => element.filename == name);
  } on StateError {
    return;
  }

  await showDialog(
      context: context,
      builder: (context){

        Widget child = Padding(
          padding: const EdgeInsets.all(Dimen.defMarg),
          child: Material(
              borderRadius: BorderRadius.circular(AppCard.bigRadius),
              clipBehavior: Clip.hardEdge,
              child: BaseHarcFormWidget(form)
          ),
        );

        if(maxWidth == null)
          return Center(child: child);
        else
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          );

      }
  );
}