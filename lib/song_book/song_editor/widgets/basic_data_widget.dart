import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_widgets/animated_child_slider.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/multi_text_field.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../providers.dart';

class BasicDataWidget extends StatelessWidget{

  final Color? accentColor;
  final Function(String)? onChangedTitle;
  final Function(List<String>)? onChangedHiddenTitles;
  final Function(List<String>)? onChangedAuthor;
  final Function(List<String>)? onChangedComposer;
  final Function(List<String>)? onChangedPerformer;
  final Function(String?)? onChangedYT;
  final Function(DateTime?)? onChangedReleaseDate;

  const BasicDataWidget({
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
                          fontWeight: weightHalfBold,
                          color: textEnab_(context),
                        ),
                        hintStyle: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          color: hintEnab_(context),
                        ),
                        onAnyChanged: (values){
                          currItemProv.setTitle(values[0], notify: false);
                          onChangedTitle?.call(values[0]);
                        },
                      ),
                    ),

                    AnimatedChildSlider(
                      // In this case `length==0` is not the same as `isEmpty`!
                      index: currItemProv.hiddenTitlesController.length==0?0:1,
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

                AnimatedOpacity(
                  // In this case `length==0` is not the same as `isEmpty`!
                  opacity: currItemProv.hiddenTitlesController.length==0? 0: 1,

                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: IgnorePointer(
                    // In this case `length==0` is not the same as `isEmpty`!
                    ignoring: currItemProv.hiddenTitlesController.length==0,
                    child: AppTextFieldHint(
                      hint: 'Ukryty tytuł:',
                      multiController: currItemProv.hiddenTitlesController,
                      onAnyChanged: onChangedHiddenTitles,

                      multi: true,
                      multiLayout: LayoutMode.column,
                      multiAllowZeroFields: true,
                      multiExpanded: true,
                      multiItemBuilder: (index, widget) => Row(
                        children: [
                          Icon(MdiIcons.circleMedium),
                          SizedBox(width: Dimen.iconMarg),
                          Expanded(child: widget)
                        ],
                      ),
                      multiAddButtonBuilder: (tappable, onTap) => SimpleButton.from(
                          icon: MdiIcons.plus,
                          text: 'Dodaj ukryty tytuł',
                          margin: EdgeInsets.zero,

                          textColor:
                          tappable?
                          iconEnab_(context):
                          iconDisab_(context),

                          onTap: tappable?(){
                            List<String> hidTitles = currItemProv.addHidTitle();
                            onChangedHiddenTitles?.call(hidTitles);
                          }:null,
                          center: false
                      ),
                    ),
                  ),
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Autor słów:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weightHalfBold,
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
                  onAnyChanged: (values){
                    currItemProv.setAuthors(values, notify: false);
                    onChangedAuthor?.call(values);
                  },
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Kompozytor muzyki:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weightHalfBold,
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
                  onAnyChanged: (values){
                    currItemProv.setComposers(values, notify: false);
                    onChangedComposer?.call(values);
                  },
                ),

                AppTextFieldHint(
                  accentColor: accentColor,
                  hint: 'Wykonawca:',
                  style: AppTextStyle(
                    fontSize: Dimen.textSizeBig,
                    fontWeight: weightHalfBold,
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
                  onAnyChanged: (values){
                    currItemProv.setPerformers(values, notify: false);
                    onChangedPerformer?.call(values);
                  },
                ),

                Row(
                  children: [

                    if(currItemProv.ytLinkController.text.isEmpty)
                      IconButton(
                        icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                        onPressed: () => AppScaffold.showMessage(context, 'Podaj link do piosenki na jutubie'),
                      )
                    else if(currItemProv.ytLinkController.text.isNotEmpty && SongRaw.ytLinkToVideoId(currItemProv.ytLinkController.text) == null)
                      IconButton(
                        icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                        onPressed: () => AppScaffold.showMessage(context, 'Coś jest nie tak z linkiem do piosenki na jutubie'),
                      ),

                    Expanded(
                      child: AppTextFieldHint(
                        accentColor: accentColor,
                        controller: currItemProv.ytLinkController,
                        hint: 'Link YouTube:',
                        style: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          fontWeight: weightHalfBold,
                          color: textEnab_(context),
                        ),
                        hintStyle: AppTextStyle(
                          fontSize: Dimen.textSizeBig,
                          color: hintEnab_(context),
                        ),
                        onAnyChanged: (values) {
                          currItemProv.setYoutubeVideoId(SongRaw.ytLinkToVideoId(values[0]), notify: false);
                          onChangedYT?.call(values[0]);
                        }
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
                              fontWeight: weightHalfBold,
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
