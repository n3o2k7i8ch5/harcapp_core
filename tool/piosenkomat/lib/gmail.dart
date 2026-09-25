import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:harcapp_core/song_book/submission/submission_file.dart';

import 'hrcpsng.dart';
import 'model.dart';

/// `modify` etykietuje — bez niego nie zrobi nic. `send` odpisuje autorom ze
/// starej apki i potrzebuje go wyłącznie `reply`, więc reszta komend nie każe
/// się logować od nowa, kiedy zapisany token go nie ma.
const String kScopeModify = GmailApi.gmailModifyScope;
const String kScopeSend = GmailApi.gmailSendScope;

/// O zgodę prosimy zawsze na komplet — jedno logowanie starcza na wszystko.
final List<String> kGmailScopes = [kScopeModify, kScopeSend];

String defaultCredentialsPath() => p.join('secrets', 'credentials.json');
String defaultTokenPath() => p.join('secrets', 'gmail_token.json');

class GmailMailbox {
  GmailMailbox(this._api);

  final GmailApi _api;
  final Map<String, String> _idByName = {};
  final Map<String, String> _nameById = {};
  /// Wątek każdego mejla, który przeszedł przez [listIds] — `messages.list`
  /// oddaje go za darmo, a pytanie o niego osobno kosztuje `get`.
  final Map<String, String> _threadById = {};

  /// Wątek mejla, jeśli znamy go z [listIds].
  String? knownThreadOf(String messageId) => _threadById[messageId];

  /// Gmail rozlicza limit w **jednostkach**, nie w requestach: 6000 na minutę
  /// na użytkownika. Metody kosztują różnie — `messages.get` i `attachments.get`
  /// po 20, `batchModify` 50 za paczkę do 1000 mejli, `list` 5, `labels.list` 1.
  ///
  /// Wiadro z żetonami trzyma nas tuż pod progiem. Sztywna przerwa między
  /// requestami tego nie umiała: przy 20-jednostkowych `get` celowała trzykrotnie
  /// ponad limit, wpadała w 429 i czekała po kilkanaście sekund, więc im szybciej
  /// próbowała, tym wolniej szło.
  /// Odnawiamy poniżej progu 6000/min, bo Gmail pilnuje też krótszych okien
  /// i przy jeździe równo po limicie potrafi oddać 429.
  static const int _unitsPerMinute = 5200;

  /// Ile żetonów wolno uzbierać na zapas. Pełne wiadro (minuta z góry)
  /// puszczałoby na starcie serię 300 zapytań naraz — i prosto w 429.
  static const int _maxBurst = 100;
  static const int _costGet = 20;
  static const int _costList = 5;
  static const int _costModify = 50;
  static const int _costLabelCreate = 5;
  static const int _costLabelList = 1;
  static const int _costSend = 100;
  static const int _costDraftWrite = 10;
  static const int _costDraftList = 5;
  double _units = 0;
  DateTime _refilled = DateTime.now();

  /// Czeka, aż w wiadrze będzie [cost] żetonów, i zabiera je.
  Future<void> _spend(int cost) async {
    while (true) {
      final now = DateTime.now();
      _units = min(
          _maxBurst.toDouble(),
          _units +
              now.difference(_refilled).inMilliseconds *
                  _unitsPerMinute /
                  Duration.millisecondsPerMinute);
      _refilled = now;
      if (_units >= cost) {
        _units -= cost;
        return;
      }
      final missingUnits = cost - _units;
      await Future.delayed(Duration(
          milliseconds:
              (missingUnits * Duration.millisecondsPerMinute / _unitsPerMinute)
                      .ceil() +
                  5));
    }
  }

  /// Zapytanie w ramach limitu; przy 403/429 czekamy i próbujemy jeszcze raz.
  Future<T> _call<T>(Future<T> Function() fn, {int cost = _costList}) async {
    var wait = const Duration(seconds: 5);
    for (var attempt = 1;; attempt++) {
      await _spend(cost);
      try {
        return await fn();
      } on DetailedApiRequestError catch (e) {
        final quota = e.status == 429
            || (e.status == 403 && (e.message ?? '').toLowerCase().contains('quota'));
        if (!quota || attempt >= 7) rethrow;
        stdout.writeln('Limit Gmail API, czekam ${wait.inSeconds}s…');
        await Future.delayed(wait);
        wait *= 2;
        // Limit i tak przekroczony — wiadro do zera, żeby nie dobijać.
        _units = 0;
      }
    }
  }

