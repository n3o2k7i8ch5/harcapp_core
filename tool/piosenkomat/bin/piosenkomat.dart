import 'dart:io';

import 'package:piosenkomat/cli.dart';

Future<void> main(List<String> args) async {
  exitCode = await runPiosenkomat(args);
}
