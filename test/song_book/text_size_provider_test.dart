import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/providers.dart';
import 'package:harcapp_core/values/dimen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const text = 'To jest bardzo dluga linia tekstu piosenki bez zadnego zlamania';
  const chords = 'a d e a d e a d e';
  const nums = '1';

  test('songTextStyle zeruje letterSpacing, zeby motyw M3 nie rozjechal chwytow', () {
    final style = TextSizeProvider.songTextStyle(18);
    expect(style.letterSpacing, 0);
    expect(style.wordSpacing, 0);
    expect(style.fontFamily, TextSizeProvider.songFontFamily);
    expect(style.height, TextSizeProvider.songLineHeight);
  });

  test('fits nie zmniejsza czcionki, gdy linia sie miesci', () {
    final scale = TextSizeProvider.fits(
      2000,
      TextScaler.noScaling,
      text,
      chords,
      nums,
      TextSizeProvider.defFontSize,
    );
    expect(scale, 1);
  });

  test('fits zmniejsza czcionke, gdy linia musialaby sie zlamac', () {
    const fontSize = TextSizeProvider.defFontSize;
    final scale = TextSizeProvider.fits(
      80,
      TextScaler.noScaling,
      text,
      chords,
      nums,
      fontSize,
    );
    expect(scale, lessThan(1));
    expect(scale * fontSize, greaterThanOrEqualTo(Dimen.textSizeLimit));

    final atFitted = TextSizeProvider.fits(
      80,
      TextScaler.noScaling,
      text,
      chords,
      nums,
      scale * fontSize,
    );
    expect(atFitted, 1);
  });
}
