import 'package:harcapp_core/song_book/contrib_reply.dart';

import 'model.dart';

/// Mejl z kolejki `reply`: jego id i wątek, w którym leży.
typedef QueuedMessage = ({String id, String threadId});

/// Jeden mejl `reply`: odpowiedź w wątku **jednej** piosenki, żeby uwaga była
/// przy piosence, a odpowiedź autora wracała do właściwego wątku.
class PlannedReply {
  final String sender;
  final String threadId;
  /// Wiadomości tego wątku z kolejki — po wysyłce zmieniają etykiety.
  final List<String> messageIds;
  /// Twój tekst z przeglądu; `null` = mejl z samym blokiem o starej apce.
  final String? reviewNote;
  /// Wątek ze starej apki — blok o niej idzie w środku.
  final bool oldApp;
  /// Wiadomości autora z innych wątków, które czekały tylko na blok o starej
  /// apce. Ten mejl go niesie, więc `reply/old-app` schodzi też z nich.
  final List<String> alsoClearsOldApp;

  const PlannedReply({
    required this.sender,
    required this.threadId,
    required this.messageIds,
    required this.reviewNote,
    required this.oldApp,
    this.alsoClearsOldApp = const [],
  });

  /// Odpowiadamy na najnowszą wiadomość wątku.
  String get targetMessageId => messageIds.last;

  String get text => composeContribReply(reviewNote: reviewNote, oldApp: oldApp)!;

  LabelChange get labels => labelsAfterReply(sentReviewNote: reviewNote != null);
}

/// Odpowiedzi jednego autora i to, na co nie ma czego napisać.
typedef AuthorReplies = ({List<PlannedReply> replies, List<String> nothingToSay});

/// Plan odpowiedzi jednego autora: mejl w każdym wątku, do którego napisałeś
/// odpowiedź w przeglądzie. Blok o starej apce idzie w każdej odpowiedzi
/// w wątku ze starej apki; gdy żadna go nie niesie, a autor na niego czeka —
/// jeden mejl z samym blokiem, w jego najnowszym takim wątku.
///
/// [messages] od najstarszego. [reviewNotes]: id wątku → tekst z przeglądu.
/// W [AuthorReplies.nothingToSay] lądują wiadomości, dla których nie ma ani
/// tekstu, ani starej apki — ich etykiety zostają, żeby sprawa nie zginęła.
AuthorReplies planAuthorReplies(
  String sender,
  List<QueuedMessage> messages, {
  required Map<String, String> reviewNotes,
  required Set<String> oldAppIds,
}) {
  // Wątki w kolejności najnowszej wiadomości: `messages` jest od najstarszego.
  final byThread = <String, List<String>>{};
  for (final m in messages) {
    // Wyjęcie i wstawienie przesuwa wątek na koniec mapy.
    final ids = byThread.remove(m.threadId) ?? [];
    byThread[m.threadId] = ids..add(m.id);
  }

  String? noteOf(String threadId) {
    final note = reviewNotes[threadId]?.trim() ?? '';
    return note.isEmpty ? null : note;
  }
  bool isOldApp(List<String> ids) => ids.any(oldAppIds.contains);

  final replies = <PlannedReply>[];
  final waitingForBlock = <MapEntry<String, List<String>>>[];
  final nothingToSay = <String>[];
  for (final e in byThread.entries) {
    final note = noteOf(e.key);
    final oldApp = isOldApp(e.value);
    if (note != null) {
      replies.add(PlannedReply(
          sender: sender, threadId: e.key, messageIds: e.value, reviewNote: note, oldApp: oldApp));
    } else if (oldApp) {
      waitingForBlock.add(e);
    } else {
      nothingToSay.addAll(e.value);
    }
  }

  if (waitingForBlock.isNotEmpty) {
    final carrierIndex = replies.lastIndexWhere((r) => r.oldApp);
    if (carrierIndex >= 0) {
      final carrier = replies[carrierIndex];
      replies[carrierIndex] = PlannedReply(
        sender: sender,
        threadId: carrier.threadId,
        messageIds: carrier.messageIds,
        reviewNote: carrier.reviewNote,
        oldApp: true,
        alsoClearsOldApp: [for (final e in waitingForBlock) ...e.value],
      );
    } else {
      final latest = waitingForBlock.last;
      replies.add(PlannedReply(
        sender: sender,
        threadId: latest.key,
        messageIds: latest.value,
        reviewNote: null,
        oldApp: true,
        alsoClearsOldApp: [
          for (final e in waitingForBlock)
            if (e.key != latest.key) ...e.value,
        ],
      ));
    }
  }
  return (replies: replies, nothingToSay: nothingToSay);
}
