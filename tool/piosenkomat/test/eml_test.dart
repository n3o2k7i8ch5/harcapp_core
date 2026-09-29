import 'dart:convert';

import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/eml.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:test/test.dart';

/// Mejl złożony z bajtów: nagłówki ASCII, treść w dowolnym kodowaniu.
List<int> _mail(String headers, List<int> body) =>
    [...ascii.encode('${headers.replaceAll('\n', '\r\n')}\r\n\r\n'), ...body];

const _iso88592Zazolc = [0x5a, 0x61, 0xbf, 0xf3, 0xb3, 0xe6, 0x20, 0xb1, 0xea, 0xb6, 0xbc, 0xf1];
const _cp1250Zazolc = [0x5a, 0x61, 0xbf, 0xf3, 0xb3, 0xe6, 0x20, 0xb9, 0xea, 0x9c, 0x9f, 0xf1];

void main() {
  group('kodowanie treści: mejl to bajty, nie UTF-8', () {
    test('ISO-8859-2 z polskimi literami', () {
      final m = ContribMessage.fromEmlBytes(
          _mail('Subject: x\nContent-Type: text/plain; charset=ISO-8859-2', _iso88592Zazolc),
          id: 'a');
      expect(m.body, 'Zażółć ąęśźń');
    });

    test('windows-1250 — inne bajty tych samych liter', () {
      final m = ContribMessage.fromEmlBytes(
          _mail('Subject: x\nContent-Type: text/plain; charset="windows-1250"', _cp1250Zazolc),
          id: 'a');
      expect(m.body, 'Zażółć ąęśźń');
    });

    test('quoted-printable w latin2', () {
      final m = ContribMessage.fromEmlBytes(
          _mail('Subject: x\nContent-Type: text/plain; charset=iso-8859-2\n'
              'Content-Transfer-Encoding: quoted-printable', ascii.encode('Za=BF=F3=B3=E6')),
          id: 'a');
      expect(m.body, 'Zażółć');
    });

    test('bajty nie w UTF-8 z nagłówkiem UTF-8 nie wywracają przebiegu', () {
      final m = ContribMessage.fromEmlBytes(
          _mail('Subject: x\nContent-Type: text/plain; charset=utf-8', _iso88592Zazolc),
          id: 'a');
      expect(m.body, startsWith('Za'));
      expect(m.body, contains('�'), reason: 'zły bajt to znak zastępczy, nie wyjątek');
    });

    test('bez charsetu: UTF-8, a gdy to nie UTF-8 — windows-1250', () {
      expect(decodeCharset(utf8.encode('żółw'), null), 'żółw');
      expect(decodeCharset(_cp1250Zazolc, null), 'Zażółć ąęśźń');
      expect(decodeCharset(utf8.encode('żółw'), 'us-ascii'), 'żółw',
          reason: 'klienty doklejają ASCII do tekstu w UTF-8');
    });
  });

  group('nagłówki RFC 2047', () {
    test('temat w base64 i quoted-printable', () {
      expect(decodeHeaderValue('=?UTF-8?B?${base64.encode(utf8.encode('Poprawka piosenki'))}?='),
          'Poprawka piosenki');
      expect(decodeHeaderValue('=?ISO-8859-2?Q?Nowa_piosenka_=22Za=BF=F3=B3=E6=22?='),
          'Nowa piosenka "Zażółć"');
    });

    test('dwa słowa zakodowane obok siebie sklejają się bez spacji', () {
      expect(decodeHeaderValue('=?UTF-8?Q?Za=C5=BC?= =?UTF-8?Q?=C3=B3=C5=82=C4=87?='), 'Zażółć');
    });

    test('goły UTF-8 w nagłówku', () {
      final m = ContribMessage.fromEmlBytes(
          utf8.encode('From: Łukasz <l@x.pl>\r\nSubject: Żółw\r\n\r\ntreść'),
          id: 'a');
      expect(m.subject, 'Żółw');
      expect(m.from, 'Łukasz <l@x.pl>');
    });
  });

  group('części MIME', () {
    String multipart(String inner) => 'Subject: x\n'
        'Content-Type: multipart/mixed; boundary="b1"\n\n'
        '--b1\n$inner\n--b1--\n';

    test('załącznik z zagnieżdżonej części: płaska pętla by go zgubiła', () {
      final raw = multipart('Content-Type: multipart/alternative; boundary="b2"\n\n'
          '--b2\nContent-Type: text/plain; charset=UTF-8\n\ntreść\n'
          '--b2\nContent-Type: text/html\n\n<p>treść</p>\n--b2--\n'
          '--b1\nContent-Type: application/octet-stream; name="$kSubmissionFileName"\n'
          'Content-Disposition: attachment; filename="$kSubmissionFileName"\n'
          'Content-Transfer-Encoding: base64\n\n${base64.encode(utf8.encode('{"a":1}'))}');
      final mail = RawMail.parse(utf8.encode(raw));
      expect(mail.plainText.trim(), 'treść');
      expect(mail.attachment('.$kSubmissionFileExtension'), '{"a":1}');
    });

    test('rozszerzenia się nie mylą, wielkość liter bez znaczenia', () {
      final raw = multipart('Content-Type: application/octet-stream\n'
          'Content-Disposition: attachment; filename="SONG_BARKA.HRCPSNG"\n\n{}');
      final mail = RawMail.parse(utf8.encode(raw));
      expect(mail.attachment('.hrcpsng'), isNotNull);
      expect(mail.attachment('.$kSubmissionFileExtension'), isNull,
          reason: '`.hrcpsng` nie kończy się na `.hrcpsngsbm`');
    });

    test('mejl bez nagłówków to sama treść', () {
      expect(RawMail.parse(utf8.encode('Cześć, mam pytanie')).plainText, 'Cześć, mam pytanie');
    });
  });

  test('mejl, którego nie dało się rozebrać, idzie jako zgłoszenie „nie do odczytania”', () {
    const m = ContribMessage(id: 'a', body: '', readError: 'zepsuty');
    expect(m.isSongSubmission, isTrue,
        reason: 'przyszedł z kolejki — bez etykiety wracałby przy każdym scan');
    expect(classify(m, book: SongBook.empty).destination, Destination.rejectUnparsable);
  });
}
