import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/animated_child_slider.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_scaffold.dart';
import 'package:harcapp_core/comm_widgets/chord_shifter.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/comm_widgets/text_field_fit.dart';
import 'package:harcapp_core/comm_widgets/text_field_fit_chords.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../common.dart';
import '../../song_raw.dart';
import 'errors.dart';
import '../../providers.dart';
import 'providers.dart';

const double TEXT_FIELD_TOP_PADD = Dimen.TEXT_FIELD_PADD - 9;

class SongPartEditorTemplate extends StatefulWidget{

  //final SongPart songPart;
  final String? initText;
  final String? initChord;
  final bool? initShifted;
  final bool isRefren;

  final void Function(String, int)? onTextChanged;
  final void Function(String, int)? onChordsChanged;
  final void Function(bool)? onShiftedChanged;

  final Widget Function(BuildContext, SongPartEditorTemplateState)? topBuilder;
  final Widget Function(BuildContext, SongPartEditorTemplateState)? bottomBuilder;

  final double elevation;

  const SongPartEditorTemplate(
      {this.initText,
        this.initChord,
        this.initShifted,

        required this.isRefren,

        this.onTextChanged,
        this.onChordsChanged,
        this.onShiftedChanged,

        this.topBuilder,
        this.bottomBuilder,

        this.elevation = AppCard.bigElevation,

        Key? key
      }):super(key: key);

  @override
  State<StatefulWidget> createState() => SongPartEditorTemplateState();
}


class SongPartEditorTemplateState extends State<SongPartEditorTemplate>{

  String? get initText => widget.initText;
  String? get initChord => widget.initChord;
  bool? get initShifted => widget.initShifted;

  bool get isRefren => widget.isRefren;

  void Function(String, int)? get onTextChanged => widget.onTextChanged;
  void Function(String, int)? get onChordsChanged => widget.onChordsChanged;
  void Function(bool)? get onShiftedChanged => widget.onShiftedChanged;

  //late bool showErrBar;

  late LinkedScrollControllerGroup _controllers;
  late ScrollController textScrollController;
  late ScrollController chordsScrollController;

  late TextEditingController textController;
  late TextEditingController chordsController;

  @override
  void initState() {

    _controllers = LinkedScrollControllerGroup();
    textScrollController = _controllers.addAndGet();
    chordsScrollController = _controllers.addAndGet();

    textController = TextEditingController(text: initText);
    chordsController = TextEditingController(text: initChord);

    super.initState();
  }

  @override
  void dispose() {
    textScrollController.dispose();
    chordsScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    backgroundColor: Colors.transparent,
    body: AppCard(
        radius: AppCard.bigRadius,
        elevation: widget.elevation,
        padding: EdgeInsets.zero,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => TextProvider(text: initText??'')),
            ChangeNotifierProvider(create: (context) => ChordsProvider(chords: initChord??'')),
            ChangeNotifierProvider(create: (context) => TextShiftProvider(shifted: initShifted??isRefren, onChanged: onShiftedChanged)),
            ChangeNotifierProvider(create: (context) => ErrorProvider<ChordsMissingError>(init: (errProv) => ChordsMissingError.handleNotifyErrors(context, errProv))),
            ChangeNotifierProvider(create: (context) => ErrorProvider<TextTooLongError>(init: (errProv) => TextTooLongError.handleNotifyErrors(context, errProv))),
          ],
          builder: (context, _) => Column(
            children: [

              if(widget.topBuilder!=null) widget.topBuilder!(context, this),

              Expanded(
                  child: LayoutBuilder(
                    builder: (context, boxConstraints) => Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Expanded(
                            child: SongTextWidget(
                                isRefren: isRefren,
                                scrollController: textScrollController,
                                onChanged: (text, errCount) => onTextChanged?.call(text, errCount)
                            )
                        ),

                        SongChordsWidget(
                            isRefren: isRefren,
                            scrollController: chordsScrollController,
                            onChanged: (text, errCount) => onChordsChanged?.call(text, errCount)
                        )

                      ],
                    ),
                  )
              ),

              if(widget.bottomBuilder!=null) widget.bottomBuilder!(context, this),

            ],
          ),
        )
    ),
  );

}

class SongTextWidget extends StatefulWidget{

  static const double height = 1.2;
  static const double fontSize = Dimen.textSizeNormal;
  
  final bool isRefren;
  final ScrollController scrollController;
  final void Function(String, int)? onChanged;

