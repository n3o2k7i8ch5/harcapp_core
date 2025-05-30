import 'package:flutter/material.dart';

class Dimen{

  static const double defMarg = 6.0;
  static const double sideMarg = 18.0;
  static const double CARD_BIG_PADD = 16.0;
  static const double APPBAR_ELEVATION = 4.0;
  static const double APPBAR_TITLE_BOTTOM_PADDING_VAL = 16.0;

  static const double textSizeLimit = 8.0;
  static const double textSizeTiny = 10.0;
  static const double textSizeSmall = 12.0;
  static const double textSizeNormal = 14.0;
  static const double textSizeBig = 16.0;
  static const double textSizeAppBar = 20.0;

  static const double iconMarg = 12.0;
  static const double iconSize = 24.0;
  static const double iconSmallSize = 18.0;
  static const double iconFootprint = 2*iconMarg + iconSize;
  static const double iconEmptyInfoSize = 72.0;

  static const EdgeInsets toastPadding = EdgeInsets.only(
    top: 12.0,
    right: 12.0,
    left: 12.0,
    bottom: 46.0,
  );

  static const double APPBAR_LEADING_WIDTH = iconFootprint + 8.0;


  static const double TEXT_FIELD_PADD = 16;

  static const double LIST_TILE_SEPARATOR = 32;
  static const double LIST_TILE_LEADING_MARGIN_VAL = 16.0;
  static const double LIST_TILE_TRAILING_MARGIN_VAL = 15.0;

  static const double floatingButtonMarg = 16;
  static const double floatingButtonSize = 56;

  static const double BOTTOM_SHEET_TITLE_MARG = 20;
  static const double BOTTOM_SHEET_MARG = 16;

  static double viewportFraction(BuildContext context, {double margin = Dimen.sideMarg}) => 1 - (2*margin/MediaQuery.of(context).size.width);

  static const double SETTINGS_MARG = 38;

  static const double LIST_SIDE_MARG = 10;
  static const double LIST_SIDE_MARG_DENSE = 3;
  static const double LIST_SEP_MARG = 18;
  static const double LIST_SEP_MARG_DENSE = 6;
}