String _monthToStr(DateTime date, {bool shortMonth = false, bool showDay = true}){
    switch (date.month) {
      case 1:
        return shortMonth ? 'sty' : (showDay ? 'stycznia' : 'styczeń');
      case 2:
        return shortMonth ? 'lut' : (showDay ? 'lutego' : 'luty');
      case 3:
        return shortMonth ? 'mar' : (showDay ? 'marca' : 'marzec');
      case 4:
        return shortMonth ? 'kwi' : (showDay ? 'kwietnia' : 'kwiecień');
      case 5:
        return shortMonth ? 'maj' : (showDay ? 'maja' : 'maj');
      case 6:
        return shortMonth ? 'cze' : (showDay ? 'czerwca' : 'czerwiec');
      case 7:
        return shortMonth ? 'lip' : (showDay ? 'lipca' : 'lipiec');
      case 8:
        return shortMonth ? 'sie' : (showDay ? 'sierpnia' : 'sierpień');
      case 9:
        return shortMonth ? 'wrz' : (showDay ? 'września' : 'wrzesień');
      case 10:
        return shortMonth ? 'paź' : (showDay ? 'października' : 'październik');
      case 11:
        return shortMonth ? 'lis' : (showDay ? 'listopada' : 'listopad');
      case 12:
        return shortMonth ? 'gru' : (showDay ? 'grudnia' : 'grudzień');
      default:
        return '';
    }

}

String _timeToStr(DateTime date, {bool showSeconds = false}){
  String hours = (date.hour<10?'0':'') + date.hour.toString();
  String minutes = (date.minute<10?'0':'') + date.minute.toString();

  if(!showSeconds)
    return '$hours:$minutes'.trimLeft();

  String seconds = (date.second<10?'0':'') + date.second.toString();

  return '$hours:$minutes:$seconds';
}

String dateToString(
    DateTime? date,
    { bool? showYear=true,
      bool showMonth=true,
      bool showDay=true,
      bool withTime=false,
      String dateTimeSep=' ',
      bool showSeconds=false,
      bool shortMonth=false,
      String yearAbbr='r.'
    }){

  // showYear == null means that the year will be shown only if it different
  // from the current year.

  if(date == null)
    return '-';

  bool _showYear = showYear??DateTime.now().year!=date.year;

  String day = '';
  if(showDay)
    day = date.day.toString();

  String month = '';
  if(showMonth)
    month = ' ${_monthToStr(date, shortMonth: shortMonth, showDay: showDay)}';

  String year = '';
  if(_showYear == true)
    year = ' ' + date.year.toString() + ' $yearAbbr';

  if(!withTime)
    return '$day$month$year'.trimLeft();

  String time = _timeToStr(date, showSeconds: showSeconds);

  return '$day$month$year$dateTimeSep$time'.trimLeft();

}

String dateRangeToString(
    DateTime dateStart,
    DateTime dateEnd,
    { bool showYear=true,
      bool showMonth=true,
      bool showDay=true,
      bool withTime=false,
      String dateTimeSep=' ',
      bool showSeconds=false,
      bool shortMonth=false,
      String yearAbbr='r.'
    }){

  bool yearsMatch = dateStart.year == dateEnd.year;

  String fullString = '${dateToString(
      dateStart,
      showYear: showYear,
      showMonth: showMonth,
      showDay: showDay,
      withTime: withTime,
      dateTimeSep: dateTimeSep,
      showSeconds: showSeconds,
      shortMonth: shortMonth,
      yearAbbr: yearAbbr
  )} - ${dateToString(
      dateEnd,
      showYear: showYear,
      showMonth: showMonth,
      showDay: showDay,
      withTime: withTime,
      dateTimeSep: dateTimeSep,
      showSeconds: showSeconds,
      shortMonth: shortMonth,
      yearAbbr: yearAbbr
  )}';

  if(!yearsMatch)
    return fullString;

  String timeStart = '';
  if(withTime)
    timeStart = _timeToStr(dateStart, showSeconds: showSeconds);

  String timeEnd = '';
  if(withTime)
    timeEnd = _timeToStr(dateEnd, showSeconds: showSeconds);

  String year = '';
  if(showYear)
    year = ' ' + dateStart.year.toString() + ' $yearAbbr';

  if(dateStart.month != dateEnd.month){
    String startMonth = _monthToStr(dateStart, shortMonth: shortMonth, showDay: showDay);
    String endMonth = _monthToStr(dateEnd, shortMonth: shortMonth, showDay: showDay);

    if(withTime)
      return fullString;
    else
      return '${dateStart.day} $startMonth - ${dateEnd.day} $endMonth$year';

  }

  String month = _monthToStr(dateStart, shortMonth: shortMonth, showDay: showDay);

  if(dateStart.day != dateEnd.day){
    if(withTime)
      return fullString;
    else
      return '${dateStart.day} $month - ${dateEnd.day} $month$year';
  }

  String day = '';
  if(showDay)
    day = dateStart.day.toString();

  if(withTime)
    return '$day $month$year$dateTimeSep$timeStart - $timeEnd';
  else
    return '$day $month$year';

}

String durationToString(Duration? duration, {bool onlyBiggestTimeFactor = false}){

  if(duration == null) return '-';

  int seconds = duration.inSeconds % 60;
  int minutes = duration.inMinutes % 60;
  int hours = duration.inHours % 24;
  int days = duration.inDays % 7;
  int weeks = duration.inDays ~/ 7;

  List<String> resultParts = [];

  if(weeks == 1) resultParts.add('$weeks tydz.');
  else if(weeks > 1) resultParts.add('$weeks tyg.');

  if(days == 1) resultParts.add('$days dzień');
  else if(days > 1) resultParts.add('$days dni');
  if(onlyBiggestTimeFactor && resultParts.isNotEmpty) return resultParts.first;

  if(hours != 0) resultParts.add('$hours godz.');
  if(onlyBiggestTimeFactor && resultParts.isNotEmpty) return resultParts.first;

  if(minutes != 0) resultParts.add('$minutes min.');
  if(onlyBiggestTimeFactor && resultParts.isNotEmpty) return resultParts.first;

  if(seconds != 0) resultParts.add('$seconds sek.');

  return resultParts.join(' ');

}

String timeAgo(DateTime now, DateTime past){

  Duration diff = now.difference(past);

  // if(diff < const Duration(seconds: 60))
  //   return '${diff.inSeconds } sek.';
  //
  // if(diff < const Duration(minutes: 60))
  //   return '${diff.inMinutes } min.';
  //
  // if(diff < const Duration(hours: 24))
  //   return '${diff.inHours } godz.';
  //
  // if(diff < const Duration(days: 7))
  //   return '${diff.inDays } dni';

  if(diff < const Duration(days: 7))
    return durationToString(diff, onlyBiggestTimeFactor: true);

  if(now.year == past.year)
    return dateToString(past, showYear: false);

  return dateToString(past, shortMonth: true);
}