  const SongTextWidget({
    required this.isRefren,
    required this.scrollController,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _SongTextWidgetState();

}

class _SongTextWidgetState extends State<SongTextWidget>{

  bool get isRefren => widget.isRefren;
  ScrollController get scrollController => widget.scrollController;
  late TextEditingController textController;
  late TextEditingController chordsController;

  late FocusNode focusNode;

  void onChanged(){
    TextProvider.notify_(context);
    int errorCount = 0;
    errorCount += TextTooLongError.handleNotifyErrorsFrom(context);
    errorCount += ChordsMissingError.handleNotifyErrorsFrom(context);
    widget.onChanged?.call(textController.text, errorCount);
    
  }

  @override
  void initState() {

    textController = TextProvider.of(context).controller;
    chordsController = ChordsProvider.of(context).controller;

    focusNode = FocusNode();
    focusNode.addListener(() {
      if(focusNode.hasFocus)
        return;

      if(!mounted)
        return;

      textController.text = SongRaw.correctPartText(textController.text);
    });

    textController.addListener(onChanged);
    super.initState();
  }

  @override
  void dispose() {
    textController.removeListener(onChanged);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).requestFocus(focusNode),
    child: AppCard(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppCard.bigRadius),
        bottomLeft: Radius.circular(AppCard.bigRadius),
      ),
      padding: EdgeInsets.only(left: Dimen.defMarg/2, right: 1, bottom: Dimen.defMarg/2),
      margin: AppCard.normMargin,
      elevation: 0,
      color: background_(context),
      child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          child: Consumer<TextShiftProvider>(
            builder: (context, provider, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutQuad,
                    width: provider.shifted?Dimen.iconSize + Dimen.iconMarg:0
                ),
                Expanded(child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: TextFieldFit(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: SongTextWidget.fontSize,
                          color: textEnab_(context),
                          height: SongTextWidget.height,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Słowa ${isRefren?'refrenu':'zwrotki'}',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: SongTextWidget.fontSize,
                              color: hintEnab_(context),
                              height: SongTextWidget.height,
                            ),
                            border: InputBorder.none,
                            isDense: true
                        ),
                        minLines: chordsController.text.split('\n').length,
                        maxLines: null,
                        focusNode: focusNode,
                        autofocus: false,
                        minWidth: Dimen.iconFootprint*2,
                        inputFormatters: [FilteringTextInputFormatter.allow(allowedSongTextRegexp)],
                        controller: textController,
                    )
                )),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    LineCountWidget(),
                    TextLengthWarning(),
                  ],
                )

              ],
            ),
          )
      ),
    ),
  );

}

class SongChordsWidget extends StatefulWidget{

  final bool isRefren;
  final ScrollController scrollController;
  final void Function(String, int)? onChanged;

  SongChordsWidget({
    required this.isRefren,
    required this.scrollController,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _SongChordsWidgetState();

}

class _SongChordsWidgetState extends State<SongChordsWidget>{

  bool get isRefren => widget.isRefren;
  ScrollController get scrollController => widget.scrollController;
  late TextEditingController textController;
  late TextEditingController chordsController;
  void Function(String, int)? get onChanged => widget.onChanged;

  void _onChanged(){
    int errorCount = 0;
    errorCount += TextTooLongError.handleNotifyErrorsFrom(context);
    errorCount += ChordsMissingError.handleNotifyErrorsFrom(context);
    onChanged?.call(chordsController.text, errorCount);
  }

  late FocusNode focusNode;

  @override
  void initState() {

    textController = TextProvider.of(context).controller;
    chordsController = ChordsProvider.of(context).controller;

    focusNode = FocusNode();
    focusNode.addListener(() {
      if(focusNode.hasFocus)
        return;

      if(!mounted)
        return;

      chordsController.text = SongRaw.correctPartChords(chordsController.text);
    });

    chordsController.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    chordsController.removeListener(_onChanged);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).requestFocus(focusNode),
    child: AppCard(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppCard.bigRadius),
        bottomRight: Radius.circular(AppCard.bigRadius),
      ),
      padding: EdgeInsets.only(left: Dimen.defMarg/2, right: Dimen.defMarg/2, bottom: Dimen.defMarg/2),
      margin: AppCard.normMargin,
      elevation: 0,
      color: background_(context),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        child: Stack(
          clipBehavior: Clip.none,
          children: [

            Positioned(
                top: TEXT_FIELD_TOP_PADD,
                right: 0,
                left: 0,
                child: ChordPresenceWarning()
            ),

            TextFieldFitChords(
                focusNode: focusNode,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: SongTextWidget.fontSize,
                  color: textEnab_(context),
                  height: SongTextWidget.height,
                ),
                decoration: InputDecoration(
                    hintText: 'Chwyty ${isRefren?'ref.':'zwr.'}',
                    hintStyle: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: SongTextWidget.fontSize,
                      color: hintEnab_(context),
                      height: SongTextWidget.height,
                    ),
                    border: InputBorder.none,
                    isDense: true
                ),
                minLines: textController.text.split('\n').length,
                maxLines: null,
                minWidth: CHORDS_WIDGET_MIN_WIDTH,
                controller: chordsController
            ),
          ],
        ),
      ),
    ),
  );

}

class ButtonsWidget extends StatelessWidget{

  final void Function()? onCheckPressed;
  final void Function(String, int)? onChordsChanged;
  final void Function()? onAlertTap;

  final bool isRefren;

  const ButtonsWidget({required this.isRefren, this.onCheckPressed, this.onChordsChanged, this.onAlertTap});

