import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
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
        appBar: AppBarX(
          title: 'O co tu chodzi?',
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: iconEnab_(context)),
          titleTextStyle: AppTextStyle(
            color: iconEnab_(context),
            fontSize: Dimen.textSizeAppBar
          ),
        ),
        body: SelectionArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(Dimen.sideMarg - Dimen.defMarg),
            children: [
              TitleShortcutRowWidget(
                  title: 'Poziomy duchowości',
                  textAlign: TextAlign.left
              ),

              const AppText(
                'Duchowość jest sposobem, w jaki człowiek żyje. Każda duchowość jest w pełni definiowana przez zachowania, postawy, wartości i aksjomaty, w które człowiek wierzy.',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              Text(
                KonspektSphereLevel.duchAksjomaty.displayName,
                style: AppTextStyle(
                  color: KonspektSphereLevel.duchAksjomaty.color,
                  fontWeight: weight.bold,
                  fontSize: Dimen.textSizeBig
                ),
              ),
              const SizedBox(height: Dimen.defMarg),
              const AppText(
                'Aksjomaty są fundamentem duchowości. Są to arbitralnie uznane prawdą, których nie sposób zweryfikować. Definiują cel życia, najwyższe dobro, przyczynę istnienia, sposób, w jaki działa świat itd..',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              Text(
                KonspektSphereLevel.duchWartosci.displayName,
                style: AppTextStyle(
                  color: KonspektSphereLevel.duchWartosci.color,
                  fontWeight: weight.bold,
                  fontSize: Dimen.textSizeBig
                ),
              ),
              const SizedBox(height: Dimen.defMarg),
              const AppText(
                'Wartości są preferowanym stanem rzeczywistości. Pozwalają oceniać działania - określają czy i na ile określone działanie zmienia rzeczywistość w kierunku wynikającym aksjomatu. Wartości definiują także hierarchię spraw, którym powinno się poświęcać najwięcej zasobów (czasu, energii, siły, pieniędzy, etc.).',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              Text(
                KonspektSphereLevel.duchPostawy.displayName,
                style: AppTextStyle(
                  color: KonspektSphereLevel.duchPostawy.color,
                  fontWeight: weight.bold,
                  fontSize: Dimen.textSizeBig
                ),
              ),
              const SizedBox(height: Dimen.defMarg),
              const AppText(
                'Postawy to sposoby bycia, czyli skłonności do określonego postępowania.',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              TitleShortcutRowWidget(
                  title: 'Zdolność kształtowania duchowości',
                  textAlign: TextAlign.left
              ),

              const AppText(
                'Ksztaltowanie duchowości odbywa się przez proces zwany "integracją duchowości". Polega na stopniowym dostosowywaniu postaw, wartości i aksjomatów do siebie nawzajem tak, by były spójne zarówno między sobą, jak i z doświadczeniem otaczającego człowieka świata.'
                '\n'
                '\nIntegracja duchowości wymaga od człowieka zdolności do refleksji, podejmowania wysiłku i przekraczania swoich granic.',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              Text(
                KonspektSphereLevel.duchHartDucha.displayName,
                style: AppTextStyle(
                  color: KonspektSphereLevel.duchHartDucha.color,
                  fontWeight: weight.bold,
                  fontSize: Dimen.textSizeBig
                ),
              ),
              const SizedBox(height: Dimen.defMarg),
              const AppText(
                'Hart ducha (siła charakteru) to zdolność do postępowania zgodnie z tym, co uważa się za słuszne pomimo niesprzyjających okoliczności: fizycznego trudu, kosztu finansowego, ostracyzmu społecznego, itd..',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

              const SizedBox(height: Dimen.sideMarg),

              Text(
                KonspektSphereLevel.duchZdolnoscRefleksyjna.displayName,
                style: AppTextStyle(
                    color: KonspektSphereLevel.duchZdolnoscRefleksyjna.color,
                    fontWeight: weight.bold,
                    fontSize: Dimen.textSizeBig
                ),
              ),
              const SizedBox(height: Dimen.defMarg),
              const AppText(
                'Zdolność refleksyjna określa zdolność do trafnego wnioskowania prawidłowych zachowań, postaw i wartości z aksjomatów oraz weryfikacji przyjętych aksjomatów na podstawie doświadczeń. Pozwala na analizę własnej duchowości i na ocenę czy i w jakim kierunku powinna ulec zmianie.',
                size: Dimen.textSizeBig,
                height: 1.2,
              ),

            ],
          ),
        )
    ),
  );

}

void openKonspektSphereDuchLevelsInfoDialog(
    BuildContext context,
    {double? maxWidth}
    ) => showDialog(
    context: context,
    builder: (context){

      Widget child = Padding(
        padding: const EdgeInsets.all(Dimen.defMarg),
        child: KonspektSphereDuchLevelsInfoDialog()
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