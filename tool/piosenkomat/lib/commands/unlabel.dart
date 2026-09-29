import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';

import '../mailbox.dart';
import '../model.dart';
import '../plan.dart';
import '../report.dart';
import '../reply.dart';
import 'command.dart';

class UnlabelCommand extends PiosenkomatCommand {
  UnlabelCommand(super.connectMailbox, super.root) {
    argParser.addFlag('all', negatable: false, help: 'Cała skrzynka, nie tylko otwarty przebieg');
    addForceFlag('Zdejmij też z domkniętych („${SongLabel.added.label}”) i skasuj przebieg '
        'z robotą z przeglądu');
    addGmailOptions();
    addPushFlag('Cofnij (bez tej flagi tylko lista)');
  }

  @override
  final name = 'unlabel';
  @override
  final description = 'Cofa otwarty przebieg: zdejmuje to, co nadał automat („${SongLabel.auto.label}”), '
      'z jego mejli, kasuje szkice bez Twojego tekstu w ich wątkach i katalog out/run/. Bez '
      'out/run/ przebiegiem są wątki z otwartym werdyktem w Gmailu (inny komputer, skasowany '
      'katalog). Z --all — etykiety automatu z całej skrzynki. Mejle wracają do kolejki.';

  @override
  Future<int> execute() async {
    final run = runDir;
    // Zapisane eksporty z przeglądu przepadłyby razem z katalogiem. Na sucho
    // i tak pokazujemy wszystko, co cofnie — staje dopiero --push.
    final losesReviewWork = run.exists && run.hasReviewWork && !force;
    if (push && losesReviewWork) {
      throw Stop('W ${run.path} są eksporty z przeglądu — przepadną. --force, jeśli świadomie.');
    }
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final scope = args['all'] as bool ? null : _openRunMessages(mailbox, current);
    if (scope != null && scope.isEmpty) {
      stdout.writeln('Żaden przebieg nie jest otwarty. Etykiety automatu z całej skrzynki: '
          './piosenkomat unlabel --all');
      return 0;
    }
    final result = unlabelChanges(current, scope: scope, force: force);
    // Szkice odpowiedzi w cofanych wątkach — bez etykiety `reply/*` nikt by ich
    // nie wysłał. Ta sama reguła co wszędzie: kasujemy tylko szkic bez Twojego
    // tekstu, z tekstem zostaje.
    final drafts = await mailbox.draftIdByThread();
    final threads = {for (final id in result.toRemove.keys) mailbox.threadOf(id)};
    final draftsToDelete = <String>[];
    var draftsWithText = 0;
    for (final draftId in [for (final t in threads) if (drafts[t] case final id?) id]) {
      switch (draftStep(exists: true, body: await mailbox.draftBody(draftId))) {
        case DraftStep.delete:
          draftsToDelete.add(draftId);
        case DraftStep.differs:
          draftsWithText++;
        case _:
      }
    }

    if (result.toRemove.isEmpty && draftsToDelete.isEmpty && !run.exists) {
      stdout.writeln('Nic do cofnięcia — po automacie nie został ślad.');
      return 0;
    }
    stdout.writeln('Do zdjęcia z ${plural(result.toRemove.length, 'mejla', 'mejli', 'mejli')}:');
    countLines(stdout, tally(result.toRemove.values.expand((l) => l)));
    if (draftsToDelete.isNotEmpty) {
      stdout.writeln('Szkice odpowiedzi do skasowania: ${draftsToDelete.length}');
    }
    if (draftsWithText > 0) {
      stdout.writeln('${plural(draftsWithText, 'szkic', 'szkice', 'szkiców')} z tekstem do autora '
          'zostaje — skasuj w Gmailu, jeśli niepotrzebne.');
    }
    if (result.outsideScope > 0) {
      stdout.writeln('Poza tym przebiegiem '
          '${plural(result.outsideScope, 'mejl ma', 'mejle mają', 'mejli ma')} znacznik '
          '„${SongLabel.auto.label}”. Zejdą z `unlabel --all`.');
    }
    if (result.added > 0) {
      stdout.writeln('Pomijam ${plural(result.added, 'domknięty', 'domknięte', 'domkniętych')} '
          '(„${SongLabel.added.label}”) — te piosenki są już w apce; --force, jeśli mimo to '
          'mają zejść.');
    }
    if (run.exists) stdout.writeln('Katalog przebiegu do skasowania: ${run.path}');
    if (losesReviewWork) {
      stdout.writeln('  są w nim eksporty z przeglądu — przepadną, więc --push zażąda --force');
    }
    if (dryRun('cofnie powyższe')) return 0;

    await applyLabelChanges(mailbox, {
      for (final e in result.toRemove.entries) e.key: (const [], e.value),
    });
    for (final draftId in draftsToDelete) {
      await mailbox.deleteDraft(draftId);
    }
    if (run.exists) Directory(run.path).deleteSync(recursive: true);
    stdout.writeln('Cofnięte. Mejle wracają do kolejki, więc `scan` weźmie je ponownie.');
    return 0;
  }

  /// Mejle otwartego przebiegu: z `out/run/` — jego plan; bez — wszystko
  /// z `song/*` w wątkach z otwartym werdyktem w Gmailu (przebieg otwarty
  /// gdzie indziej). Pusty = nic nie jest otwarte.
  Set<String> _openRunMessages(Mailbox mailbox, Map<String, Set<String>> current) {
    if (runDir.exists) return runDir.readRunPlan().labelsByMessage.keys.toSet();
    final open = {for (final id in openVerdicts(current)) mailbox.threadOf(id)};
    return {for (final id in current.keys) if (open.contains(mailbox.threadOf(id))) id};
  }
}
