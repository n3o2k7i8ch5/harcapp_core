import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harcapp_core/song_book/song_core.dart';

(int, int)? songScrollToVisibleLines(
  BuildContext context,
  SongCore song,
  ScrollNotification scrollInfo,
  double textAreaHeight,
  double textTopPadding,
  double statusBarHeight,
  double chordBarHeight,
  ScrollController outerController
){

  if(!(scrollInfo is ScrollEndNotification))
    return null;

  double lineHeight = textAreaHeight / song.lineNumList.length;

  double appBarHeight = kToolbarHeight - outerController.offset;

  // distance between the screen top and the screen bottom available for the song book module.
  double songBookAvailHeight = MediaQuery
      .of(context)
      .size
      .height - kBottomNavigationBarHeight - statusBarHeight;

  // distance between the screen top and the top of the song text area.
  double textTopY = textTopPadding - scrollInfo.metrics.pixels - statusBarHeight;

  double textHiddenHeight = min(
      textAreaHeight, max(0, -textTopY + appBarHeight + chordBarHeight)
  );

  double textBottomVisY = min(songBookAvailHeight - textTopY, textAreaHeight);

  int bottomVisibleIdx = max(0, (textBottomVisY / lineHeight).floor() - 1);
  int topVisibleIdx = min(
      bottomVisibleIdx, (textHiddenHeight / lineHeight).ceil());

  int topVisibleLine = song.lineNumList[topVisibleIdx];
  int bottomVisibleLine = song.lineNumList[bottomVisibleIdx];

  return (topVisibleLine, bottomVisibleLine);
}