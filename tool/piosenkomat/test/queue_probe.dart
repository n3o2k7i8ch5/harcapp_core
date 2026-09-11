import 'dart:io';

import 'package:piosenkomat/gmail.dart';
import 'package:piosenkomat/model.dart';
import 'package:test/test.dart';

void main() {
  test('probe', () async {
    final mailbox = await GmailMailbox.connect(
      credentialsFile: File('secrets/credentials.json'),
      tokenFile: File('secrets/gmail_token.json'),
    );
    final ids = await mailbox.listIds(kQueueQuery, limit: 12);
    final msgs = await mailbox.getMessages(ids);
    for (final m in msgs) {
      if (m.isSongSubmission) continue;
      print('=== "${m.subject}"  załącznik: ${m.songAttachment != null}');
      print(m.body.length > 1800 ? m.body.substring(0, 1800) : m.body);
      break;
    }
  }, timeout: Timeout.none);
}
