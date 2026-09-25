/// Odpowiedzi do autorów zgłoszeń — składane z kawałków, nie pisane w całości.
///
/// Jeden mejl potrafi nieść kilka spraw naraz: Twoją uwagę z przeglądu
/// („brakuje chwytów”) i blok o starej apce, jeśli zgłoszenie przyszło ze
/// starej wersji. Dlatego treść jest **funkcją** tego, co mamy do powiedzenia,
/// a nie jednym gotowym napisem: dopisanie kolejnej sprawy przelicza mejl od
/// nowa, zamiast kazać go przepisywać ręcznie.
library;

import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/submission/submission_email.dart';

/// Zawsze na początku — mejl zaczyna się od podziękowania, nie od pretensji.
const String kReplyGreeting = 'Dzięki za piosenki :)';

/// Zawsze na końcu.
const String kReplyClosing = 'Pozdrowienia!';

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

/// Prośba o osobny mejl na każdą piosenkę — odpowiedź w wątku z etykietą nie
/// wraca już do kolejki. To samo zdanie, co [kSubmissionOneSongPerMailNote].
const String kOneSongPerMailReplyBlock =
    'Przy okazji: każdą kolejną piosenkę wyślij proszę osobnym mejlem, '
    'a nie odpowiedzią na ten — inaczej może mi umknąć.';

/// Propozycja do pola „Odpowiedź” z pastylek `missing-*`.
///
/// **Cały mejl, jaki pójdzie do autora** — z powitaniem, blokiem o starej apce
/// ([oldApp]), prośbą o osobny mejl na piosenkę i pożegnaniem. Co widzisz
/// w polu, to dostanie autor; po drodze nic się nie dokleja.
///
/// `null`, gdy żadna pastylka nie zasługuje na pytanie do autora (duplikat,
/// zgoda, dopisek…).
///
/// Kolejność braków zawsze jak w [SongIssue], nie jak na pastylkach: „chwytów
/// i linku do YT” ma brzmieć tak samo, niezależnie od tego, która pastylka
/// była pierwsza.
String? proposeContribReplyNote(
  Iterable<SongIssue> issues, {
  bool oldApp = false,
  bool oneSongPerMail = true,
}) {
  final present = issues.toSet();
  final phrases = [
    for (final issue in SongIssue.values)
      if (present.contains(issue))
        if (_askPhrase(issue) case final phrase?) phrase,
  ];
  if (phrases.isEmpty) return null;
  return [
    kReplyGreeting,
    'Niestety widzę, że brakuje ${_joinPolish(phrases)}.',
    'Prześlij proszę poprawione, żebym mógł zerknąć czy reszta jest ok.',
    if (oldApp) kOldAppReplyBlock,
    if (oneSongPerMail) kOneSongPerMailReplyBlock,
    kReplyClosing,
  ].join('\n\n');
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

/// Treść odpowiedzi do autora.
///
/// [reviewNotes] to Twoje teksty z pola „Odpowiedź do autora” w edytorze. Idą
/// **dosłownie**: każda jest już całym mejlem (patrz [proposeContribReplyNote]),
/// więc nic się do nich nie dokleja — inaczej autor dostałby co innego, niż
/// widziałeś w polu. Lista, bo jeden autor mógł przysłać kilka piosenek.
///
/// [oldApp] i [oneSongPerMail] działają **tylko wtedy, gdy uwag nie ma**: to
/// jedyny przypadek, w którym mejl nie ma autora i narzędzie składa go samo.
/// Gdy piszesz sam, blok o starej apce dokładasz sobie w propozycji.
///
/// Pusty wynik (ani uwagi, ani starej apki) znaczy „nie ma po co pisać” —
/// zwracamy `null`, żeby wołający nie tworzył pustego szkicu.
String? composeContribReply({
  Iterable<String> reviewNotes = const [],
  bool oldApp = false,
  bool oneSongPerMail = false,
}) {
  final trimmed = [
    for(final n in reviewNotes) if(n.trim().isNotEmpty) n.trim(),
  ];
  if (trimmed.isNotEmpty) return trimmed.join('\n\n');
  if (!oldApp) return null;
  return [
    kReplyGreeting,
    kOldAppReplyBlock,
    if (oneSongPerMail) kOneSongPerMailReplyBlock,
    kReplyClosing,
  ].join('\n\n');
}

/// Czy treść wygląda na mejl złożony przez [composeContribReply]: powitanie
/// na początku, zakończenie na końcu. Po tym piosenkomat poznaje własny
/// szkic — taki wolno przeliczyć od nowa. Wszystko inne to ręczna robota
/// w Gmailu i zostaje nietknięte.
///
/// Środek nie jest sprawdzany celowo: uwaga z przeglądu mogła się zmienić,
/// a poprzedniej wersji nikt nie pamięta. Zamiast zgadywać, co w środku jest
/// stare, wołający wypisuje akapity, które przy przeliczeniu wypadają.
bool isToolShapedReply(String body) {
  final paragraphs = _paragraphs(body);
  return paragraphs.length >= 2 &&
      paragraphs.first == kReplyGreeting &&
      paragraphs.last == kReplyClosing;
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
