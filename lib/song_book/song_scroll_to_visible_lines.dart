import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/dialog/dialog.dart';
import 'package:harcapp_core/song_book/song_core.dart';

// Line index counts both lines with text and the divider lines.
double songScrollToVisibleBottomLineIdx(
    BuildContext context,
    SongCore song,
    double textWidgetHeight,
    double textTopPadding,
    ScrollController innerController,
){
  BuildContext rootContext = Navigator.of(context, rootNavigator: true).context;
  double statusBarHeight = MediaQuery.of(rootContext).padding.top;
  
  double lineHeight = textWidgetHeight / song.lineCount;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - kBottomNavigationBarHeight - statusBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopPadding - innerController.offset - statusBarHeight;

  double textBottomVisY = min(songBookAvailHeight - textTopY, textWidgetHeight);

  return (textBottomVisY / lineHeight) - 1;

}

// Line num skips the divider lines when counting.
(int, int) songScrollToVisibleLineNums(
  BuildContext context,
  SongCore song,
  double textWidgetHeight,
  double textTopPadding,
  double chordBarHeight,
  ScrollController innerController,
  ScrollController outerController
){
  BuildContext rootContext = Navigator.of(context, rootNavigator: true).context;
  double statusBarHeight = MediaQuery.of(rootContext).padding.top;

  double lineHeight = textWidgetHeight / song.lineCount;

  double appBarHeight = kToolbarHeight - outerController.offset;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - kBottomNavigationBarHeight - statusBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopPadding - innerController.offset - statusBarHeight;

  double textHiddenHeight = min(
      textWidgetHeight,
      max(0, -textTopY + appBarHeight + chordBarHeight)
  );

  double textBottomVisY = min(songBookAvailHeight - textTopY, textWidgetHeight);

  int bottomVisibleIdx = max(0, (textBottomVisY / lineHeight).floor() - 1);
  int topVisibleIdx = min(
      bottomVisibleIdx, (textHiddenHeight / lineHeight).ceil());

  int topVisibleLine = song.lineNumList[topVisibleIdx];
  int bottomVisibleLine = song.lineNumList[bottomVisibleIdx];

  openDialog(context: context, builder: (context) => Stack(children: [

    Positioned(
        bottom: kBottomNavigationBarHeight,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: .5,
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
        top: textTopY,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          height: 3,
          color: Colors.amber,
        )
    ),

    Positioned(
        top: textBottomVisY + textTopPadding - statusBarHeight - innerController.offset - 1,
        left: 0,
        right: 0,
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.amber,
        )
    ),

    Positioned(
        top: textTopY,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: .5,
          child: Builder(
            builder: (context){

              List<Widget> children = [];

              for(int i=0; i<song.lineNumList.length; i++)
                children.add(Container(
                  width: double.infinity,
                  height: lineHeight,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.pink,
                    ),
                  ),
                ));

              return Column(children: children);

            },
          ),
        )
    ),

  ]));


  return (topVisibleLine, bottomVisibleLine);
}