  @override
  Widget build(BuildContext context) => Row(
    children: [

      IconButton(
          icon: Icon(MdiIcons.check),
          onPressed: onCheckPressed
      ),

      isRefren?
      Padding(
        padding: EdgeInsets.all(Dimen.iconMarg),
        child: Icon(
            MdiIcons.rayStartArrow,
            color: iconDisab_(context)
        ),
      ) :
      Consumer<TextShiftProvider>(
          builder: (context, provider, child) => IconButton(
            icon: AnimatedChildSlider(
              reverse: provider.shifted,
              direction: Axis.horizontal,
              index: provider.shifted?1:0,
              children: [
                Icon(
                    MdiIcons.circleMedium,
                    color: iconEnab_(context)
                ),
                Icon(
                    MdiIcons.rayStartArrow,
                    color: iconEnab_(context)
                )
              ],
            ),
            onPressed: isRefren?null:(){
              TextShiftProvider.of(context).reverseShift();
            },
          )
      ),

      Expanded(child: AnyError(
          builder: (context, errCont) => AnimatedOpacity(
            opacity: errCont==0?0:1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            child: SimpleButton(
              onTap: errCont==0?null:onAlertTap,
              padding: EdgeInsets.all(Dimen.iconMarg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(MdiIcons.alertCircleOutline, color: Colors.red),
                  SizedBox(width: Dimen.iconMarg),
                  Text('$errCont', style: AppTextStyle(fontWeight: weightHalfBold, color: Colors.red),)
                ],
              ),
            ),
          )
      )),

      IconButton(
        icon: Icon(MdiIcons.chevronDoubleDown),
        onPressed: (){

          ChordsProvider provider = ChordsProvider.of(context);

          ChordShifter cs = ChordShifter(provider.chords, 0);
          cs.down();

          String chords = cs.getText(true);
          provider.controller.text = chords;
          provider.chords = chords;

          provider.controller.selection = TextSelection.collapsed(offset: provider.chords.length);
        },
      ),

      IconButton(
        icon: Icon(MdiIcons.chevronDoubleUp),
        onPressed: (){

          ChordsProvider provider = ChordsProvider.of(context);

          ChordShifter cs = ChordShifter(provider.chords, 0);
          cs.up();

          String chords = cs.getText(true);
          provider.controller.text = chords;
          provider.chords = chords;

          provider.controller.selection = TextSelection.collapsed(offset: provider.chords.length);
          //parent.onTextChanged?.call(chords, handleErrors(context, isRefren));
        },
      ),
    ],
  );

}

class ChordPresenceWarning extends StatelessWidget{

  const ChordPresenceWarning();

  @override
  Widget build(BuildContext context) => Consumer<ErrorProvider<ChordsMissingError>>(
    builder: (context, provider, child){

      List<Widget> lineWidgets = [];

      int lines = TextProvider.of(context).text.split('\n').length;
      for(int i=0; i<lines; i++){
        ChordsMissingError? error = provider.errorAt(i);
        lineWidgets.add(
            WarningShade(
                error==null?
                background_(context).withValues(alpha: 0):
                error.color
            )
        );
      }

      return Column(
          mainAxisSize: MainAxisSize.min,
          children: lineWidgets
      );

    },
  );

}

class WarningShade extends StatelessWidget{

  final Color color;
  const WarningShade(this.color);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: SongTextWidget.fontSize * SongTextWidget.height,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5),
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4)
        ),
        duration: Duration(milliseconds: 500),
      ),
    ),
  );


}

class TextLengthWarning extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: TEXT_FIELD_TOP_PADD),
      child: Consumer<ErrorProvider<TextTooLongError>>(builder: (context, provider, child) {

        List<Widget> lineWidgets = [];

        int lines = TextProvider.of(context).text.split('\n').length;
        for(int i=0; i<lines; i++){
          TextTooLongError? error = provider.errorAt(i);
          lineWidgets.add(
              WarningShade(
                  error==null?
                  background_(context).withValues(alpha: 0):
                  error.color
              )
          );
        }

        return Padding(
          padding: EdgeInsets.only(left: 3),
          child: SizedBox(
            width: Dimen.iconMarg+2,
            child: Column(children: lineWidgets),
          ),
        );

      })
  );

}

class LineCountWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: TEXT_FIELD_TOP_PADD),
      child: Consumer2<TextProvider, ChordsProvider>(
          builder: (context, textProv, chordsProv, child) {
            int textLines = textProv.text.split('\n').length;
            int chordsLines = chordsProv.chords.split('\n').length;

            int lines = max(textLines, chordsLines);
            String text = '';
            for (int i = 0; i < lines; i++)
              text += '${i + 1}\n';

            if (text.length > 0)
              text = text.substring(0, text.length - 1);

            return Text(
              text,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: Dimen.textSizeTiny, //initial font size
                  color: hintEnab_(context),
                  height: SongTextWidget.fontSize * SongTextWidget.height /
                      Dimen.textSizeTiny
              ),
            );
          }
      )
  );

}