import 'package:web/web.dart' as web;

void openInNewTab(String url) {
  web.window.open(url, '_blank');
}

void openPathInNewTab(String path) {
  final origin = web.window.location.origin;
  final fullUrl = '$origin$path';
  web.window.open(fullUrl, '_blank');
}