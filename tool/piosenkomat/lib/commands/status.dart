import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';

import '../mailbox.dart';
import '../model.dart';
import '../plan.dart';
import '../report.dart';
import '../run_dir.dart';
import 'command.dart';
import 'review.dart';

class StatusCommand extends PiosenkomatCommand {
  StatusCommand(super.connectMailbox, super.root) {
    addGmailOptions();
  }

  @override
  final name = 'status';
  @override
  final description = 'Co jest otwarte i jaki jest następny krok — według Gmaila, '
      'z katalogiem out/run/ jako podpowiedzią.';

  @override
  Future<int> execute() async {
    final run = runDir;
    final plan = run.exists ? run.readRunPlan() : null;
    final mailbox = await connect();
    final current = await mailbox.songLabelsByMessage();
    final open = openVerdicts(current);

    if (plan == null) {
      stdout.writeln(open.isEmpty
          ? 'Żaden przebieg nie jest otwarty. Dalej: ./piosenkomat scan --push'
          : openElsewhereMessage(open.length));
    } else {
      stdout.writeln('Przebieg ${plan.id} (${run.path}), zeskanowany ${formatMinute(plan.createdAt)}.');
      if (plan.pushedAt == null) {
        stdout.writeln(interruptedMessage(plan));
      } else {
        final needsReview = plan.threadsWith(current, SongLabel.needsReview).length;
        stdout
          ..writeln('  na przegląd czeka  $needsReview')
          ..writeln('  przyjęte           ${plan.threadsWith(current, SongLabel.readyToAdd).length}');
        final outside = open.where((id) => !plan.labelsByMessage.containsKey(id)).length;
        if (outside > 0) {
          stdout.writeln('  UWAGA: ${emailCount(outside)} z otwartym werdyktem '
              'spoza tego przebiegu (inny komputer?)');
        }
        stdout.writeln('Dalej: ${await _nextStep(mailbox, run, plan, current, needsReview)}');
      }
    }

    final replyThreads = {
      for (final e in current.entries)
        if (e.value.any(kReplyQueueLabels.contains))
          mailbox.threadOf(e.key),
    };
    if (replyThreads.isNotEmpty) {
      final drafts = await mailbox.draftIdByThread();
      final withDraft = replyThreads.where(drafts.containsKey).length;
      stdout.writeln('Odpowiedzi czekają: ${plural(replyThreads.length, 'wątek', 'wątki', 'wątków')} '
          '($withDraft ze szkicem). Dalej: ./piosenkomat reply');
    }
    return 0;
  }
}

/// Następny krok otwartego przebiegu — po etykietach, plikach w katalogu
/// i tym, czy przegląd jest aktualny. To ostatnie sprawdza się tak samo jak
/// w `finalize` ([staleReview]), więc `status` nie wyśle do komendy, która
/// stanie.
Future<String> _nextStep(Mailbox mailbox, RunDir run, RunPlan plan, Map<String, Set<String>> current,
    int needsReview) async {
  if (needsReview > 0 || run.missingExports.isNotEmpty) {
    return 'przegląd na stronie, eksport do reviewed-*.hrcpsng, potem ./piosenkomat review --push';
  }
  if (run.kinds.any((kind) => !File(run.finalSongs(kind)).existsSync())) return './piosenkomat review --push';
  if (run.kinds.isEmpty) return './piosenkomat finalize --push (nic nie poszło do przeglądu)';
  List<KindReview>? readable() {
    try {
      return kindReviews(run, plan);
    } on FileSystemException {
      return null;
    }
  }

  final reviews = readable();
  if (reviews == null || reviews.any((r) => r.result.mustStop)) {
    return 'popraw eksport w reviewed-*.hrcpsng — ./piosenkomat review pokaże, co jest nie tak';
  }
  final stale = await staleReview(mailbox, run, plan, [for (final r in reviews) r.result], current);
  if (stale.isNotEmpty) {
    return './piosenkomat review --push — eksport zmienił się po przeglądzie '
        '(nie zgadzają się: ${stale.join(', ')})';
  }
  return 'wklej final-*.hrcpsng do all_songs, potem ./piosenkomat finalize --push';
}
