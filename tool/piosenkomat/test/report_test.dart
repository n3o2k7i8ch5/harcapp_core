import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/report.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  test('raport liczy nowe, poprawki, odrzuty i „rzuć okiem”', () async {
    final book = bookWith([sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')]);
    final report = formatRunReport(classifyBatch([
      msgFrom(await completeEmail(song: sampleSong(title: 'Czysta', lyrics: 'Zupelnie inne slowa')), id: 'ok'),
      msgFrom(await completeEmail(song: sampleSong(title: 'Bez YT', yt: null, lyrics: 'Wlazl kotek na plotek')), id: 'yt'),
      msgFrom(await completeEmail(isNew: false, song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale\nX')), id: 'corr'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale')), id: 'dup'),
      msgFrom(await completeEmail(song: sampleSong(title: 'W apce', lyrics: 'Ala ma kota\nA kot ma Ale'), userMessage: 'hej'), id: 'msg'),
      msgFrom('From: a@b.pl\nSubject: Cześć\n\nCześć, mam pytanie', id: 'raw'),
    ], book: book));
    expect(report, contains('ZGŁOSZEŃ        6'));
    expect(report, contains('  nie do odczytu 1'));
    expect(report, contains('NOWE            2'));
    expect(report, contains('  bez zarzutu   1'));
    expect(report, contains('  z uwagami     1'));
    expect(report, contains('POPRAWKI        1'));
    // `dup` i `msg` są sobie identyczne (dopisek to nie piosenka) i mają tę samą
    // datę: zostaje późniejsza w kolejce, wcześniejsza to duplikat.
    expect(report, contains('  już w apce    1'), reason: 'identyczna z dopiskiem też jest odrzutem');
    expect(report, contains('  duplikat      1'));
    expect(report, contains('RZUĆ OKIEM      2'), reason: 'identyczna z dopiskiem + nie do odczytania');
    expect(report, contains('missing-youtube'));
    expect(report, contains('Kształt mejla:'));
    expect(report, contains('fenced'));
    expect(report, contains('[ok]'));
    expect(report, contains('NIEPARS  Cześć'));
  });
}
