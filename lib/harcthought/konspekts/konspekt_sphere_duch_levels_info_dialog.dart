import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';

import 'konspekt.dart';

class KonspektSphereDuchLevelsInfoDialog extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: BorderRadius.circular(AppCard.bigRadius),
    clipBehavior: Clip.hardEdge,
    color: background_(context),
    child: Scaffold(
        appBar: AppBarX(title: 'Poziomy duchowości'),
        body: ListView(
          padding: const EdgeInsets.all(Dimen.sideMarg - Dimen.defMarg),
          children: [
            TitleShortcutRowWidget(
                title: KonspektSphereLevel.duchAksjomaty.displayName,
                titleColor: KonspektSphereLevel.duchAksjomaty.color,
                textAlign: TextAlign.left
            ),

            const AppText(
              'Aksjomat duchowości jest jej fundamentem. Jest arbitralnie uznaną prawdą, której nie sposób zweryfikować. Aksjomaty definiują cel życia, najwyższe dobro, przyczynę istnienia, sposób, w jaki działa świat itd..',
              size: Dimen.textSizeBig,
            ),

            const SizedBox(height: Dimen.sideMarg),

            TitleShortcutRowWidget(
                title: KonspektSphereLevel.duchWartosci.displayName,
                titleColor: KonspektSphereLevel.duchWartosci.color,
                textAlign: TextAlign.left
            ),

            const AppText(
              'Wartości są preferowanym stanem rzeczywistości. Pozwalają oceniać działania - określają czy i na ile określone działanie zmienia rzeczywistość w kierunku wynikającym aksjomatu. Wartości definiują także hierarchię spraw, którym powinno się poświęcać najwięcej zasobów (czasu, energii, siły, pieniędzy, etc.).',
              size: Dimen.textSizeBig,
            ),

            const SizedBox(height: Dimen.sideMarg),

            TitleShortcutRowWidget(
                title: KonspektSphereLevel.duchPostawy.displayName,
                titleColor: KonspektSphereLevel.duchPostawy.color,
                textAlign: TextAlign.left
            ),

            const AppText(
              'Postawy to sposoby bycia, czyli skłonności do określonego postępowania.',
              size: Dimen.textSizeBig,
            ),

          ],
        )
    ),
  );

}

void openKonspektSphereDuchLevelsInfoDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Padding(
        padding: const EdgeInsets.all(Dimen.defMarg),
        child: KonspektSphereDuchLevelsInfoDialog()
    )
);