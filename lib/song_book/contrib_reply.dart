/// Odpowiedzi do autorów zgłoszeń — składane z kawałków, nie pisane w całości.
///
/// Jeden mejl na piosenkę, w jej wątku. Twoja jest tylko sprawa („brakuje
/// chwytów”); powitanie, blok o starej apce, pożegnanie i stopkę dokłada
/// narzędzie. Dlatego treść jest **funkcją** tego, co mamy do powiedzenia,
/// a nie jednym gotowym napisem: zmiana uwagi przelicza mejl od nowa.
library;

import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';

/// Zawsze na początku — mejl zaczyna się od podziękowania, nie od pretensji.
const String kReplyGreeting = 'Dzięki za piosenki :)';

/// Zawsze na końcu.
const String kReplyClosing = 'Czuwaj!';

/// Blok o najstarszej, nierozwijanej apce. Doklejany, gdy zgłoszenie przyszło
/// z niej — niezależnie od tego, czy piosenka weszła do śpiewnika.
const String kOldAppReplyBlock =
    'Ważne info!\n'
    'Stara wersja apki, którą masz zainstalowaną, NIE JEST JUŻ ROZWIJANA. '
    'Żeby "przesiąść się" na nową wersję apki wystarczy pobrać HarcAppa od nowa:\n'
    '\n'
    '[Android]\n'
    'https://play.google.com/store/apps/details?id=com.daniwan.harcapp\n'
    '\n'
    '[iOS]\n'
    'https://apps.apple.com/us/app/harcapp/id6754627071\n'
    '\n'
    'Nowe piosenki lądują tylko w nowej wersji apki!\n'
    '\n'
    'Daj proszę przy okazji znać o tym w swoim środowisku! :)';

/// Kreska nad stopką. Nie `-- ` — to separator podpisu, który część klientów
/// pocztowych zwija albo wyszarza.
const String kReplyFooterRule = '――――――――――';

/// Stopka pod kreską, na samym końcu każdej odpowiedzi: stała reguła, nie
/// sprawa do tego autora. Odpowiedź w wątku z etykietą nie wraca do kolejki,
/// więc druga piosenka dosłana w nim by przepadła.
const String kReplyFooter = '$kReplyFooterRule\n'
    'Każdą kolejną piosenkę wyślij proszę osobnym mejlem — ten wątek dotyczy '
    'tylko tej jednej. Inaczej może mi umknąć.';

/// Propozycja do pola „Odpowiedź” z pastylek `missing-*`: **sama sprawa**.
/// Powitanie, blok o starej apce, pożegnanie i stopkę dokłada
/// [composeContribReply] — edytor pokazuje je na szaro wokół pola.
///
/// `null`, gdy żadna pastylka nie zasługuje na pytanie do autora (duplikat,
/// zgoda, dopisek…).
///
/// Kolejność braków zawsze jak w [SongIssue], nie jak na pastylkach: „chwytów
/// i linku do YT” ma brzmieć tak samo, niezależnie od tego, która pastylka
/// była pierwsza.
String? proposeContribReplyNote(Iterable<SongIssue> issues) {
  final present = issues.toSet();
  final phrases = [
    for (final issue in SongIssue.values)
      if (present.contains(issue))
        if (_askPhrase(issue) case final phrase?) phrase,
  ];
  if (phrases.isEmpty) return null;
  return 'Niestety widzę, że brakuje ${_joinPolish(phrases)}. '
      'Prześlij proszę poprawione, żebym mógł zerknąć czy reszta jest ok.';
}

/// Co idzie po „brakuje …” w uwadze do autora. `null` = ta pastylka nie
/// prosi autora o poprawkę — duplikat, zgoda, uszkodzony plik i reszta
/// zostają do ręcznego dopisania.
String? _askPhrase(SongIssue issue) => switch (issue) {
      SongIssue.missingTitle => 'tytułu',
      SongIssue.missingChords => 'chwytów',
      SongIssue.missingYoutube => 'linku do YT',
      _ => null,
    };