  /// Pobiera mejle kilkoma strumieniami naraz. Tempo i tak pilnuje [_spend];
  /// równoległość służy tylko temu, żeby czekanie na odpowiedź nie marnowało
  /// limitu, który w tym czasie się odnawia.
  Future<List<ContribMessage>> getMessages(
    List<String> ids, {
    int concurrency = 8,
    void Function(int done, int total)? onProgress,
  }) async {
    final out = List<ContribMessage?>.filled(ids.length, null);
    var next = 0;
    var done = 0;
    Future<void> worker() async {
      while (true) {
        final i = next++;
        if (i >= ids.length) return;
        out[i] = await getMessage(ids[i]);
        onProgress?.call(++done, ids.length);
      }
    }

    await Future.wait([
      for (var i = 0; i < min(concurrency, ids.length); i++) worker(),
    ]);
    return out.cast<ContribMessage>();
  }

  /// [needsSend] tylko dla `reply`: bez niego zapisany token wystarczy,
  /// gdy ma samo `modify`.
  static Future<GmailMailbox> connect({
    required File credentialsFile,
    required File tokenFile,
    bool needsSend = false,
  }) async {
    if (!credentialsFile.existsSync()) {
      throw FileSystemException(
          'Brak credentials.json, zobacz README', credentialsFile.path);
    }
    final clientId = _clientIdFromFile(credentialsFile);
    final mailbox = GmailMailbox(
        GmailApi(await _authClient(clientId, tokenFile, needsSend: needsSend)));
    await mailbox._loadLabels();
    return mailbox;
  }

  /// ID pasujące do [query]. Gmail zwraca od najnowszych; domyślnie
  /// bierzemy [limit] najstarszych.
  Future<List<String>> listIds(
    String query, {
    int? limit,
    bool newest = false,
  }) async {
    final ids = <String>[];
    String? page;
    do {
      final resp = await _call(
          () => _api.users.messages.list(
                'me',
                q: query,
                maxResults: 500,
                pageToken: page,
              ),
          cost: _costList);
      for (final m in resp.messages ?? const <Message>[]) {
        ids.add(m.id!);
        if (m.threadId case final t?) _threadById[m.id!] = t;
      }
      page = resp.nextPageToken;
    } while (page != null && !(newest && limit != null && ids.length >= limit));

    final ordered = newest ? ids : ids.reversed;
    return (limit == null ? ordered : ordered.take(limit)).toList();
  }

