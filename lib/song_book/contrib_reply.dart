/// Odpowiedzi do autorów zgłoszeń — składane z kawałków, nie pisane w całości.
///
/// Jeden mejl potrafi nieść kilka spraw naraz: Twoją uwagę z przeglądu
/// („brakuje chwytów”) i blok o starej apce, jeśli zgłoszenie przyszło ze
/// starej wersji. Dlatego treść jest **funkcją** tego, co mamy do powiedzenia,
/// a nie jednym gotowym napisem: dopisanie kolejnej sprawy przelicza mejl od
/// nowa, zamiast kazać go przepisywać ręcznie.
library;

import 'package:harcapp_core/song_book/submission/submission_email.dart';

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

/// Jeden wątek to jedna piosenka: druga, dosłana odpowiedzią na wątek, który
/// ma już etykietę, nie istnieje dla narzędzia. Dlatego mówimy to autorowi
/// wprost, tym samym zdaniem, co apka na ekranie wysyłki i sam mejl
/// zgłoszeniowy ([kSubmissionOneSongPerMailNote]).
const String kOneSongPerMailReplyBlock =
    'Przy okazji: każdą kolejną piosenkę wyślij proszę osobnym mejlem, '
    'a nie odpowiedzią na ten — inaczej może mi umknąć.';

/// Treść odpowiedzi do autora.
///
/// [notes] to Twoje teksty z pola „Odpowiedź do autora” w edytorze — idą przed
/// blokiem o starej apce, bo dotyczą konkretnych piosenek, a blok jest ogólny.
/// Lista, bo jeden autor mógł przysłać kilka piosenek i do każdej dopisać coś
/// innego, a mejl idzie jeden. [oldApp] dokłada blok o starej apce.
///
/// Pusty wynik (ani uwagi, ani starej apki) znaczy „nie ma po co pisać” —
/// zwracamy `null`, żeby wołający nie tworzył pustego szkicu.
String? composeContribReply({
  Iterable<String> notes = const [],
  bool oldApp = false,
  bool oneSongPerMail = false,
}) {
  final trimmed = [
    for(final n in notes) if(n.trim().isNotEmpty) n.trim(),
  ];
  if (trimmed.isEmpty && !oldApp) return null;
  return [
    kReplyGreeting,
    ...trimmed,
    if (oldApp) kOldAppReplyBlock,
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
