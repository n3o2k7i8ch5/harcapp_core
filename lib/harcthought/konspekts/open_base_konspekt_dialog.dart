import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/data/all.dart' as all;
import 'package:harcapp_core/harcthought/konspekts/data/harcerskie/all.dart' as harcerskie;
import 'package:harcapp_core/harcthought/konspekts/data/ksztalcenie/all.dart' as ksztalcenie;


import 'konspekt.dart';
import 'base_konspekt_widget.dart';

Future<void> openBaseKonspektDialog({
  required BuildContext context,
  required String konspektName,
  KonspektCategory? category,
  List<Konspekt>? allKonspekts,
  final void Function()? onDuchLevelInfoTap,
  final void Function()? onDuchMechanismInfoTap,
  double? maxWidth,
}) async {

  Konspekt konspekt;

  if(category == KonspektCategory.harcerskie)
    allKonspekts ??= harcerskie.allHarcerskieKonspekts;
  else if(category == KonspektCategory.ksztalcenie)
    allKonspekts ??= ksztalcenie.allKsztalcenieKonspekts;
  else
    allKonspekts ??= all.allKonspekts;

  try {
    konspekt = allKonspekts.firstWhere((element) => element.name == konspektName);
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
              child: BaseKonspektWidget(
                  konspekt,
                  onDuchLevelInfoTap: onDuchLevelInfoTap,
                  onDuchMechanismInfoTap: onDuchMechanismInfoTap
              )
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