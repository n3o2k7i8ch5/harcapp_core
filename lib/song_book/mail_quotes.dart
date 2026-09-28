/// Cytowanie w mejlach zwrotnych: znaczniki `>` i nagłówek „W dniu … napisał(a):”.
/// Jedno miejsce dla parsera zgłoszeń i piosenkomatu — inaczej każdy
/// rozpoznaje cytat po swojemu.
library;

/// Znak cytatu na początku linii (`> `, `>> `, `> > `) razem z wcięciem przed
/// nim. Linia bez `>` nie pasuje — jej wcięcie zostaje.
final RegExp quotePrefixRe = RegExp(r'^\s*>[>\s]*');

/// Czy linia jest cytatem.
bool isQuotedLine(String line) => quotePrefixRe.hasMatch(line);

/// Treść bez linii cytatu.
String withoutQuotedLines(String body) =>
    body.split('\n').where((l) => !isQuotedLine(l)).join('\n');

/// „napisał”, „napisała” i gmailowe „napisał(a)” — z **dosłownymi** nawiasami.
const _wrote = r'(?:napisał(?:\(a\)|a)?|pisze|wrote)';

/// Linia, którą klient pocztowy stawia nad cytatem:
/// - Gmail: `W dniu pt., 12 wrz 2026 o 10:15 Jan <jan@x.pl> napisał(a):`,
///   czasem bez „W dniu”;
/// - Thunderbird: `W dniu 12.09.2026 o 10:15, Jan Kowalski pisze:`;
/// - Apple Mail: `Wiadomość napisana przez Jan <jan@x.pl> w dniu 12.09.2026, o godz. 10:15:`;
/// - po angielsku: `On Fri, Sep 12, 2026 at 10:15 AM Jan <jan@x.pl> wrote:`;
/// - sam nadawca z adresem: `Jan Kowalski <jan@x.pl> napisał(a):`.
final RegExp _quoteHeaderRe = RegExp(
  '^(?:'
  'On .+ wrote:'
  '|(?:W dniu|Dnia) .+ $_wrote:'
  '|(?:pon|wt|śr|czw|pt|sob|niedz)\\., .+ $_wrote:'
  '|Wiadomość napisana przez .+:'
  '|[^<>]+ <[^<>@\\s]+@[^<>\\s]+> $_wrote:'
  r')$',
);

/// Jak zaczyna się nagłówek cytatu, który klient mógł złamać na dwie linie.
/// Tylko po takim początku sklejamy linię z następną — inaczej ostatnie zdanie
/// autora przed nagłówkiem („Pozdrawiam”) zniknęłoby razem z nim.
final RegExp _quoteHeaderStartRe =
    RegExp(r'^(?:On |W dniu |Dnia |Wiadomość napisana przez |(?:pon|wt|śr|czw|pt|sob|niedz)\., )');

/// Czy [line] (albo [line] sklejona z następną) to nagłówek cytatu.
bool isQuoteHeader(String line) => _quoteHeaderRe.hasMatch(line.trim());

/// Własny tekst odpowiedzi: bez linii cytatu i bez nagłówka, który klient
/// stawia nad cytatem — także złamanego na dwie linie.
String ownReplyText(String body) {
  final lines = [for (final l in body.split('\n')) if (!isQuotedLine(l)) l];
  final out = <String>[];
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (isQuoteHeader(line)) continue;
    if (i + 1 < lines.length &&
        _quoteHeaderStartRe.hasMatch(line) &&
        isQuoteHeader('$line ${lines[i + 1].trim()}')) {
      i++;
      continue;
    }
    out.add(lines[i]);
  }
  return out.join('\n');
}