  Future<ContribMessage> getMessage(String id) async {
    final msg = await _call(
        () => _api.users.messages.get('me', id, format: 'full'),
        cost: _costGet);
    // Nowe zgłoszenia jadą `.$kSubmissionFileExtension`, stare `.hrcpsng`.
    // Przy obu naraz wygrywa nowy — patrz `buildSubmission`.
    final songAttachment = await _attachmentOf(msg, id, '.hrcpsng');
    final submissionAttachment =
        await _attachmentOf(msg, id, '.$kSubmissionFileExtension');
    final headers = _headersOf(msg.payload);
    return ContribMessage(
      id: msg.id ?? id,
      threadId: msg.threadId,
      body: _plainText(msg.payload),
      subject: headers['subject'],
      from: headers['from'],
      date: msg.internalDate == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              int.parse(msg.internalDate!), isUtc: true),
      labels: {
        for (final lid in msg.labelIds ?? const <String>[])
          _nameById[lid] ?? lid,
      },
      songAttachment: songAttachment,
      submissionAttachment: submissionAttachment,
    );
  }

  /// Treść pierwszego załącznika o podanym rozszerzeniu, także z części
  /// zagnieżdżonych.
  Future<String?> _attachmentOf(Message msg, String id, String extension) async {
    final part = attachmentPart(msg.payload, extension);
    if (part == null) return null;
    // Małe załączniki Gmail oddaje od razu w treści odpowiedzi. Dokładanie
    // wtedy `attachments.get` to drugie 20 jednostek za te same bajty.
    if (part.body?.data case final data?) return _decode(data);
    if (part.body?.attachmentId case final attId?) {
      final att = await _call(
          () => _api.users.messages.attachments.get('me', id, attId),
          cost: _costGet);
      if (att.data != null) return _decode(att.data!);
    }
    return null;
  }

  /// Odpowiedź w wątku [message]: ten sam `threadId`, `In-Reply-To`
  /// i `References`, żeby u autora wpadła pod jego zgłoszenie, a nie jako
  /// osobny mejl znikąd.
  Future<void> replyTo(ReplyTarget target, String text) async {
    await _call(() => _api.users.messages.send(_replyMessage(target, text), 'me'),
        cost: _costSend);
  }

  /// To samo, co [replyTo], ale zostaje szkicem w wątku — do przejrzenia
  /// i poprawienia w Gmailu, zanim pójdzie w świat. Zwraca id szkicu.
  Future<String> draftReplyTo(ReplyTarget target, String text) async {
    final draft = await _call(
        () => _api.users.drafts.create(
            Draft()..message = _replyMessage(target, text), 'me'),
        cost: _costDraftWrite);
    return draft.id!;
  }

  /// Szkice po wątku, w którym siedzą. Jedno zapytanie zamiast jednego na
  /// autora — `drafts.list` i tak oddaje `message.threadId` przy każdym.
  Future<Map<String, String>> draftIdByThread() async {
    final out = <String, String>{};
    String? page;
    do {
      final resp = await _call(
          () => _api.users.drafts.list('me', maxResults: 500, pageToken: page),
          cost: _costDraftList);
      for (final d in resp.drafts ?? const <Draft>[]) {
        final threadId = d.message?.threadId;
        if (d.id != null && threadId != null) out[threadId] = d.id!;
      }
      page = resp.nextPageToken;
    } while (page != null);
    return out;
  }

  /// Podmienia treść istniejącego szkicu — mejl przelicza się od nowa, gdy
  /// dochodzi kolejna sprawa (np. dopisałeś uwagę do piosenki autora, który
  /// i tak miał dostać blok o starej apce).
  Future<void> updateDraft(String draftId, ReplyTarget target, String text) async {
    await _call(
        () => _api.users.drafts.update(
            Draft()..message = _replyMessage(target, text), 'me', draftId),
        cost: _costDraftWrite);
  }

  /// Treść szkicu jako czysty tekst — po to, żeby nie nadpisać tego, co
  /// poprawiłeś ręcznie w Gmailu. `null`, gdy nie da się jej odczytać.
  Future<String?> draftBody(String draftId) async {
    final draft = await _call(
        () => _api.users.drafts.get('me', draftId, format: 'full'),
        cost: _costGet);
    final payload = draft.message?.payload;
    if (payload == null) return null;
    // Ten sam ekstraktor, co przy czytaniu zgłoszeń: schodzi w głąb
    // `multipart/mixed → multipart/alternative → text/plain`, w co Gmail
    // owija szkic po pierwszym otwarciu w edytorze.
    final text = _plainText(payload);
    return text.trim().isEmpty ? null : text;
  }

  /// Kasuje szkic. Po pomyłkowym `--draft`: nic nie poszło w świat, więc
  /// wystarczy sprzątnąć szkic.
  Future<void> deleteDraft(String draftId) async {
    await _call(() => _api.users.drafts.delete('me', draftId),
        cost: _costDraftWrite);
  }

  /// Wysyła gotowy szkic — z Twoimi poprawkami, jeśli jakieś zrobiłeś.
  Future<void> sendDraft(String draftId) async {
    await _call(() => _api.users.drafts.send(Draft()..id = draftId, 'me'),
        cost: _costSend);
  }

  /// Wiadomości wątku bez szkiców: `threads.get` oddaje też to, co dopiero
  /// piszesz (etykieta `DRAFT`), a szkic nie jest ani nasz wysłany, ani cudzy
  /// przychodzący.
  Future<List<Message>> _threadMessages(String threadId) async => [
        for (final m in await _thread(threadId))
          if (!(m.labelIds ?? const <String>[]).contains('DRAFT')) m,
      ];

  /// Wiadomości wątku, same etykiety (bez treści).
  Future<List<Message>> _thread(String threadId) async {
    final thread = await _call(
        () => _api.users.threads.get('me', threadId, format: 'minimal'),
        cost: _costGet);
    return thread.messages ?? const [];
  }

  static bool _isSent(Message m) =>
      (m.labelIds ?? const <String>[]).contains('SENT');

  /// Czy po naszej ostatniej wiadomości autor odpisał. Po tym poznajemy, że
  /// pytanie o chwyty doczekało się odpowiedzi — a odpowiedź przychodzi
  /// w wątku, który ma już etykiety `song/*`, więc `scan` sam jej nie widzi.
  ///
  /// Same etykiety wystarczą: wiadomość bez `SENT` w naszej skrzynce jest
  /// przychodząca. Nagłówka `From` nie czytamy, bo to kolejne 20 jednostek
  /// na wątek, a niczego by nie rozstrzygnęło.
  Future<bool> hasIncomingAfterOurReply(String threadId) async {
    final messages = await _threadMessages(threadId);
    final lastOurs = messages.lastIndexWhere(_isSent);
    if (lastOurs < 0) return false;
    return messages.skip(lastOurs + 1).any((m) => !_isSent(m));
  }

  /// Czy ostatnie słowo w wątku jest nasze. Tak poznajemy szkic wysłany
  /// ręcznie z Gmaila: szkicu już nie ma, a od tamtej pory nikt nie odpisał.
  /// „Kiedykolwiek coś wysłaliśmy” nie wystarcza — po odpowiedzi autora
  /// i drugim pytaniu z przeglądu stara wysyłka udawałaby nową.
  Future<bool> ourReplyIsLatest(String threadId) async {
    final messages = await _threadMessages(threadId);
    return messages.isNotEmpty && _isSent(messages.last);
  }

  /// Dane potrzebne do odpowiedzi. Osobny strzał po nagłówki, bo
  /// [ContribMessage] ich nie niesie.
  Future<ReplyTarget> replyTarget(String messageId) async {
    final msg = await _call(
        () => _api.users.messages.get('me', messageId,
            format: 'metadata',
            metadataHeaders: ['From', 'Subject', 'Message-ID', 'References']),
        cost: _costGet);
    final headers = _headersOf(msg.payload);
    return ReplyTarget(
      messageId: msg.id ?? messageId,
      threadId: msg.threadId ?? messageId,
      to: headers['from'] ?? '',
      subject: headers['subject'] ?? '',
      rfcMessageId: headers['message-id'],
      references: headers['references'],
    );
  }

  /// Nagłówki bez treści — do wypisania listy, gdy treść jest niepotrzebna.
  Future<({String subject, String from})> headersOf(String messageId) async {
    final msg = await _call(
        () => _api.users.messages.get('me', messageId,
            format: 'metadata', metadataHeaders: ['From', 'Subject']),
        cost: _costGet);
    final headers = _headersOf(msg.payload);
    return (subject: headers['subject'] ?? '', from: headers['from'] ?? '');
  }

  /// Wątek jednym strzałem: suma etykiet wszystkich wiadomości (kolejka jest
  /// po wątkach — odpowiedź w wątku z `song/*` nie jest nowym zgłoszeniem)
  /// i id naszych wysłanych wiadomości, bez szkiców — te wchodzą do rozmowy
  /// w edytorze, choć w kolejce ich nie ma (leżą w `SENT`, nie w `INBOX`).
  Future<({Set<String> labels, List<String> sentIds})> threadSummary(
      String threadId) async {
    final messages = await _thread(threadId);
    return (
      labels: {
        for (final m in messages)
          for (final id in m.labelIds ?? const <String>[]) _nameById[id] ?? id,
      },
      sentIds: [
        for (final m in messages)
          if (_isSent(m) && !(m.labelIds ?? const <String>[]).contains('DRAFT')) m.id!,
      ],
    );
  }

  /// Id wszystkich wiadomości wątku — etykiety idą na cały wątek.
  Future<List<String>> threadMessageIds(String threadId) async =>
      [for (final m in await _thread(threadId)) m.id!];

  /// Etykiety `song/*` całej skrzynki: jedno zapytanie na etykietę zamiast
  /// jednego na mejl. Przy przebiegu z setkami mejli to różnica między
  /// kilkunastoma strzałami a kilkuset. Mejle bez żadnej `song/*` nie mają klucza.
  ///
  /// Bierzemy nazwy prosto ze skrzynki, nie z [kAllSongLabels] — inaczej
  /// etykieta dorobiona ręcznie poza taksonomią byłaby dla nas niewidzialna.
  Future<Map<String, Set<String>>> songLabelsByMessage() async {
    final out = <String, Set<String>>{};
    for (final name in _idByName.keys.where(isSongLabel).toList()) {
      for (final id in await listIds('label:${labelQueryName(name)}')) {
        out.putIfAbsent(id, () => {}).add(name);
      }
    }
    return out;
  }

  Future<void> _loadLabels() async {
    final existing =
        await _call(() => _api.users.labels.list('me'), cost: _costLabelList);
    for (final l in existing.labels ?? const <Label>[]) {
      if (l.name == null || l.id == null) continue;
      _idByName[l.name!] = l.id!;
      _nameById[l.id!] = l.name!;
    }
  }

  /// Tworzy brakujące etykiety narzędzia. Ludzkich nie rusza.
  Future<void> ensureToolLabels() async {
    for (final name in kToolLabels) {
      if (_idByName.containsKey(name)) continue;
      final created = await _call(
          () => _api.users.labels.create(
                Label()
                  ..name = name
                  ..labelListVisibility = 'labelShow'
                  ..messageListVisibility = 'show',
                'me',
              ),
          cost: _costLabelCreate);
      _idByName[name] = created.id!;
      _nameById[created.id!] = name;
    }
  }

  /// Ta sama zmiana na całej paczce mejli: `batchModify` bierze do 1000 naraz.
  /// Nazw, których w skrzynce nie ma, nie zdejmujemy — nie ma czego.
  Future<void> batchModify(
    List<String> messageIds, {
    List<String>? add,
    List<String>? remove,
  }) async {
    for (var i = 0; i < messageIds.length; i += 1000) {
      final chunk = messageIds.sublist(i, min(i + 1000, messageIds.length));
      await _call(
          () => _api.users.messages.batchModify(
                BatchModifyMessagesRequest()
                  ..ids = chunk
                  ..addLabelIds =
                      add == null ? null : [for (final n in add) _idByName[n]!]
                  ..removeLabelIds = remove == null
                      ? null
                      : [for (final n in remove) if (_idByName[n] case final id?) id],
                'me',
              ),
          cost: _costModify);
    }
  }

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

