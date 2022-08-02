
import 'package:flutter/widgets.dart';

String remPolChars(String string){
  return string.toLowerCase()
      .replaceAll('ą', 'a')
      .replaceAll('á', 'a')
      .replaceAll('ć', 'c')
      .replaceAll('ę', 'e')
      .replaceAll('é', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ł', 'l')
      .replaceAll('ń', 'n')
      .replaceAll('ó', 'o')
      .replaceAll('ö', 'o')
      .replaceAll('ő', 'o')
      .replaceAll('ś', 's')
      .replaceAll('ú', 'u')
      .replaceAll('ü', 'u')
      .replaceAll('ű', 'u')
      .replaceAll('ź', 'z')
      .replaceAll('ż', 'z');
}

String remSpecChars(String string){
  return string.toLowerCase()
      .replaceAll('.', '')
      .replaceAll(',', '')
      .replaceAll('?', '')
      .replaceAll('!', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll(':', '')
      .replaceAll(';', '')
      .replaceAll('"', '');
}

List<String> remPolCharsList(List<String> strings){
  List<String> result = [];
  for(String string in strings)
    result.add(remPolChars(string));

  return result;
}

bool isDigit(String string){
  try {
    int.parse(string);
    return true;
  } on Exception{
    return false;
  }
}

void post(Function function) => WidgetsBinding.instance.addPostFrameCallback((_) => function());
