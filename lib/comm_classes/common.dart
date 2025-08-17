import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

int charToInt(String c) {
  switch (c) {
    case ' ': return 0;
    case 'a': return 1;
    case 'ą': return 2;
    case 'á': return 3;
    case 'b': return 4;
    case 'c': return 5;
    case 'ć': return 6;
    case 'd': return 7;
    case 'e': return 8;
    case 'ę': return 9;
    case 'é': return 10;
    case 'ě': return 11;
    case 'f': return 12;
    case 'g': return 13;
    case 'h': return 14;
    case 'i': return 15;
    case 'í': return 16;
    case 'j': return 17;
    case 'k': return 18;
    case 'l': return 19;
    case 'ł': return 20;
    case 'm': return 21;
    case 'n': return 22;
    case 'ń': return 23;
    case 'o': return 24;
    case 'ó': return 25;
    case 'p': return 26;
    case 'q': return 27;
    case 'r': return 28;
    case 'ř': return 29;
    case 's': return 30;
    case 'ś': return 31;
    case 'š': return 32;
    case 't': return 33;
    case 'u': return 34;
    case 'v': return 35;
    case 'w': return 36;
    case 'x': return 37;
    case 'y': return 38;
    case 'ý': return 39;
    case 'z': return 40;
    case 'ź': return 41;
    case 'ż': return 42;
    case 'ž': return 43;

    case '0': return 44;
    case '1': return 45;
    case '2': return 46;
    case '3': return 47;
    case '4': return 48;
    case '5': return 49;
    case '6': return 50;
    case '7': return 51;
    case '8': return 52;
    case '9': return 53;
    default: return -1;
  }
}

int compareText(String s1, String s2, {bool replaceStrangeChars = true}){

  if(replaceStrangeChars) {
    RegExp regexp = RegExp(r'[^a-ząáćęéěíłńóřśšýźżž0-9 ]');
    s1 = s1.toLowerCase().replaceAll(regexp, '');
    s2 = s2.toLowerCase().replaceAll(regexp, '');
  }

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
      .replaceAll('ě', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ł', 'l')
      .replaceAll('ń', 'n')
      .replaceAll('ó', 'o')
      .replaceAll('ö', 'o')
      .replaceAll('ő', 'o')
      .replaceAll('ř', 'r')
      .replaceAll('ś', 's')
      .replaceAll('š', 's')
      .replaceAll('š', 's')
      .replaceAll('ú', 'u')
      .replaceAll('ü', 'u')
      .replaceAll('ű', 'u')
      .replaceAll('ý', 'y')
      .replaceAll('ź', 'z')
      .replaceAll('ż', 'z')
      .replaceAll('ž', 'z');
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

List<String> remPolCharsList(Iterable<String> strings){
  List<String> result = [];
  for(String string in strings)
    result.add(remPolChars(string));

  return result;
}

List<String> remSpecCharsList(Iterable<String> strings){
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
