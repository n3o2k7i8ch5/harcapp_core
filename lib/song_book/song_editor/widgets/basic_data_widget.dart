import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/common.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/comm_classes/web_utils_stub.dart'
if (dart.library.html) 'package:harcapp_core/comm_classes/web_utils_web.dart';
import 'package:harcapp_core/comm_widgets/animated_child_slider.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/multi_text_field.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

class BasicDataWidget extends StatelessWidget{

  final Color? accentColor;
  final EdgeInsets? padding;
  final Function(String)? onChangedTitle;
  final Function(List<String>)? onChangedHiddenTitles;
  final Function(List<String>)? onChangedAuthor;
  final Function(List<String>)? onChangedComposer;
  final Function(List<String>)? onChangedPerformer;
  final Function(String?)? onChangedYT;
  final Function(DateTime?)? onChangedReleaseDate;

  const BasicDataWidget({
    this.accentColor,
    this.padding,
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
      builder: (context, currItemProv, child) => Padding(
        padding: EdgeInsets.only(
          top: padding?.top??0,
          bottom: padding?.bottom??0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Row(
              children: [
                Expanded(
                  child: AppTextFieldHint(
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
                    contentPadding: EdgeInsets.only(left: padding?.left??0),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),

                AnimatedChildSlider(
                  // In this case `length==0` is not the same as `isEmpty`!
                  index: currItemProv.hiddenTitlesController.length==0?0:1,
                  children: [
                    AppButton(
                      icon: Icon(MdiIcons.plus),
                      onTap: () => onChangedHiddenTitles?.call(currItemProv.addHidTitle()),
                    ),

                    AppButton(
                      icon: Icon(MdiIcons.informationOutline),
                      onTap: () =>
                          AppScaffold.showMessage(context, text: 'Tytuły ukryte są dodatkowymi kluczami wyszukwiania piosneki.'),
                    )
                  ],
                ),

                if(padding != null)
                  SizedBox(width: padding!.right)
                
              ],
            ),

            Builder(
              builder: (context){

                Widget child = AppTextFieldHint(
                  hint: 'Ukryty tytuł:',
                  alwaysShowTopHint: true,
                  multiController: currItemProv.hiddenTitlesController,
                  onAnyChanged: onChangedHiddenTitles,

                  multi: true,
                  multiHintTop: 'Ukryte tytuły',
                  multiLayout: LayoutMode.column,
                  multiAllowZeroFields: true,
                  multiExpanded: true,
                  multiIsCollapsed: true,
                  multiItemBuilder: (index, key, widget) => Row(
                    key: key,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Dimen.iconMarg),
                        child: Icon(MdiIcons.circleMedium),
                      ),
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
                  multiPadding: EdgeInsets.only(
                    left: padding?.left??0,
                    right: padding?.right??0,
                  ),
                  multiOnAdded: () => currItemProv.notify(),
                  multiOnRemoved: (_) => currItemProv.notify(),
                );

                if(currItemProv.hiddenTitlesController.length<=1)
                  return AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    alignment: Alignment.topCenter,
                    child: currItemProv.hiddenTitlesController.length==0?
                    Container():
                    child,
                  );

                return child;

              },
            ),

            // AnimatedOpacity(
            //   // In this case `length==0` is not the same as `isEmpty`!
            //   opacity: currItemProv.hiddenTitlesController.length==0? 0: 1,
            //
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            //   child: IgnorePointer(
            //     // In this case `length==0` is not the same as `isEmpty`!
            //     ignoring: currItemProv.hiddenTitlesController.length==0,
            //     child:
            //
            //     AppTextFieldHint(
            //       hint: 'Ukryty tytuł:',
            //       multiController: currItemProv.hiddenTitlesController,
            //       onAnyChanged: onChangedHiddenTitles,
            //
            //       multi: true,
            //       multiHintTop: 'Ukryte tytuły',
            //       multiLayout: LayoutMode.column,
            //       multiAllowZeroFields: true,
            //       multiExpanded: true,
            //       multiIsCollapsed: true,
            //       multiItemBuilder: (index, key, widget) => Row(
            //         key: key,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.all(Dimen.iconMarg),
            //             child: Icon(MdiIcons.circleMedium),
            //           ),
            //           Expanded(child: widget)
            //         ],
            //       ),
            //       multiAddButtonBuilder: (tappable, onTap) => SimpleButton.from(
            //           icon: MdiIcons.plus,
            //           text: 'Dodaj ukryty tytuł',
            //           margin: EdgeInsets.zero,
            //
            //           textColor:
            //           tappable?
            //           iconEnab_(context):
            //           iconDisab_(context),
            //
            //           onTap: tappable?(){
            //             List<String> hidTitles = currItemProv.addHidTitle();
            //             onChangedHiddenTitles?.call(hidTitles);
            //           }:null,
            //           center: false
            //       ),
            //       multiPadding: EdgeInsets.only(
            //         left: padding?.left??0,
            //         right: padding?.right??0,
            //       ),
            //       multiOnAdded: () => currItemProv.notify(),
            //       multiOnRemoved: (_) => currItemProv.notify(),
            //     ),
            //   ),
            // ),

            AppTextFieldHint(
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
              multiHintTop: 'Autorzy słów',
              multiExpanded: true,
              multiController: currItemProv.authorsController,
              onAnyChanged: (values){
                currItemProv.setAuthors(values, notify: false);
                onChangedAuthor?.call(values);
              },
              multiPadding: padding,

            ),

            AppTextFieldHint(
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
              multiHintTop: 'Kompozytorzy',
              multiExpanded: true,
              multiController: currItemProv.composersController,
              multiPadding: padding,
              onAnyChanged: (values){
                currItemProv.setComposers(values, notify: false);
                onChangedComposer?.call(values);
              },
            ),

            AppTextFieldHint(
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
              multiHintTop: 'Wykonawcy',
              multiExpanded: true,
              multiController: currItemProv.performersController,
              multiPadding: padding,
              onAnyChanged: (values){
                currItemProv.setPerformers(values, notify: false);
                onChangedPerformer?.call(values);
              },
            ),

            Row(
              children: [

                if(padding != null)
                  SizedBox(width: padding!.left),

                Expanded(
                  child: AppTextFieldHint(
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


                if(currItemProv.ytLinkController.text.isEmpty)
                  AppButton(
                    icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                    onTap: () => AppScaffold.showMessage(context, text: 'Podaj link do piosenki na jutubie'),
                  )
                else if(currItemProv.ytLinkController.text.isNotEmpty && SongRaw.ytLinkToVideoId(currItemProv.ytLinkController.text) == null)
                  AppButton(
                    icon: Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                    onTap: () => AppScaffold.showMessage(context, text: 'Coś jest nie tak z linkiem do piosenki na jutubie'),
                  )
                else if(SongRaw.ytLinkToVideoId(currItemProv.ytLinkController.text) != null)
                  AppButton(
                    icon: Icon(MdiIcons.openInNew),
                    onTap: (){
                      if(kIsWeb) openInNewTab(currItemProv.ytLinkController.text);
                      else launchURL(currItemProv.ytLinkController.text);
                    },
                  ),

                if(padding != null)
                  SizedBox(width: padding!.right)

              ],
            ),

            Row(
              children: [

                if(padding != null)
                  SizedBox(width: padding!.left),

                Expanded(
                  child: Stack(
                    children: [

                      IgnorePointer(
                        ignoring: true,
                        child: AppTextFieldHint(
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
                          key: ValueKey((currItemProv.releaseDate, currItemProv.showRelDateMonth, currItemProv.showRelDateDay)),
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

                AppButton(
                    icon: Icon(MdiIcons.close),
                    onTap: currItemProv.releaseDate==null?null:(){
                      currItemProv.setReleaseDate(null);
                    }
                ),

                if(padding != null)
                  SizedBox(width: padding!.right)

              ],
            ),

            if(currItemProv.releaseDate != null)
              Row(
                children: [

                  if(padding != null)
                    SizedBox(width: padding!.left),

                  SimpleButton.from(
                      color: cardEnab_(context),
                      textColor: currItemProv.showRelDateDay && currItemProv.showRelDateMonth?iconEnab_(context):iconDisab_(context),
                      dense: true,
                      margin: EdgeInsets.zero,
                      icon: MdiIcons.calendarOutline,
                      text: 'Pok. dzień',
                      onTap: currItemProv.showRelDateMonth?() => currItemProv.setShowRelDateDay(!currItemProv.showRelDateDay) : null
                  ),

                  SizedBox(width: Dimen.defMarg),

                  SimpleButton.from(
                      color: cardEnab_(context),
                      textColor: currItemProv.showRelDateMonth?iconEnab_(context):iconDisab_(context),
                      dense: true,
                      margin: EdgeInsets.zero,
                      icon: MdiIcons.calendarMonthOutline,
                      text: 'Pok. miesiąc',
                      onTap: () => currItemProv.setShowRelDateMonth(!currItemProv.showRelDateMonth)
                  ),

                  if(padding != null)
                    SizedBox(width: padding!.right)

                ],
              )

          ],
        ),
      )
  );

}
