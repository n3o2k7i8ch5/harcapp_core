import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'apel_ewan.dart';
import 'apel_ewan_category_selector.dart';

class ApelEwanWidget extends StatefulWidget{

  final ApelEwan apelEwan;
  final String? initVariantId;

  const ApelEwanWidget(this.apelEwan, {this.initVariantId, super.key});

  @override
  State<StatefulWidget> createState() => ApelEwanWidgetState();

}

class ApelEwanWidgetState extends State<ApelEwanWidget>{

  ApelEwan get apelEwan => widget.apelEwan;

  late String selVariantId;
  late List<String> allVariantId;

  String? author;

  ApelEwanVariant? get selVariant => apelEwan.variants[selVariantId];

  @override
  void initState() {

    final initVariantId = widget.initVariantId;
    selVariantId = (initVariantId != null && apelEwan.variants.containsKey(initVariantId))
        ? initVariantId
        : apelEwan.variants.keys.first;
    allVariantId = apelEwan.variants.keys.toList();

    switch(apelEwan.siglum.split(' ')[0]){
      case 'Mt':
        author = 'Mateusza';
        break;
      case 'Mk':
        author = 'Marka';
        break;
      case 'Łk':
        author = 'Łukasza';
        break;
      case 'J':
        author = 'Jana';
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final variant = selVariant;
    final hasComment = variant?.comment != null;
    final hasQuestions = variant != null && variant.questions.isNotEmpty;
    return Column(
      children: [

        Material(
            clipBehavior: Clip.hardEdge,
            color: cardEnab_(context),
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
            child: Padding(
              padding: const EdgeInsets.all(Dimen.sideMarg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Text(
                    variant!.title,
                    style: const AppTextStyle(
                        fontSize: Dimen.textSizeAppBar,
                        fontWeight: weightBold
                    ),
                    textAlign: TextAlign.center,
                  ),

                  if(author != null)
                    const SizedBox(height: Dimen.sideMarg),

                  if(author != null)
                    Text(
                      'Słowa Ewangelii według św. $author',
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weightHalfBold,
                          color: hintEnab_(context)
                      ),
                      textAlign: TextAlign.justify,
                    ),

                  const SizedBox(height: Dimen.sideMarg),

                  AppText(
                    apelEwan.text.replaceAll('\n\n', '\n').replaceAll('\n', '\n\n'),
                    size: Dimen.textSizeBig,
                    textAlign: TextAlign.justify,
                  ),

                  const SizedBox(height: Dimen.sideMarg),

                  const Text(
                    'Oto Słowo Boże.',
                    style: AppTextStyle(fontSize: Dimen.textSizeBig),
                    textAlign: TextAlign.justify,
                  ),

                ],
              ),
            )
        ),

        const SizedBox(height: Dimen.sideMarg),

        if(hasComment || hasQuestions)
          Material(
            clipBehavior: Clip.hardEdge,
            color: cardEnab_(context),
            borderRadius: BorderRadius.circular(AppCard.bigRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                if(allVariantId.length > 1)
                  Material(
                    color: backgroundIcon_(context),
                    child: Row(
                      children: [

                        const SizedBox(width: Dimen.sideMarg),

                        const Text(
                          'Wariant:',
                          style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold),
                          textAlign: TextAlign.justify,
                        ),

                        Expanded(
                          child: ApelEwanCategorySelector(
                            allVariantIds: allVariantId,
                            selVariantIds: selVariantId,
                            onChanged: (value) => setState(() => selVariantId = value as String),
                          ),
                        ),
                      ],
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.all(Dimen.sideMarg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      if(hasComment)
                        const Text(
                          'Garść komentarzy',
                          style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold),
                          textAlign: TextAlign.justify,
                        ),

                      if(hasComment)
                        const SizedBox(height: Dimen.sideMarg),

                      if(hasComment)
                        Text(
                          variant.comment!,
                          style: const AppTextStyle(fontSize: Dimen.textSizeBig),
                          textAlign: TextAlign.justify,
                        ),

                      if(hasComment)
                        const SizedBox(height: 2*Dimen.sideMarg),

                      if(hasQuestions)
                        const Text(
                          'Pytania',
                          style: AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold),
                          textAlign: TextAlign.justify,
                        ),

                      if(hasQuestions)
                        const SizedBox(height: Dimen.sideMarg),

                      if(hasQuestions)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 32,
                                    child: Text(
                                        '${index + 1}',
                                        style: const AppTextStyle(fontSize: Dimen.textSizeBig, fontWeight: weightHalfBold)
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                        variant.questions[index],
                                        size: Dimen.textSizeBig
                                    ),
                                  )
                                ]),
                          ),
                          itemCount: variant.questions.length,
                          shrinkWrap: true,
                        )

                    ],
                  ),
                ),

              ],
            ),
          ),

        if(hasComment || hasQuestions)
          const SizedBox(height: Dimen.sideMarg),

      ],
    );
  }

}
