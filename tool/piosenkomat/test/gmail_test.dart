import 'dart:async';
import 'dart:io';

import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart' as http;
import 'package:piosenkomat/gmail.dart';
import 'package:test/test.dart';

void main() {
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
