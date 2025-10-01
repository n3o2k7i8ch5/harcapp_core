import 'dart:math';

import 'package:flutter/material.dart';
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

  double innerScrollControllerOffset;
  if(innerController.positions.length == 1)
    innerScrollControllerOffset = innerController.offset;
  else
    // The inner page view is transitioning from one page to another.
    innerScrollControllerOffset = innerController.positions.last.pixels;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - screenTopPadding - screenBottomPadding - kBottomNavigationBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = screenTopPadding + appBarHeight + textTopOffset - innerScrollControllerOffset;

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
      innerScrollControllerOffset - (textTopOffset - chordBarHeight)
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

  return (topVisibleLine, bottomVisibleLine);
}