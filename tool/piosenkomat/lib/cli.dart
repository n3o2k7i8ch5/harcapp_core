import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:harcapp_core/song_book/import_hrcpsng.dart';
import 'package:harcapp_core/values/strings.dart';

import 'commands/command.dart';
import 'commands/explain.dart';
import 'commands/finalize.dart';
import 'commands/reopen.dart';
import 'commands/reply.dart';
import 'commands/review.dart';
import 'commands/scan.dart';
import 'commands/status.dart';
import 'commands/unlabel.dart';
import 'gmail.dart';
import 'mailbox.dart';

/// [root]: katalog z `out/` i `archive/` — domyślnie katalog narzędzia.
Future<int> runPiosenkomat(List<String> args, {MailboxConnector? connect, String root = '.'}) async {
  final runner = _Runner(connect ?? _connectGmail, root);
  if (args.isEmpty) {
    stdout.writeln(runner.usage);
    return 64;
  }
  // Po polsku, bo na to trafia się najczęściej.
  if (!args.first.startsWith('-') && !runner.commands.containsKey(args.first)) {
    stderr.writeln('Nie ma komendy „${args.first}”.');
    stdout.writeln(runner.usage);
    return 64;
  }
  try {
    return await runner.run(args) ?? 0;
  } on Stop catch (e) {
    stderr.writeln('STOP. ${e.message}');
    return 1;
  } on UsageException catch (e) {
    stderr
      ..writeln(e.message)
      ..writeln(e.usage);
    return 64;
  } on FileSystemException catch (e) {
    stderr.writeln('${e.message}: ${e.path}');
    return 1;
  } on HrcpsngDuplicateIdError catch (e) {
    stderr.writeln('STOP. ${e.message} — pliku z duplikatami nie zapisuję.');
    return 1;
  }
}

class _Runner extends CommandRunner<int> {
  _Runner(MailboxConnector connect, String root)
      : super('./piosenkomat', 'piosenkomat: sitko mejli z piosenkami na $kHarcappEmail.') {
    for (final command in [
      ScanCommand(connect, root),
      ReviewCommand(connect, root),
      FinalizeCommand(connect, root),
      ReplyCommand(connect, root),
      StatusCommand(connect, root),
      ReopenCommand(connect, root),
      UnlabelCommand(connect, root),
      ExplainCommand(connect, root),
    ]) {
      addCommand(command);
    }
  }

  @override
  String get usageFooter => '\nPrzebieg jest jeden naraz: scan --push → przegląd na stronie → '
      'review --push → wklejenie final-* do all_songs → finalize --push.\n'
      'Odpowiedzi do autorów czekają w szkicach: reply --push, kiedy chcesz.\n'
      'Bez --push nic w Gmailu się nie zmienia. Flagi komendy: ./piosenkomat <komenda> --help';
}

Future<Mailbox> _connectGmail(ArgResults args) => GmailMailbox.connect(
      credentialsFile: File(_optionPath(args, 'credentials') ?? defaultCredentialsPath()),
      tokenFile: File(_optionPath(args, 'token') ?? defaultTokenPath()),
    );

String? _optionPath(ArgResults args, String name) => switch (args[name] as String?) {
      final path? => userPath(path),
      null => null,
    };
