import 'package:harcapp_core/comm_classes/text_utils.dart';

import '../model.dart';
import '../reply.dart';
import 'command.dart';

class ReplyCommand extends PiosenkomatCommand {
  ReplyCommand(super.connectMailbox, super.root) {
    argParser.addOption('limit', abbr: 'n', help: 'Najwyżej tyle mejli w tym odpaleniu');
    addGmailOptions();
    addPushFlag('Wyślij (bez tej flagi tylko lista)');
  }

  @override
  final name = 'reply';
  @override
  final description = 'Odpowiedzi do autorów: wysyła szkice z kolejki '
      '(„${SongLabel.replyOldApp.label}”, „${SongLabel.replyReviewNote.label}”) — z Twoimi '
      'poprawkami z Gmaila. Jedna kolejka dla wszystkich przebiegów; przebiegu nie blokuje. '
      'Szkic sprzed przeglądu albo pisany ręcznie zostaje — narzędzie mówi, co z nim zrobić.';

  @override
  Future<int> execute() async {
    final limit = this.limit();
    final mailbox = await connect();
    // Lista i wysyłka idą razem — wysłany blok zmienia resztę kolejki — więc
    // na sucho zostaje tu sam dopisek.
    final failed = await sendReplies(mailbox, push: push, limit: limit);
    dryRun('wyśle powyższe');
    if (failed > 0) {
      throw Stop('Nie wszystko wyszło: ${plural(failed, 'wątek z błędem czeka', 'wątki z błędem czekają', 'wątków z błędem czeka')} '
          'dalej w kolejce (błędy wyżej) — odpal jeszcze raz.');
    }
    return 0;
  }
}
