import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double CHORDS_WIDGET_MIN_WIDTH = 80.0;

Color COLOR_OK = Colors.green.withOpacity(0.5);
Color COLOR_WAR = Colors.red.withOpacity(0.3);
Color COLOR_ERR = Colors.red.withOpacity(0.7);

TextInputFormatter ALLOWED_TEXT_REGEXP = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9ĄąĆćĘęŁłŃńÓóŚśŹźŻż \(\)\-\.\,\'\!\?\n]"));

