/// Cały tekst jest adresem e-mail — do sprawdzenia wpisanego pola.
RegExp regExpEmail = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)", caseSensitive: false);

/// Adres e-mail gdzieś w tekście, np. w nagłówku `From` albo we wklejonym
/// mejlu.
final RegExp regExpEmailInText = RegExp(r'[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}');

/// Adres w nawiasach ostrych, jak w `Jan <jan@x.pl>`; grupa 1 to sam adres.
final RegExp regExpAngledEmail = RegExp('<\\s*(${regExpEmailInText.pattern})\\s*>');
