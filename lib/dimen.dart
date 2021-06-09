import 'package:flutter/cupertino.dart';

class Dimen{

  static const double TEXT_SIZE_APPBAR = 20;

  static const double DEF_MARG = 6;
  static const double SIDE_MARG = 18.0;
  static const double CARD_BIG_PADD = 16.0;
  static const double APPBAR_ELEVATION = 4.0;

  static const double TEXT_SIZE_LIMIT = 8;
  static const double TEXT_SIZE_TINY = 10;
  static const double TEXT_SIZE_SMALL = 12;
  static const double TEXT_SIZE_NORMAL = 14;
  static const double TEXT_SIZE_BIG = 16;

  static const double ICON_MARG = 12;
  static const double ICON_SIZE = 24;
  static const double ICON_FOOTPRINT = 2*ICON_MARG + ICON_SIZE;
  static const double ICON_EMPTY_INFO_SIZE = 72;

  static const double APPBAR_LEADING_WIDTH = ICON_FOOTPRINT + 8;


  static const double TEXT_FIELD_PADD = 16;

  static const double LIST_TILE_SEPARATOR = 32;

  static const double FLOATING_BUTTON_MARG = 16;
  static const double FLOATING_BUTTON_SIZE = 56;

  static const double BOTTOM_SHEET_TITLE_MARG = 20;
  static const double BOTTOM_SHEET_MARG = 16;

  static double viewportFraction(BuildContext context) => 1 - (2*Dimen.SIDE_MARG/MediaQuery.of(context).size.width);

  static const double SETTINGS_MARG = 38;

  static const double LIST_SIDE_MARG = 10;
  static const double LIST_SIDE_MARG_DENSE = 3;
  static const double LIST_SEP_MARG = 18;
  static const double LIST_SEP_MARG_DENSE = 6;
}