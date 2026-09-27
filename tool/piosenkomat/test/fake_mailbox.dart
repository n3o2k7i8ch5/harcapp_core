import 'package:piosenkomat/mailbox.dart';
import 'package:piosenkomat/model.dart';

/// Wiadomość w skrzynce na niby.
class FakeMail {
  final String id;
  final String threadId;
  final String from;
  final String subject;
  final String body;
  /// Nasza wysłana (`SENT`).
  final bool sent;
  final Set<String> labels;

  FakeMail(this.id, this.threadId,
      {this.from = 'Jan <jan@example.com>',
      this.subject = 'Nowa piosenka',
      this.body = '',
      this.sent = false,
      Set<String>? labels})
      : labels = labels ?? {};
}

/// Skrzynka w pamięci — tyle Gmaila, ile potrzebują komendy. Query rozumie
/// tylko to, co one wysyłają: `label:…` (kilka to „albo”), `from:…`,
/// `in:sent to:…`.
class FakeMailbox implements Mailbox {
  final List<FakeMail> mails = [];
  final Map<String, ({String threadId, String body})> drafts = {};
  /// Treści wysłanych przez nas odpowiedzi, w kolejności.
  final List<({String threadId, String text})> sentTexts = [];
  var _next = 0;

  FakeMail add(FakeMail m) {
    mails.add(m);
    return m;
  }

  FakeMail _mail(String id) => mails.firstWhere((m) => m.id == id);

  @override
  String? knownThreadOf(String messageId) =>
      mails.where((m) => m.id == messageId).firstOrNull?.threadId;

  @override
  Future<List<String>> listIds(String query, {int? limit, bool newest = false}) async {
    final labels = [
      for (final m in RegExp(r'label:(\S+?)(?=\)|\s|$)').allMatches(query)) m[1]!,
    ];
    final from = RegExp(r'from:(\S+)').firstMatch(query)?[1];
    final sentTo = RegExp(r'in:sent to:(\S+)').firstMatch(query)?[1];
    var ids = [
      for (final m in mails)
        if (sentTo != null
            ? m.sent && _addressOf(m.from) == sentTo
            : (labels.isEmpty || labels.any((l) => m.labels.map(labelQueryName).contains(l))) &&
                (from == null || _addressOf(m.from) == from))
          m.id,
    ];
    if (newest) ids = ids.reversed.toList();
    return limit == null ? ids : ids.take(limit).toList();
  }

  static String _addressOf(String from) => RegExp(r'<(.+)>').firstMatch(from)?[1] ?? from;

  @override
  Future<List<ContribMessage>> getMessages(List<String> ids,
          {void Function(int done, int total)? onProgress}) async =>
      [
        for (final id in ids)
          if (_mail(id) case final m)
            ContribMessage(id: m.id, threadId: m.threadId, body: m.body, subject: m.subject, from: m.from, labels: m.labels),
      ];

  @override
  Future<Set<String>> threadsWithSongLabels() async =>
      {for (final m in mails) if (m.labels.any(isSongLabel)) m.threadId};

  @override
  Future<Map<String, List<String>>> sentIdsByThread() async {
    final out = <String, List<String>>{};
    for (final m in mails.where((m) => m.sent)) {
      out.putIfAbsent(m.threadId, () => []).add(m.id);
    }
    return out;
  }

  @override
  Future<Map<String, Set<String>>> songLabelsByMessage() async => {
        for (final m in mails)
          if (m.labels.where(isSongLabel).toSet() case final l when l.isNotEmpty) m.id: l,
      };

  @override
  Future<void> ensureToolLabels() async {}

  @override
  Future<void> batchModify(List<String> messageIds, {List<String>? add, List<String>? remove}) async {
    for (final id in messageIds) {
      final m = _mail(id);
      m.labels
        ..removeAll(remove ?? const [])
        ..addAll(add ?? const []);
    }
  }

  @override
  Future<({String subject, String from})> headersOf(String messageId) async =>
      (subject: _mail(messageId).subject, from: _mail(messageId).from);

  @override
  Future<ReplyTarget> replyTarget(String messageId) async {
    final m = _mail(messageId);
    return ReplyTarget(messageId: m.id, threadId: m.threadId, to: m.from, subject: m.subject);
  }

  @override
  Future<ThreadSummary> threadSummary(String threadId) async {
    final inThread = [for (final m in mails) if (m.threadId == threadId) m];
    return ThreadSummary.fromSent(
      threadId,
      [for (final m in inThread) (id: m.id, sent: m.sent)],
      subject: inThread.firstOrNull?.subject ?? '',
      from: inThread.firstOrNull?.from ?? '',
    );
  }

  void _send(String threadId, String text) {
    sentTexts.add((threadId: threadId, text: text));
    add(FakeMail('sent${_next++}', threadId, from: '$kInboxEmail', body: text, sent: true));
  }

  @override
  Future<void> replyTo(ReplyTarget target, String text) async => _send(target.threadId, text);

  @override
  Future<String> draftReplyTo(ReplyTarget target, String text) async {
    final id = 'draft${_next++}';
    drafts[id] = (threadId: target.threadId, body: text);
    return id;
  }

  @override
  Future<Map<String, String>> draftIdByThread() async =>
      {for (final e in drafts.entries) e.value.threadId: e.key};

  @override
  Future<void> updateDraft(String draftId, ReplyTarget target, String text) async =>
      drafts[draftId] = (threadId: target.threadId, body: text);

  @override
  Future<String?> draftBody(String draftId) async => drafts[draftId]?.body;

  @override
  Future<void> deleteDraft(String draftId) async => drafts.remove(draftId);

  @override
  Future<void> sendDraft(String draftId) async {
    final d = drafts.remove(draftId)!;
    _send(d.threadId, d.body);
  }
}
