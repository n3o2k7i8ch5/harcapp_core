const String noInternetMessage = 'Nie ma neta';

String get simpleErrorMessage{

  List<String> messages = [
    'Coś poszło nie tak',
    'Coś nie siadło',
    'Coś nie hula',
    'Coś nie styka',
    'Coś nie bangla',
    'Coś nie pykło',
    'Coś jest nie teges',
    'Coś tu nie gra',
  ];
  messages.shuffle();
  return messages[0];

}