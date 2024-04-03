import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/animated_child_slider.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../providers.dart';

class TopCards extends StatelessWidget{

  final Color? accentColor;
  final Function(String)? onChangedTitle;
  final Function(List<String>)? onChangedHiddenTitles;
  final Function(List<String>)? onChangedAuthor;
  final Function(List<String>)? onChangedComposer;
  final Function(List<String>)? onChangedPerformer;
  final Function(String?)? onChangedYT;
  final Function(DateTime?)? onChangedReleaseDate;

  const TopCards({
    this.accentColor,
    this.onChangedTitle,
    this.onChangedHiddenTitles,
    this.onChangedAuthor,
    this.onChangedComposer,
    this.onChangedPerformer,
    this.onChangedYT,
    this.onChangedReleaseDate,
  });

  bool isLastHidTitleEmpty(CurrentItemProvider currItemProv) => currItemProv.hiddenTitlesController.isLastEmpty;
  
  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
      builder: (context, currItemProv, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: EdgeInsets.only(left: Dimen.defMarg, right: Dimen.defMarg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Row(
                  children: [
                    Expanded(
                      child: AppTextFieldHint(
                        accentColor: accentColor,
                        controller: currItemProv.titleController,
                        hint: 'Tytuł:',
                        style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weight.halfBold,
                          color: textEnab_(context),
                        ),
                        hintStyle: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          color: hintEnab_(context),
                        ),
                        onAnyChanged: (values) => onChangedTitle?.call(values[0]),
                      ),
                    ),

                    AnimatedChildSlider(
                      index: currItemProv.hiddenTitlesController.isEmpty?0:1,
                      children: [
                        IconButton(
                          icon: Icon(MdiIcons.plus),
                          onPressed: () => onChangedHiddenTitles?.call(currItemProv.addHidTitle()),
                        ),

                        IconButton(
                          icon: Icon(MdiIcons.informationOutline),
                          onPressed: () =>
                            AppScaffold.showMessage(context, 'Tytuły ukryte są dodatkowymi kluczami wyszukwiania piosneki.'),
                        )
                      ],
                    )

                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    ImplicitlyAnimatedList<TextEditingController>(
                      physics: BouncingScrollPhysics(),
                      items: currItemProv.hiddenTitlesController.controllers,
                      areItemsTheSame: (a, b) => a.hashCode == b.hashCode,

                      itemBuilder: (context, animation, item, index) => SizeFadeTransition(
                        sizeFraction: 0.7,
                        curve: Curves.easeInOut,
                        animation: animation,
                        child: AddTextWidget(
                          item,
                          onTextChanged: (text) =>
                              onChangedHiddenTitles?.call(currItemProv.editHidTitle(index, text)),
                          onRemove: () =>
                            onChangedHiddenTitles?.call(currItemProv.removeHidTitleAt(index)),
                        ),
                      ),

                      removeItemBuilder: (context, animation, oldItem) => SizeFadeTransition(
                        sizeFraction: 0.7,
                        curve: Curves.easeInOut,
                        animation: animation,
                        child: AddTextWidget(oldItem),
                      ),

                      shrinkWrap: true,
                    ),

                    AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: currItemProv.hiddenTitlesController.isEmpty?
                        0:
                        Dimen.iconFootprint + Dimen.iconMarg,

                        child: AnimatedOpacity(
                          opacity: currItemProv.hiddenTitlesController.isEmpty?
                          0:
                          1,

                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: SimpleButton.from(
                            icon: MdiIcons.plus,
                            text: 'Dodaj tytuł ukryty',

                            textColor:
                            isLastHidTitleEmpty(currItemProv)?
                            iconDisab_(context):
                            iconEnab_(context),

                            radius: AppCard.bigRadius,
                            margin: EdgeInsets.only(bottom: Dimen.iconMarg),
                            onTap: isLastHidTitleEmpty(currItemProv)?null:(){
                              List<String> hidTitles = currItemProv.addHidTitle();
                              onChangedHiddenTitles?.call(hidTitles);
                            },
                            center: false
                          ),
                        )
                    ),

                  ],
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Autor słów:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weight.halfBold,
                    color: textEnab_(context),
                  ),
                  hintStyle: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    color: hintEnab_(context),
                  ),
                  multi: true,
                  multiHintTop: 'Autorzy słów:',
                  multiExpanded: true,
                  multiController: currItemProv.authorsController,
                  onAnyChanged: onChangedAuthor,
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Kompozytor muzyki:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weight.halfBold,
                    color: textEnab_(context),
                  ),
                  hintStyle: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    color: hintEnab_(context),
                  ),
                  multi: true,
                  multiHintTop: 'Kompozytorzy muzyki:',
                  multiExpanded: true,
                  multiController: currItemProv.composersController,
                  onAnyChanged: onChangedComposer,
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Wykonawca:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weight.halfBold,
                    color: textEnab_(context),
                  ),
                  hintStyle: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    color: hintEnab_(context),
                  ),
                  multi: true,
                  multiHintTop: 'Wykonawcy:',
                  multiExpanded: true,
                  multiController: currItemProv.performersController,
                  onAnyChanged: onChangedPerformer,
                ),

                Row(
                  children: [

                    if(currItemProv.ytLinkController.text.isEmpty)
                      IconButton(
                        icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                        onPressed: () => AppScaffold.showMessage(context, 'Podaj link do piosenki na jutubie'),
                      ),

                    Expanded(
                      child: AppTextFieldHint(
                        accentColor: accentColor,
                        controller: currItemProv.ytLinkController,
                        hint: 'Link YouTube:',
                        style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weight.halfBold,
                          color: textEnab_(context),
                        ),
                        hintStyle: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          color: hintEnab_(context),
                        ),
                        onAnyChanged: (values) => onChangedYT?.call(values[0]),
                      ),
                    ),

                  ],
                )

              ],
            ),
          ),

          Column(
            children: [
              Row(
                children: [

                  SizedBox(width: Dimen.defMarg),

                  Expanded(
                    child: Stack(
                      children: [

                        IgnorePointer(
                          ignoring: true,
                          child: AppTextFieldHint(
                            accentColor: accentColor,
                            controller: TextEditingController(
                                text:
                                currItemProv.releaseDate==null ?
                                '':
                                dateToString(
                                    currItemProv.releaseDate!,
                                    showMonth: currItemProv.showRelDateMonth,
                                    showDay: currItemProv.showRelDateMonth&&currItemProv.showRelDateDay
                                )
                            ),
                            hint: 'Data pierwszego wykonania:',
                            style: AppTextStyle(
                              fontSize: Dimen.textSizeBig,
                              fontWeight: weight.halfBold,
                              color: textEnab_(context),
                            ),
                            hintStyle: AppTextStyle(
                              fontSize: Dimen.textSizeBig,
                              color: hintEnab_(context),
                            ),
                            onAnyChanged: (text) => onChangedReleaseDate?.call(currItemProv.releaseDate),
                            key: ValueKey(Tuple3(currItemProv.releaseDate, currItemProv.showRelDateMonth, currItemProv.showRelDateDay)),
                          ),
                        ),

                        Positioned.fill(
                          child: GestureDetector(
                              child: Container(color: Colors.transparent),
                              onTap: () async {
                                currItemProv.setReleaseDate(await showDatePicker(
                                  context: context,
                                  initialDate: currItemProv.releaseDate??DateTime.now(),
                                  firstDate: DateTime(966),
                                  lastDate: DateTime.now(),
                                ));
                              }
                          ),
                        )

                      ],
                    ),
                  ),

                  IconButton(
                      icon: Icon(MdiIcons.close),
                      onPressed: currItemProv.releaseDate==null?null:(){
                        currItemProv.setReleaseDate(null);
                      }
                  ),

                  SizedBox(width: Dimen.defMarg),

                ],
              ),

              if(currItemProv.releaseDate != null)
                Row(
                  children: [

                    SimpleButton.from(
                        textColor: currItemProv.showRelDateDay && currItemProv.showRelDateMonth?iconEnab_(context):iconDisab_(context),
                        dense: true,
                        margin: EdgeInsets.zero,
                        icon: MdiIcons.calendarOutline,
                        text: 'Pok. dzień',
                        onTap: currItemProv.showRelDateMonth?() => currItemProv.setShowRelDateDay(!currItemProv.showRelDateDay) : null
                    ),

                    SimpleButton.from(
                        textColor: currItemProv.showRelDateMonth?iconEnab_(context):iconDisab_(context),
                        dense: true,
                        margin: EdgeInsets.zero,
                        icon: MdiIcons.calendarMonthOutline,
                        text: 'Pok. miesiąc',
                        onTap: () => currItemProv.setShowRelDateMonth(!currItemProv.showRelDateMonth)
                    )

                  ],
                )
            ],
          )

        ],
      )
  );

}

class AddTextWidget extends StatelessWidget{

  final TextEditingController controller;
  final void Function(String)? onTextChanged;
  final void Function()? onRemove;
  const AddTextWidget(this.controller, {this.onTextChanged, this.onRemove});

  @override
  Widget build(BuildContext context) => Row(
    children: [

      IconButton(
        icon: Icon(MdiIcons.trashCanOutline),
        padding: EdgeInsets.all(Dimen.iconMarg),
        onPressed: onRemove,
      ),

      Expanded(child: AppTextFieldHint(
        hint: 'Tytuł ukryty:',
        hintTop: '',
        controller: controller,
        style: AppTextStyle(
          fontSize: Dimen.textSizeBig,
          color: textEnab_(context),
        ),
        hintStyle: AppTextStyle(
          fontSize: Dimen.textSizeBig,
          color: hintEnab_(context),
        ),
        onChanged: (_, value) => onTextChanged?.call(value),
      )),

    ],
  );

}