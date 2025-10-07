import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

void post(Function function) => WidgetsBinding.instance.addPostFrameCallback((_) => function());

Future<void> postAsync(Function function) async {
  Completer<void> completer = Completer<void>();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await function();
    completer.complete();
  });

  return completer.future;
}

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
