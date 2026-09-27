/// Cytowanie w mejlach zwrotnych: znaczniki `>` i linia „Dnia … napisał(a):”.
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

final RegExp _quoteHeaderRe = RegExp(
    r'^(On .+ wrote:|W dniu .+ napisał(a)?:|.+<.+@.+> napisał(a)?:|Dnia .+ napisał(a)?:)$');

/// Własny tekst odpowiedzi: bez linii cytatu i bez linii „Dnia … napisał(a):”,
/// którą klient stawia nad cytatem.
String ownReplyText(String body) => body
    .split('\n')
    .where((l) => !isQuotedLine(l))
    .where((l) => !_quoteHeaderRe.hasMatch(l.trim()))
    .join('\n');
