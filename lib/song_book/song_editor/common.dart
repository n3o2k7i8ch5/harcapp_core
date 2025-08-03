import 'package:flutter/material.dart';

const double CHORDS_WIDGET_MIN_WIDTH = 80.0;

Color COLOR_OK = Colors.green.withValues(alpha: 0.5);
Color COLOR_WAR = Colors.red.withValues(alpha: 0.3);
Color COLOR_ERR = Colors.red.withValues(alpha: 0.7);

RegExp allowedSongTextRegexp = RegExp(r"[a-zA-Z0-9ĄąÁáĆćĘęÉéĚěÍíŁłŃńŘřÓóŚśŠšÝýŹźŻżŽž \(\)\-\.\,\'\!\?\n]");

const String activeFormTrueText = 'Forma aktywna';
const String activeFormFalseText = 'Forma statyczna';
const Color activeFormTrueColor = Colors.green;
const Color activeFormFalseColor = Colors.deepOrange;