/// „a”, „a i b”, „a, b i c”.
String _joinPolish(List<String> items) {
  if (items.length == 1) return items.single;
  if (items.length == 2) return '${items[0]} i ${items[1]}';
  return '${items.sublist(0, items.length - 1).join(', ')} i ${items.last}';
}

/// Ramka mejla wokół Twojej odpowiedzi: [before] nad nią, [after] pod nią.
/// Tę samą edytor pokazuje na szaro przy polu, więc widzisz cały mejl, a ramki
/// nie da się ani zapomnieć, ani zepsuć.
({String before, String after}) contribReplyFrame({bool oldApp = false}) => (
      before: kReplyGreeting,
      after: [if (oldApp) kOldAppReplyBlock, kReplyClosing, kReplyFooter].join('\n\n'),
    );

/// Mejl w wątku **jednej** piosenki: ramka z [contribReplyFrame] wokół
/// [reviewNote] — Twojego tekstu z pola „Odpowiedź do autora”. Każda piosenka
/// dostaje własny mejl we własnym wątku, więc uwaga jest przy piosence,
/// a odpowiedź autora wraca tam, gdzie trzeba.
///
/// [oldApp]: zgłoszenie przyszło ze starej apki — blok o niej idzie w środku.
///
/// `null` = nie ma o czym pisać (ani odpowiedzi, ani starej apki), żeby
/// wołający nie tworzył pustego szkicu.
String? composeContribReply({String? reviewNote, bool oldApp = false}) {
  final note = reviewNote?.trim() ?? '';
  if (note.isEmpty && !oldApp) return null;
  final frame = contribReplyFrame(oldApp: oldApp);
  return [frame.before, if (note.isNotEmpty) note, frame.after].join('\n\n');
}

/// Czy treść wygląda na mejl złożony przez [composeContribReply]: powitanie
/// na początku, pożegnanie i stopka na końcu. Po tym piosenkomat poznaje
/// własny szkic — taki wolno przeliczyć od nowa. Wszystko inne to ręczna
/// robota w Gmailu i zostaje nietknięte.
///
/// Środek nie jest sprawdzany celowo: uwaga z przeglądu mogła się zmienić,
/// a poprzedniej wersji nikt nie pamięta. Zamiast zgadywać, co w środku jest
/// stare, wołający wypisuje akapity, które przy przeliczeniu wypadają.
bool isToolShapedReply(String body) {
  final paragraphs = _paragraphs(body);
  return paragraphs.length >= 3 &&
      paragraphs.first == kReplyGreeting &&
      paragraphs[paragraphs.length - 2] == kReplyClosing &&
      paragraphs.last == kReplyFooter;
}

/// Twoja odpowiedź wyjęta z mejla — do dymka w edytorze, bez ramki, którą
/// i tak widać przy polu. Odwrotność [composeContribReply]: z mejla w naszym
/// kształcie zdejmuje powitanie, blok o starej apce, pożegnanie i stopkę.
/// Mejl w innym kształcie (pisany ręcznie w Gmailu) wraca cały.
String replyNoteOf(String body) {
  if (!isToolShapedReply(body)) return body.trim();
  final frame = {
    kReplyGreeting,
    ..._paragraphs(kOldAppReplyBlock),
    kReplyClosing,
    kReplyFooter,
  };
  return [for (final a in _paragraphs(body)) if (!frame.contains(a)) a].join('\n\n');
}

/// Akapity z [oldBody], których nie ma w [newBody]. To, co wypadnie ze
/// szkicu przy przeliczeniu — do pokazania, nie do zgubienia po cichu.
List<String> paragraphsDroppedBy(String oldBody, String newBody) {
  final newParagraphs = _paragraphs(newBody).toSet();
  return [for (final a in _paragraphs(oldBody)) if (!newParagraphs.contains(a)) a];
}

List<String> _paragraphs(String body) => [
      for (final a in body.replaceAll('\r\n', '\n').split('\n\n'))
        if (a.trim().isNotEmpty) a.trim(),
    ];
