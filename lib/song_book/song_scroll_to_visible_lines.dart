import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harcapp_core/song_book/song_core.dart';

// Line index counts both lines with text and the divider lines.
double songScrollToVisibleBottomLineIdx(
    BuildContext context,
    SongCore song,
    double textAreaHeight,
    double textTopPadding,
    ScrollController innerController,
){

  BuildContext rootContext = Navigator.of(context, rootNavigator: true).context;
  double statusBarHeight = MediaQuery.of(rootContext).padding.top;
  
  double lineHeight = textAreaHeight / song.lineNumList.length;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - kBottomNavigationBarHeight - statusBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopPadding - innerController.offset - statusBarHeight;

  double textBottomVisY = min(songBookAvailHeight - textTopY, textAreaHeight);

  return textBottomVisY / lineHeight;

  // int bottomVisibleIdx = max(0, (textBottomVisY / lineHeight).floor() - 1);
  //
  // int bottomVisibleLine = song.lineNumList[bottomVisibleIdx];
  //
  // return bottomVisibleLine;
}

// Line num skips the divider lines when counting.
(int, int) songScrollToVisibleLineNums(
  BuildContext context,
  SongCore song,
  double textAreaHeight,
  double textTopPadding,
  double statusBarHeight,
  double chordBarHeight,
  ScrollController innerController,
  ScrollController outerController
){

  double lineHeight = textAreaHeight / song.lineNumList.length;

  double appBarHeight = kToolbarHeight - outerController.offset;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - kBottomNavigationBarHeight - statusBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopPadding - innerController.offset - statusBarHeight;

  double textHiddenHeight = min(
      textAreaHeight,
      max(0, -textTopY + appBarHeight + chordBarHeight)
  );

  double textBottomVisY = min(songBookAvailHeight - textTopY, textAreaHeight);

  int bottomVisibleIdx = max(0, (textBottomVisY / lineHeight).floor() - 1);
  int topVisibleIdx = min(
      bottomVisibleIdx, (textHiddenHeight / lineHeight).ceil());

  int topVisibleLine = song.lineNumList[topVisibleIdx];
  int bottomVisibleLine = song.lineNumList[bottomVisibleIdx];

  return (topVisibleLine, bottomVisibleLine);
}