import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/song_book/parse_contrib_email.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';

/// Łamie linię jak klient pocztowy: w miejscu spacji, co najwyżej [width] znaków.
String _wrap(String line, int width) {
  final out = <String>[];
  var rest = line;
  while (rest.length > width) {
    final cut = rest.lastIndexOf(' ', width);
    out.add(rest.substring(0, cut));
    rest = rest.substring(cut + 1);
  }
  return [...out, rest].join('\r\n');
}

String _body(String top) => '$top\n\n$kSubmissionConsentBar\n\nZnam i akceptuję zasady.';

void main() {
  test('placeholder ma 76 znaków — klient z limitem 72 go łamie', () {
    expect(kSubmissionUserMessagePlaceholder.length, 76);
    expect(_wrap(kSubmissionUserMessagePlaceholder, 72), contains('\r\n'));
  });

  for (final width in [72, 60, 40]) {
    test('placeholder złamany na $width znakach to nie dopisek', () {
      final wrapped = _wrap(kSubmissionUserMessagePlaceholder, width);
      expect(extractSubmissionUserMessage(_body(wrapped)), isNull);
      expect(stripSubmissionTemplate(wrapped), isNull);
    });
  }

  test('złamany placeholder w cytacie (odpowiedź w wątku) też znika', () {
    final quoted = _wrap(kSubmissionUserMessagePlaceholder, 72)
        .split('\r\n')
        .map((l) => '> $l')
        .join('\n');
    expect(extractSubmissionUserMessage(_body(quoted)), isNull);
  });

  test('prawdziwy dopisek zostaje, placeholder obok znika', () {
    final top = 'Śpiewamy to na obozie.\n${_wrap(kSubmissionUserMessagePlaceholder, 72)}';
    expect(extractSubmissionUserMessage(_body(top)), 'Śpiewamy to na obozie.');
  });
}
