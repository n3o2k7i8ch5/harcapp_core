import 'dart:math';

import 'package:flutter/material.dart';

class CommonColorData{

  static const String defColorsKey = goldKey;

  static const String chocolateKey = 'chocolate';
  static const String raspberryKey = 'raspberry';
  static const String dawnKey = 'dawn';
  static const String rosegoldKey = 'rosegold';
  static const String goldKey = 'gold';
  static const String mintKey = 'mint';
  static const String greenKey = 'green';
  static const String turquoiseKey = 'turquoise';
  static const String blueberryKey = 'blueberry';
  static const String deepblueKey = 'deepblue';
  static const String darkorangeKey = 'darkorange';
  static const String darkgreenKey = 'darkgreen';
  static const String darkblueKey = 'darkblue';
  static const String darkpurpleKey = 'darkpurple';
  static const String darkbrownKey = 'darkbrown';
  static const String bloodKey = 'blood';
  static const String deepforestKey = 'deepforest';
  static const String navyKey = 'navy';
  static const String blackberryKey = 'blackberry';
  static const String blackwoodKey = 'blackwood';

  static String get randomKey => allPickable.keys.toList()[Random().nextInt(allPickable.length)];

  /// Built-in palette presets shipped with core. App-specific palettes (e.g.
  /// the songbook's `omega_album` or apel-ewan's folder colors) are added via
  /// [register].
  static final Map<String, CommonColorData> _corePickable = {

    chocolateKey: CommonColorData(Colors.pink, Colors.brown[700]!, Colors.white),
    raspberryKey: CommonColorData(Colors.red[800]!, Colors.deepPurple, Colors.black),
    dawnKey: const CommonColorData(Colors.orange, Colors.purple, Colors.black),
    rosegoldKey: const CommonColorData(Colors.amberAccent, Colors.pinkAccent, Colors.black),
    goldKey: const CommonColorData(Colors.yellow, Colors.orange, Colors.black),

    mintKey: const CommonColorData(Colors.yellow, Colors.greenAccent, Colors.black),
    greenKey: const CommonColorData(Colors.lightGreenAccent, Colors.lightBlueAccent, Colors.black),
    turquoiseKey: const CommonColorData(Colors.greenAccent, Colors.blue, Colors.black),
    blueberryKey: CommonColorData(Colors.cyan[800]!, Colors.purple[900]!, Colors.white),
    deepblueKey: const CommonColorData(Colors.blue, Colors.deepPurple, Colors.white),

    darkorangeKey: const CommonColorData(Colors.pinkAccent, Colors.blueGrey, Colors.black),
    darkgreenKey: CommonColorData(Colors.cyan[300]!, Colors.blueGrey, Colors.black),
    darkblueKey: const CommonColorData(Colors.blueAccent, Colors.blueGrey, Colors.black),
    darkpurpleKey: const CommonColorData(Colors.deepPurple, Colors.blueGrey, Colors.white),
    darkbrownKey: const CommonColorData(Colors.brown, Colors.blueGrey, Colors.white),

    bloodKey: CommonColorData(Colors.red[900]!, Colors.grey[800]!, Colors.white),
    deepforestKey: CommonColorData(Colors.green[900]!, Colors.grey[800]!, Colors.white),
    navyKey: CommonColorData(Colors.blue[900]!, Colors.grey[800]!, Colors.white),
    blackberryKey: CommonColorData(Colors.purple[900]!, Colors.grey[800]!, Colors.white),
    blackwoodKey: CommonColorData(Colors.brown[800]!, Colors.grey[800]!, Colors.white),
  };

  static final Map<String, CommonColorData> _registered = {};

  static Map<String, CommonColorData>? _cachedAllPickable;
  static Map<String, CommonColorData>? _cachedAll;

  /// Add an app-specific palette under [key]. Re-registering replaces the
  /// previous value. Call this during app startup before anything looks the
  /// key up via [get].
  static void register(String key, CommonColorData data){
    _registered[key] = data;
    _cachedAllPickable = null;
    _cachedAll = null;
  }

  static Map<String, CommonColorData> get allPickable =>
      _cachedAllPickable ??= {..._corePickable, ..._registered};

  static Map<String, CommonColorData> get all =>
      _cachedAll ??= {
        ...allPickable,
        'white': const CommonColorData(Colors.white, Colors.white, Colors.black),
        'black': const CommonColorData(
            Color.fromARGB(255, 30, 30, 30),
            Color.fromARGB(255, 30, 30, 30),
            Colors.white),
      };

  static CommonColorData get(String key, {String defKey = defColorsKey}) =>
      all[key]??all[defKey]??all[defColorsKey]!;

  final Color colorStart;
  final Color colorEnd;
  final Color iconColor;
  Color moreVisible(bool isDark) => isDark?colorStart:colorEnd;

  Color get avgColor => Color.from(
    alpha: 1.0,
    red: (colorStart.r + colorEnd.r)/2,
    green: (colorStart.g + colorEnd.g)/2,
    blue: (colorStart.b + colorEnd.b)/2,
  );

  const CommonColorData(this.colorStart, this.colorEnd, this.iconColor);

}