/// Odpowiedź gotowa do wysłania albo do szkicu: w wątku [ReplyTarget.threadId].
Message _replyMessage(ReplyTarget target, String text) => Message()
  ..raw = base64Url.encode(utf8.encode(_mimeReply(target, text)))
  ..threadId = target.threadId;

/// RFC 822 odpowiedzi. Temat i treść po polsku, więc base64 + UTF-8.
String _mimeReply(ReplyTarget target, String text) {
  final subject = target.subject.startsWith('Re:')
      ? target.subject
      : 'Re: ${target.subject}';
  final references = [
    if ((target.references ?? '').trim().isNotEmpty) target.references!.trim(),
    if (target.rfcMessageId != null) target.rfcMessageId!,
  ].join(' ');
  final headers = <String, String>{
    'To': target.to,
    'Subject': _encodeHeader(subject),
    if (target.rfcMessageId != null) 'In-Reply-To': target.rfcMessageId!,
    if (references.isNotEmpty) 'References': references,
    'MIME-Version': '1.0',
    'Content-Type': 'text/plain; charset="UTF-8"',
    'Content-Transfer-Encoding': 'base64',
  };
  final body = base64.encode(utf8.encode(text));
  return [
    for (final e in headers.entries) '${e.key}: ${e.value}',
    '',
    // Base64 w mejlu łamie się co 76 znaków.
    for (var i = 0; i < body.length; i += 76)
      body.substring(i, i + 76 > body.length ? body.length : i + 76),
  ].join('\r\n');
}

