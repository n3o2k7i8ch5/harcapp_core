import 'package:web/web.dart' as web;

// For web only

void openInNewTab(String url) {
  web.window.open(url, '_blank');
}

void openPathInNewTab(String path) {
  final origin = web.window.location.origin; // e.g., https://yourdomain.com
  final fullUrl = '$origin$path';            // e.g., https://yourdomain.com/song_contribution_rules
  web.window.open(fullUrl, '_blank');
}