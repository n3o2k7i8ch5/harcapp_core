import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

int charToInt(String c) {
  switch (c) {
    case ' ':
      return 0;
    case 'a':
      return 1;
    case 'ą':
      return 2;
    case 'b':
      return 3;
    case 'c':
      return 4;
    case 'ć':
      return 5;
    case 'd':
      return 6;
    case 'e':
      return 7;
    case 'ę':
      return 8;
    case 'f':
      return 9;
    case 'g':
      return 10;
    case 'h':
      return 11;
    case 'i':
      return 12;
    case 'j':
      return 13;
    case 'k':
      return 14;
    case 'l':
      return 15;
    case 'ł':
      return 16;
    case 'm':
      return 17;
    case 'n':
      return 18;
    case 'ń':
      return 19;
    case 'o':
      return 20;
    case 'ó':
      return 21;
    case 'p':
      return 22;
    case 'q':
      return 23;
    case 'r':
      return 24;
    case 's':
      return 25;
    case 'ś':
      return 26;
    case 't':
      return 27;
    case 'u':
      return 28;
    case 'v':
      return 29;
    case 'w':
      return 30;
    case 'x':
      return 31;
    case 'y':
      return 32;
    case 'z':
      return 33;
    case 'ź':
      return 34;
    case 'ż':
      return 35;

    case '0':
      return 36;
    case '1':
      return 37;
    case '2':
      return 38;
    case '3':
      return 39;
    case '4':
      return 40;
    case '5':
      return 41;
    case '6':
      return 42;
    case '7':
      return 43;
    case '8':
      return 44;
    case '9':
      return 45;
    default:
      return -1;
  }
}

int compareText(String s1, String s2){

  s1 = s1.toLowerCase()
      .replaceAll(RegExp(r'[^a-ząćęłńóśźżA-ZĄĆĘŁŃÓŚŹŻ0-9]'), '');

  s2 = s2.toLowerCase()
      .replaceAll(RegExp(r'[^a-ząćęłńóśźżA-ZĄĆĘŁŃÓŚŹŻ0-9]'), '');

  for(int i=0; i<min(s1.length, s2.length); i++){

    String c1 = s1[i];
    String c2 = s2[i];

    int int1 = charToInt(c1);
    int int2 = charToInt(c2);

    if(int1 != int2)
      return int1-int2;

  }

  return s1.length - s2.length;
}

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

List<String> remSpecCharsList(List<String> strings){
  List<String> result = [];
  for(String string in strings)
    result.add(remSpecChars(string));

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

class CannotLaunchUrlException implements Exception{

  String url;

  CannotLaunchUrlException(this.url);

  String toString() => 'CannotLaunchUrlException: $url';

}

void launchURL(String url) async {

  if(!url.startsWith('www') && !url.startsWith('http://') && !url.startsWith('https://'))
    url = 'www.' + url;

  if(!url.startsWith('http://') && !url.startsWith('https://'))
    url = 'https://' + url;

  if (await canLaunchUrlString(url))
    await launchUrlString(url);
  else
    throw CannotLaunchUrlException(url);

}
