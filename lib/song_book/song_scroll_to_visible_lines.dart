import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/dialog/dialog.dart';
import 'package:harcapp_core/song_book/song_core.dart';
import 'package:harcapp_core/song_book/widgets/song_widget_template.dart';

// Line index counts both lines with text and the divider lines.
double songScrollToVisibleBottomLineIdx(
    BuildContext context,
    SongCore song,
    double textWidgetHeight,
    double textTopOffset,
    ScrollController innerController,
){
  BuildContext rootContext = Navigator.of(context, rootNavigator: true).context;
  double screenTopPadding = MediaQuery.of(rootContext).padding.top;
  double screenBottomPadding = MediaQuery.of(rootContext).padding.bottom;

  double lineHeight = textWidgetHeight / song.lineCount;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - screenTopPadding - screenBottomPadding - kBottomNavigationBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopOffset - innerController.offset;

  double textBottomVisY = min(
    textTopY + textWidgetHeight,
    screenTopPadding + songBookAvailHeight,
  );

  return max(0, ((textBottomVisY - textTopY) / lineHeight) - 1);

}

// Line num skips the divider lines when counting.
(int, int) songScrollToVisibleLineNums(
    BuildContext context,
    SongCore song,
    double textWidgetHeight,
    double textTopOffset,
    double chordBarHeight,
    ScrollController innerController,
    ScrollController outerController
){
  double screenTopPadding = SongWidgetTemplateState.screenTopPadding(context);
  double screenBottomPadding = SongWidgetTemplateState.screenBottomPadding(context);

  double lineHeight = textWidgetHeight / song.lineCount;

  double appBarHeight = kToolbarHeight - outerController.offset;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - screenTopPadding - screenBottomPadding - kBottomNavigationBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = screenTopPadding + textTopOffset - innerController.offset;

  // For visualizing
  double textTopVisY = max(
      textTopY,
      screenTopPadding + appBarHeight + chordBarHeight
  );

  double textBottomVisY = min(
    textTopY + textWidgetHeight,
    screenTopPadding + songBookAvailHeight,
  );

  double textHiddenAboveHeight = max(
      0,
      innerController.offset - (textTopOffset - screenTopPadding - appBarHeight - chordBarHeight)
  );

  int bottomVisibleIdx;
  // This 'if' mechanism solves machine epsilon issues with selecting the last index;
  if(textBottomVisY < screenTopPadding + songBookAvailHeight)
    bottomVisibleIdx = song.lineNumList.length-1;
  else
    bottomVisibleIdx = max(0, ((textBottomVisY - textTopY) / lineHeight).floor() - 1);

  int topVisibleIdx = min(
      bottomVisibleIdx,
      (textHiddenAboveHeight / lineHeight).ceil()
  );

  int topVisibleLine = song.lineNumList[topVisibleIdx];
  int bottomVisibleLine = song.lineNumList[bottomVisibleIdx];

  openDialog(context: context, builder: (context) => Stack(children: [

    Positioned(
        top: screenTopPadding,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: .3,
          child: Container(
            width: double.infinity,
            height: songBookAvailHeight,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                width: double.infinity,
                height: songBookAvailHeight,
                color: Colors.green,
              ),
            ),
          ),
        )
    ),

    Positioned(
        top: textTopVisY,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          height: 3,
          color: Colors.orange,
        )
    ),

    Positioned(
        top: textTopVisY - textHiddenAboveHeight,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: 0.5,
          child: Container(
            width: double.infinity,
            height: textHiddenAboveHeight,
            color: Colors.orange,
          ),
        )
    ),

    Positioned(
        top: textBottomVisY,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          height: 3,
          color: Colors.amber,
        )
    ),

    Positioned(
        top: textTopY,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: .3,
          child: Builder(
            builder: (context){

              List<Widget> children = [];

              for(int i=0; i<song.lineNumList.length; i++)
                children.add(
                    Container(
                      width: double.infinity,
                      height: lineHeight,
                      color: i%2==0?Colors.pink:Colors.pink[900],
                      child: i==topVisibleIdx?Material(
                          color: Colors.black,
                          child: Text("Top visible", style: TextStyle(fontSize: lineHeight-2))
                      ):
                      i==bottomVisibleIdx?
                      Material(
                          color: Colors.black,
                          child: Text("Bottom visible", style: TextStyle(fontSize: lineHeight-2))
                      ):
                      null,
                    )
                );

              return Column(children: children);

            },
          ),
        )
    ),

  ]));

  return (topVisibleLine, bottomVisibleLine);
}