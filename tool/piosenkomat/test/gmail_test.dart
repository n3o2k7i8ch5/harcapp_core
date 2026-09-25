import 'dart:async';
import 'dart:io';

import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart' as http;
import 'package:harcapp_core/song_book/submission/submission_file.dart';
import 'package:piosenkomat/gmail.dart';
import 'package:test/test.dart';

MessagePart _part({String? mime, String? filename, List<MessagePart>? parts}) =>
    MessagePart()
      ..mimeType = mime
      ..filename = filename
      ..parts = parts;

void main() {
  test('załącznik z zagnieżdżonej części: płaska pętla by go zgubiła', () {
    final payload = _part(mime: 'multipart/mixed', parts: [
      _part(mime: 'multipart/alternative', parts: [
        _part(mime: 'text/plain'),
        _part(mime: 'text/html'),
      ]),
      _part(mime: 'application/octet-stream', filename: kSubmissionFileName),
    ]);
    expect(allMessageParts(payload), hasLength(5));
    expect(attachmentPart(payload, '.$kSubmissionFileExtension')?.filename,
        kSubmissionFileName);
    // Gmail pakuje tak mejle z załącznikiem: `payload.parts` ma dwie pozycje,
    // a treść leży piętro niżej.
    expect(payload.parts, hasLength(2));
  });

  test('załącznik głębiej niż na pierwszym piętrze też się znajduje', () {
    final payload = _part(mime: 'multipart/mixed', parts: [
      _part(mime: 'multipart/related', parts: [
        _part(mime: 'application/octet-stream', filename: 'song_barka.hrcpsng'),
      ]),
    ]);
    expect(attachmentPart(payload, '.hrcpsng')?.filename, 'song_barka.hrcpsng');
  });

  test('rozszerzenia się nie mylą', () {
    final nowy = _part(filename: kSubmissionFileName);
    expect(attachmentPart(nowy, '.hrcpsng'), isNull,
        reason: '`.hrcpsngsbm` nie kończy się na `.hrcpsng`');
    expect(attachmentPart(_part(filename: 'SONG_BARKA.HRCPSNG'), '.hrcpsng'),
        isNotNull, reason: 'wielkość liter w nazwie bez znaczenia');
    expect(attachmentPart(_part(mime: 'text/plain'), '.hrcpsng'), isNull);
    expect(attachmentPart(null, '.hrcpsng'), isNull);
    expect(allMessageParts(null), isEmpty);
  });

  group('gmailRetryKind: co ponawiać', () {
    test('przekroczony limit', () {
      expect(gmailRetryKind(DetailedApiRequestError(429, 'Too many')), GmailRetry.quota);
      expect(gmailRetryKind(DetailedApiRequestError(403, 'Quota exceeded')), GmailRetry.quota);
      expect(gmailRetryKind(DetailedApiRequestError(403, 'User Rate Limit Exceeded')),
          GmailRetry.quota);
    });
    test('chwilowa awaria', () {
      for (final status in [500, 502, 503, 504]) {
        expect(gmailRetryKind(DetailedApiRequestError(status, 'x')), GmailRetry.transient);
      }
      expect(gmailRetryKind(const SocketException('reset')), GmailRetry.transient);
      expect(gmailRetryKind(http.ClientException('closed')), GmailRetry.transient);
      expect(gmailRetryKind(TimeoutException('slow')), GmailRetry.transient);
    });
    test('prawdziwy błąd', () {
      expect(gmailRetryKind(DetailedApiRequestError(404, 'Not found')), GmailRetry.none);
      expect(gmailRetryKind(DetailedApiRequestError(403, 'Insufficient permission')), GmailRetry.none);
      expect(gmailRetryKind(StateError('x')), GmailRetry.none);
    });
  });
}
