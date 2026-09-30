import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'hrcpsng.dart';
import 'eml.dart';
import 'mailbox.dart';
import 'model.dart';
import 'package:harcapp_core/values/strings.dart';

/// Jeden zakres na wszystko: `gmail.modify` etykietuje, czyta, zakłada
/// szkice i wysyła — `messages.send` i `drafts.send` go przyjmują
/// (`drafts.send` nie przyjmuje nawet `gmail.send`).
const String kGmailScope = GmailApi.gmailModifyScope;

String defaultCredentialsPath() => p.join('secrets', 'credentials.json');
String defaultTokenPath() => p.join('secrets', 'gmail_token.json');

class GmailMailbox implements Mailbox {
  GmailMailbox(this._api);

  final GmailApi _api;
  final Map<String, String> _idByName = {};
  final Map<String, String> _nameById = {};
  /// Wątek każdego mejla, który przeszedł przez [listIds] — `messages.list`
  /// oddaje go za darmo, a pytanie o niego osobno kosztuje `get`.
  final Map<String, String> _threadById = {};

  @override
  String threadOf(String messageId) => _threadById[messageId] ?? messageId;

  /// Gmail rozlicza limit w **jednostkach**, nie w requestach: 6000 na minutę
  /// na użytkownika. Metody kosztują różnie — `messages.get` i `attachments.get`
  /// po 20, `threads.get` 40, `batchModify` 50 za paczkę do 1000 mejli, `list` 5,
  /// `labels.list` 1 (tabela: developers.google.com/workspace/gmail/api/reference/quota).
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
  static const int _costThreadGet = 40;
  static const int _costList = 5;
  static const int _costModify = 50;
  static const int _costLabelCreate = 5;
  static const int _costLabelList = 1;
  static const int _costSend = 100;
  static const int _costDraftWrite = 10;
  static const int _costDraftUpdate = 15;
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

  /// Zapytanie w ramach limitu. Przy przekroczonym limicie i przy błędach
  /// przejściowych (5xx, zerwane połączenie) czekamy i próbujemy jeszcze raz —
  /// inaczej jeden 503 w połowie `scan` kosztował całe pobieranie od nowa.
  ///
  /// [idempotent] = `false` dla wysyłki i zakładania: tam błąd przejściowy
  /// mógł przyjść **po** wykonaniu, a drugi raz to drugi mejl albo drugi
  /// szkic. Przekroczony limit ponawiamy zawsze — Gmail odrzuca go przed
  /// wykonaniem.
  Future<T> _call<T>(Future<T> Function() fn,
      {int cost = _costList, bool idempotent = true}) async {
    var wait = const Duration(seconds: 5);
    for (var attempt = 1;; attempt++) {
      await _spend(cost);
      try {
        return await fn();
      } catch (e) {
        final kind = gmailRetryKind(e);
        final retry = kind == GmailRetry.quota ||
            (kind == GmailRetry.transient && idempotent);
        if (!retry || attempt >= 7) rethrow;
        stdout.writeln('${kind == GmailRetry.quota ? 'Limit Gmail API' : 'Chwilowy błąd Gmaila'}'
            ', czekam ${wait.inSeconds}s…');
        await Future.delayed(wait);
        wait *= 2;
        // Limit i tak przekroczony — wiadro do zera, żeby nie dobijać.
        if (kind == GmailRetry.quota) _units = 0;
      }
    }
  }

