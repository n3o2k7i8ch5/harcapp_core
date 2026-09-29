import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';

import '../mailbox.dart';
import '../model.dart';
import 'command.dart';

class ReopenCommand extends PiosenkomatCommand {
  ReopenCommand(super.connectMailbox, super.root) {
    argParser.addOption('query', help: 'Własne query Gmaila zamiast czekających na autora');
    addGmailOptions();
    addPushFlag('Zdejmij etykiety (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reopen';
  @override
  final description = 'Autorzy, którzy odpisali na Twój tekst („${SongLabel.waitingForAuthor.label}”): '
      'zdejmuje z ich wątków „song/*”, żeby wróciły do kolejki i przeszły scan. Kolejka to '
      '„inbox bez song/*, po wątkach”, więc odpowiedź w otagowanym wątku `scan` sam nie widzi.';

  @override
  Future<int> execute() async {
    final mailbox = await connect();
    final query = args['query'] as String? ??
        'label:${labelQueryName(SongLabel.waitingForAuthor.label)}';
    final ids = await mailbox.listIds(query);
    if (ids.isEmpty) {
      stdout.writeln('Nikt nie czeka na autora.');
      return 0;
    }
    stdout.writeln('Czeka na autora: ${emailCount(ids.length)}, '
        'sprawdzam wątki…');

    final threads = {for (final id in ids) mailbox.threadOf(id)};
    // Jedno zapytanie na wątek: kto pisał ostatni, jakie wiadomości, temat.
    final authorReplied = [
      for (final t in threads)
        if (await mailbox.threadSummary(t) case final s when s.incomingAfterOurReply) s,
    ];
    if (authorReplied.isEmpty) {
      stdout.writeln('Nikt jeszcze nie odpisał '
          '(${plural(threads.length, 'wątek czeka', 'wątki czekają', 'wątków czeka')}).');
      return 0;
    }

    final current = await mailbox.songLabelsByMessage();
    // Piosenka w pliku albo już w apce → nie ma czego przesiewać na nowo:
    // „dzięki” od autora to nie zgłoszenie, a poprawkę przysyła się z apki.
    bool inSongbook(ThreadSummary t) => t.messageIds.any((id) => const [SongLabel.added, SongLabel.readyToAdd]
        .any((l) => (current[id] ?? const {}).contains(l.label)));
    final reopened = [for (final t in authorReplied) if (!inSongbook(t)) t];
    final skippedCount = authorReplied.length - reopened.length;
    final changes = <String, LabelChange>{
      for (final t in reopened)
        for (final id in t.messageIds)
          if (current[id] case final labels? when labels.isNotEmpty)
            id: (const [], labels.toList()),
    };

    if (skippedCount > 0) {
      stdout.writeln('Pomijam ${plural(skippedCount, 'wątek', 'wątki', 'wątków')} '
          'z „${SongLabel.readyToAdd.label}” albo „${SongLabel.added.label}” — piosenka jest '
          'w pliku albo w apce, odpowiedź to nie nowe zgłoszenie.');
    }
    if (reopened.isEmpty) {
      stdout.writeln('Nic do cofnięcia do kolejki.');
      return 0;
    }
    stdout.writeln('Odpisali w ${plural(reopened.length, 'wątku', 'wątkach', 'wątkach')} — '
        '${plural(changes.length, 'mejl wróci', 'mejle wrócą', 'mejli wróci')} do kolejki:');
    for (final t in reopened) {
      stdout.writeln('  ${t.subject}  ${t.from}  [${t.threadId}]');
    }
    if (dryRun('zdejmie etykiety „song/*”, żeby `scan` zobaczył te wątki na nowo')) {
      return 0;
    }
    await applyLabelChanges(mailbox, changes);
    stdout.writeln('Zdjęto etykiety z ${plural(changes.length, 'mejla', 'mejli', 'mejli')}. '
        'Wrócą w kolejnym scan --push.');
    return 0;
  }
}
