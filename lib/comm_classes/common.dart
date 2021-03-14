
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

String dateToString(DateTime date, {bool showYear=true, bool showMonth=true, bool showDay=true, bool withTime=false, bool shortMonth=false, String yearAbbr='r.'}){

  if(date == null)
    return '-';

  String day = '';
  if(showDay)
    day = date.day.toString();

  String month = '';
  if(showMonth)
    switch(date.month){
      case 1: month = shortMonth?'sty':'stycznia'; break;
      case 2: month = shortMonth?'lut':'lutego'; break;
      case 3: month = shortMonth?'mar':'marca'; break;
      case 4: month = shortMonth?'kwi':'kwietnia'; break;
      case 5: month = shortMonth?'maj':'maja'; break;
      case 6: month = shortMonth?'cze':'czerwca'; break;
      case 7: month = shortMonth?'lip':'lipca'; break;
      case 8: month = shortMonth?'sie':'sierpnia'; break;
      case 9: month = shortMonth?'wrz':'września'; break;
      case 10: month = shortMonth?'paź':'października'; break;
      case 11: month = shortMonth?'lis':'listopada'; break;
      case 12: month = shortMonth?'gru':'grudnia'; break;
    }

  String year = '';
  if(showYear)
    year = date.year.toString() + ' $yearAbbr';

  if(!withTime)
    return '$day $month $year';

  String hours = (date.hour<10?'0':'') + date.hour.toString();
  String minutes = (date.minute<10?'0':'') + date.minute.toString();
  String seconds = (date.second<10?'0':'') + date.second.toString();

  return '$day $month $year, $hours:$minutes:$seconds';

}