/// Nagłówek z polskimi znakami: RFC 2047.
String _encodeHeader(String value) => value.codeUnits.every((c) => c < 128)
    ? value
    : '=?UTF-8?B?${base64.encode(utf8.encode(value))}?=';

/// Wszystkie części wiadomości, także zagnieżdżone: `multipart/mixed` bywa
/// owinięty wokół `multipart/alternative`, a płaska pętla po `payload.parts`
/// gubi wtedy wszystko, co leży głębiej.
Iterable<MessagePart> allMessageParts(MessagePart? part) sync* {
  if (part == null) return;
  yield part;
  for (final child in part.parts ?? const <MessagePart>[]) {
    yield* allMessageParts(child);
  }
}

/// Pierwszy załącznik o podanym rozszerzeniu w `filename`.
MessagePart? attachmentPart(MessagePart? payload, String extension) =>
    allMessageParts(payload)
        .where((p) => (p.filename ?? '').toLowerCase().endsWith(extension))
        .firstOrNull;

String _plainText(MessagePart? part) {
  if (part == null) return '';
  if (part.mimeType == 'text/plain' && part.body?.data != null) {
    return _decode(part.body!.data!);
  }
  for (final child in part.parts ?? const <MessagePart>[]) {
    final text = _plainText(child);
    if (text.trim().isNotEmpty) return text;
  }
  if (part.body?.data != null) return _decode(part.body!.data!);
  return '';
}

