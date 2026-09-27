import 'model.dart';

/// Skrzynka, na której pracują komendy. [GmailMailbox] to prawdziwy Gmail;
/// testy podstawiają własną — bez tego wysyłka, szkice i `reopen` dały się
/// sprawdzić tylko na żywej skrzynce.
abstract interface class Mailbox {
  /// Wątek mejla, jeśli znamy go z [listIds].
  String? knownThreadOf(String messageId);

  /// Id pasujące do [query], od najstarszego; [newest] — od najnowszego.
  /// [limit] ucina wynik.
  Future<List<String>> listIds(String query, {int? limit, bool newest = false});

  /// Pełne mejle, w kolejności [ids].
  Future<List<ContribMessage>> getMessages(
    List<String> ids, {
    void Function(int done, int total)? onProgress,
  });

  /// Wątki, w których choć jedna wiadomość ma etykietę `song/*`.
  Future<Set<String>> threadsWithSongLabels();

  /// Nasze wysłane wiadomości po wątkach, bez szkiców.
  Future<Map<String, List<String>>> sentIdsByThread();

  /// Etykiety `song/*` całej skrzynki, po mejlu. Mejle bez żadnej nie mają klucza.
  Future<Map<String, Set<String>>> songLabelsByMessage();

  /// Tworzy brakujące etykiety narzędzia.
  Future<void> ensureToolLabels();

  /// Ta sama zmiana etykiet na całej paczce mejli.
  Future<void> batchModify(List<String> messageIds, {List<String>? add, List<String>? remove});

  /// Temat i nadawca mejla.
  Future<({String subject, String from})> headersOf(String messageId);

  /// Co trzeba wpisać w nagłówki odpowiedzi na [messageId].
  Future<ReplyTarget> replyTarget(String messageId);

  /// Wątek jednym zapytaniem: wiadomości, kto miał ostatnie słowo, temat.
  Future<ThreadSummary> threadSummary(String threadId);

  Future<void> replyTo(ReplyTarget target, String text);
  Future<String> draftReplyTo(ReplyTarget target, String text);

  /// Szkice po wątku, w którym siedzą.
  Future<Map<String, String>> draftIdByThread();
  Future<void> updateDraft(String draftId, ReplyTarget target, String text);

  /// Treść szkicu jako czysty tekst; `null`, gdy nie da się jej odczytać.
  Future<String?> draftBody(String draftId);
  Future<void> deleteDraft(String draftId);
  Future<void> sendDraft(String draftId);
}

/// Mejl, na który odpisujemy, wraz z tym, co trzeba wpisać w nagłówki.
class ReplyTarget {
  final String messageId;
  final String threadId;
  final String to;
  final String subject;
  final String? rfcMessageId;
  final String? references;

  const ReplyTarget({
    required this.messageId,
    required this.threadId,
    required this.to,
    required this.subject,
    this.rfcMessageId,
    this.references,
  });
}

/// Wątek bez treści: wiadomości (bez szkiców) i to, kto pisał ostatni.
/// Wiadomość bez `SENT` w naszej skrzynce jest przychodząca.
class ThreadSummary {
  final String threadId;
  /// Od najstarszej.
  final List<String> messageIds;
  /// Po naszej ostatniej wiadomości przyszła odpowiedź — po tym `reopen`
  /// poznaje, że autor odpisał.
  final bool incomingAfterOurReply;
  /// Ostatnie słowo jest nasze — tak `reply` poznaje szkic wysłany ręcznie
  /// z Gmaila.
  final bool ourReplyIsLatest;
  /// Temat i nadawca pierwszej wiadomości — do wypisania listy.
  final String subject;
  final String from;

  const ThreadSummary({
    required this.threadId,
    required this.messageIds,
    required this.incomingAfterOurReply,
    required this.ourReplyIsLatest,
    this.subject = '',
    this.from = '',
  });

  /// Z etykiet `SENT` kolejnych wiadomości wątku.
  factory ThreadSummary.fromSent(
    String threadId,
    List<({String id, bool sent})> messages, {
    String subject = '',
    String from = '',
  }) {
    final lastOurs = messages.lastIndexWhere((m) => m.sent);
    return ThreadSummary(
      threadId: threadId,
      messageIds: [for (final m in messages) m.id],
      incomingAfterOurReply: lastOurs >= 0 && messages.skip(lastOurs + 1).any((m) => !m.sent),
      ourReplyIsLatest: messages.isNotEmpty && messages.last.sent,
      subject: subject,
      from: from,
    );
  }
}
