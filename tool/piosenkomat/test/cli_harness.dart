import 'dart:io';

import 'package:piosenkomat/cli.dart';
import 'package:test/test.dart';

/// Launcher CLI, odpalany przez `run.sh`. Zwykłe `flutter test` go pomija.
void main() {
  if (Platform.environment['PIOSENKOMAT_CLI'] != '1') return;

  test('cli', () async {
    final raw = Platform.environment['PIOSENKOMAT_ARGS'] ?? '';
    final args = raw.isEmpty ? <String>[] : raw.split('\x1f');
    final code = await runPiosenkomat(args);
    if (code != 0) fail('piosenkomat zakończył się kodem $code');
  }, timeout: Timeout.none);
}