String _decode(String data) => utf8.decode(base64.decode(base64.normalize(data)));

/// Nagłówki po małych literach: `subject`, `from`, `in-reply-to`…
Map<String, String> _headersOf(MessagePart? part) => {
      for (final h in part?.headers ?? const <MessagePartHeader>[])
        if (h.name != null && h.value != null) h.name!.toLowerCase(): h.value!,
    };

ClientId _clientIdFromFile(File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final installed = (json['installed'] ?? json['web']) as Map<String, dynamic>;
  return ClientId(
    installed['client_id'] as String,
    installed['client_secret'] as String?,
  );
}

Future<AutoRefreshingAuthClient> _authClient(
  ClientId id,
  File tokenFile, {
  required bool needsSend,
}) async {
  if (tokenFile.existsSync()) {
    final json = jsonDecode(tokenFile.readAsStringSync()) as Map<String, dynamic>;
    final credentials = AccessCredentials(
      AccessToken(
        json['token_type'] as String? ?? 'Bearer',
        json['access_token'] as String,
        DateTime.parse(json['expiry'] as String),
      ),
      json['refresh_token'] as String?,
      (json['scopes'] as List).cast<String>(),
    );
    final scopes = credentials.scopes.toSet();
    final required = [kScopeModify, if (needsSend) kScopeSend];
    if (required.every(scopes.contains)) {
      return autoRefreshingClient(id, credentials, http.Client());
    }
    stdout.writeln(scopes.contains(kScopeModify)
        ? 'Zapisany token nie ma uprawnienia do wysyłki. '
            'Zaloguj się jeszcze raz, żeby je nadać.'
        : 'Zapisany token nie wystarcza. Zaloguj się jeszcze raz.');
  }

  final client = await clientViaUserConsent(id, kGmailScopes, (url) {
    stdout.writeln('Zaloguj się w przeglądarce na $kInboxEmail. '
        'Jeśli okno się nie otworzyło, wejdź na:\n$url');
    // Otwieramy sami, bo link kopiowany z terminala bywa ucinany.
    final opener = Platform.isMacOS ? 'open' : 'xdg-open';
    Process.run(opener, [url]).ignore();
  });
  writeText(tokenFile.path, jsonEncode({
    'token_type': client.credentials.accessToken.type,
    'access_token': client.credentials.accessToken.data,
    'expiry': client.credentials.accessToken.expiry.toUtc().toIso8601String(),
    'refresh_token': client.credentials.refreshToken,
    'scopes': client.credentials.scopes,
  }));
  return client;
}