  /// Pobiera mejle kilkoma strumieniami naraz. Tempo i tak pilnuje [_spend];
  /// równoległość służy tylko temu, żeby czekanie na odpowiedź nie marnowało
  /// limitu, który w tym czasie się odnawia.
  @override
  Future<List<ContribMessage>> getMessages(
    List<String> ids, {
    void Function(int done, int total)? onProgress,
  }) async {
    const concurrency = 8;
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

  static Future<GmailMailbox> connect({
    required File credentialsFile,
    required File tokenFile,
  }) async {
    if (!credentialsFile.existsSync()) {
      throw FileSystemException(
          'Brak credentials.json, zobacz README', credentialsFile.path);
    }
    final clientId = _clientIdFromFile(credentialsFile);
    final mailbox = GmailMailbox(
        GmailApi(await _authClient(clientId, tokenFile)));
    await mailbox._loadLabels();
    return mailbox;
  }

  /// Gmail zwraca od najnowszych; domyślnie bierzemy [limit] najstarszych.
  @override
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

  /// Cały mejl jednym zapytaniem (`format: raw`) — z załącznikami, bez
  /// osobnego `attachments.get`, i tym samym czytnikiem, co `explain`.
  ///
  /// Mejl, którego nie da się rozebrać, nie zatrzymuje przebiegu: wchodzi
  /// z pustą treścią i znacznikiem [ContribMessage.readError], więc kończy
  /// jako „nie do odczytania” zamiast wracać przy każdym `scan`.
  Future<ContribMessage> getMessage(String id) async {
    final msg = await _call(
        () => _api.users.messages.get('me', id, format: 'raw'),
        cost: _costGet);
    final labels = {
      for (final lid in msg.labelIds ?? const <String>[]) _nameById[lid] ?? lid,
    };
    final receivedAt = msg.internalDate == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(int.parse(msg.internalDate!), isUtc: true);
    try {
      return ContribMessage.fromEmlBytes(
        base64Url.decode(base64Url.normalize(msg.raw ?? '')),
        id: msg.id ?? id,
        threadId: msg.threadId,
        labels: labels,
        receivedAt: receivedAt,
      );
    } on Object catch (e) {
      return ContribMessage(
        id: msg.id ?? id,
        threadId: msg.threadId,
        body: '',
        date: receivedAt,
        labels: labels,
        readError: '$e',
      );
    }
  }

  /// Odpowiedź w wątku [target] jako szkic: ten sam `threadId`, `In-Reply-To`
  /// i `References`, żeby u autora wpadła pod jego zgłoszenie. Do przejrzenia
  /// i poprawienia w Gmailu, zanim pójdzie w świat. Zwraca id szkicu.
  @override
  Future<String> draftReplyTo(ReplyTarget target, String text) async {
    final draft = await _call(
        () => _api.users.drafts.create(
            Draft()..message = _replyMessage(target, text), 'me'),
        cost: _costDraftWrite, idempotent: false);
    return draft.id!;
  }

  /// Szkice po wątku, w którym siedzą. Jedno zapytanie zamiast jednego na
  /// autora — `drafts.list` i tak oddaje `message.threadId` przy każdym.
  @override
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
  /// dochodzi kolejna sprawa (np. uwaga z przeglądu do piosenki autora, który
  /// i tak miał dostać blok o starej apce).
  @override
  Future<void> updateDraft(String draftId, ReplyTarget target, String text) async {
    await _call(
        () => _api.users.drafts.update(
            Draft()..message = _replyMessage(target, text), 'me', draftId),
        cost: _costDraftUpdate);
  }

  /// Treść szkicu jako czysty tekst — po to, żeby nie nadpisać Twoich
  /// ręcznych poprawek z Gmaila. `null`, gdy nie da się jej odczytać.
  @override
  Future<String?> draftBody(String draftId) async {
    final draft = await _call(
        () => _api.users.drafts.get('me', draftId, format: 'raw'),
        cost: _costGet);
    final raw = draft.message?.raw;
    if (raw == null) return null;
    // Ten sam czytnik, co przy zgłoszeniach: schodzi w głąb
    // `multipart/mixed → multipart/alternative → text/plain`, w co Gmail
    // owija szkic po pierwszym otwarciu w edytorze.
    final text = RawMail.parse(base64Url.decode(base64Url.normalize(raw))).plainText;
    return text.trim().isEmpty ? null : text;
  }

  /// Kasuje szkic — nic nie poszło w świat, więc to wystarczy. Narzędzie
  /// kasuje tylko szkice bez Twojego tekstu.
  @override
  Future<void> deleteDraft(String draftId) async {
    await _call(() => _api.users.drafts.delete('me', draftId),
        cost: _costDraftWrite, idempotent: false);
  }

  /// Wysyła gotowy szkic — z Twoimi poprawkami z Gmaila, jeśli są.
  @override
  Future<void> sendDraft(String draftId) async {
    await _call(() => _api.users.drafts.send(Draft()..id = draftId, 'me'),
        cost: _costSend, idempotent: false);
  }

  /// Jedno `threads.get` na wątek: same etykiety i dwa nagłówki. Szkice
  /// (`DRAFT`) nie są ani naszą wysłaną, ani cudzą przychodzącą, więc odpadają.
  /// Nagłówka `From` nie potrzeba do rozstrzygnięcia, kto pisał — wiadomość
  /// bez `SENT` w naszej skrzynce jest przychodząca.
  @override
  Future<ThreadSummary> threadSummary(String threadId) async {
    final thread = await _call(
        () => _api.users.threads.get('me', threadId,
            format: 'metadata', metadataHeaders: ['From', 'Subject']),
        cost: _costThreadGet);
    final messages = [
      for (final m in thread.messages ?? const <Message>[])
        if (!(m.labelIds ?? const <String>[]).contains('DRAFT')) m,
    ];
    final first = messages.isEmpty ? null : _headersOf(messages.first.payload);
    return ThreadSummary.fromSent(
      threadId,
      [
        for (final m in messages)
          (id: m.id!, sent: (m.labelIds ?? const <String>[]).contains('SENT')),
      ],
      subject: first?['subject'] ?? '',
      from: first?['from'] ?? '',
    );
  }

  /// Dane potrzebne do odpowiedzi. Osobny strzał po nagłówki, bo
  /// [ContribMessage] ich nie niesie.
  @override
  Future<ReplyTarget> replyTarget(String messageId, {required String to}) async {
    final msg = await _call(
        () => _api.users.messages.get('me', messageId,
            format: 'metadata', metadataHeaders: ['Subject', 'Message-ID', 'References']),
        cost: _costGet);
    final headers = _headersOf(msg.payload);
    return ReplyTarget(
      messageId: msg.id ?? messageId,
      threadId: msg.threadId ?? messageId,
      to: to,
      subject: headers['subject'] ?? '',
      rfcMessageId: headers['message-id'],
      references: headers['references'],
    );
  }

  /// Nasze wysłane wiadomości po wątkach, bez szkiców (`in:sent` ich nie
  /// łapie). Jedna lista na całą skrzynkę zamiast `threads.get` na wątek.
  @override
  Future<Map<String, List<String>>> sentIdsByThread() async {
    final out = <String, List<String>>{};
    for (final id in await listIds('in:sent')) {
      if (_threadById[id] case final t?) out.putIfAbsent(t, () => []).add(id);
    }
    return out;
  }

  /// Etykiety `song/*` całej skrzynki: jedno zapytanie na etykietę zamiast
  /// jednego na mejl. Przy przebiegu z setkami mejli to różnica między
  /// kilkunastoma strzałami a kilkuset. Mejle bez żadnej `song/*` nie mają klucza.
  ///
  /// Bierzemy nazwy prosto ze skrzynki, nie z [kAllSongLabels] — inaczej
  /// etykieta dorobiona ręcznie poza taksonomią byłaby dla nas niewidzialna.
  @override
  Future<Map<String, Set<String>>> songLabelsByMessage() async {
    final out = <String, Set<String>>{};
    for (final name in _idByName.keys.where(isSongLabel).toList()) {
      for (final id in await listIds(labelQuery(name))) {
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
  @override
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
          cost: _costLabelCreate, idempotent: false);
      _idByName[name] = created.id!;
      _nameById[created.id!] = name;
    }
  }

  /// Ta sama zmiana na całej paczce mejli: `batchModify` bierze do 1000 naraz.
  /// Nazw, których w skrzynce nie ma, nie zdejmujemy — nie ma czego.
  @override
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

/// Co zrobić z błędem zapytania do Gmaila.
enum GmailRetry {
  /// Przekroczony limit — Gmail odrzucił zapytanie przed wykonaniem.
  quota,
  /// Chwilowa awaria (5xx, zerwane połączenie) — mogła przyjść już po
  /// wykonaniu, więc ponawiamy tylko to, co da się bezpiecznie powtórzyć.
  transient,
  /// Prawdziwy błąd — ponawianie nic nie da.
  none,
}

GmailRetry gmailRetryKind(Object e) {
  if (e is DetailedApiRequestError) {
    final message = (e.message ?? '').toLowerCase();
    if (e.status == 429 ||
        (e.status == 403 && (message.contains('quota') || message.contains('rate limit')))) {
      return GmailRetry.quota;
    }
    final status = e.status;
    if (status != null && status >= 500 && status < 600) return GmailRetry.transient;
    return GmailRetry.none;
  }
  if (e is SocketException || e is http.ClientException || e is TimeoutException) {
    return GmailRetry.transient;
  }
  return GmailRetry.none;
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

Future<AutoRefreshingAuthClient> _authClient(ClientId id, File tokenFile) async {
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
    if (credentials.scopes.contains(kGmailScope)) {
      return autoRefreshingClient(id, credentials, http.Client());
    }
    stdout.writeln('Zapisany token nie wystarcza. Zaloguj się jeszcze raz.');
  }

  final client = await clientViaUserConsent(id, [kGmailScope], (url) {
    stdout.writeln('Zaloguj się w przeglądarce na $kHarcappEmail. '
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
