/// Single source of truth for the harcapp web host. Lives in its own file
/// (and not on `HarcappLinks`) so that lower-level data classes — e.g.
/// `KonspektInternalLinkAttachment` in `konspekts/konspekt.dart` — can build
/// URLs without importing `harcapp_links.dart`, which itself depends on
/// konspekt types and would form an import cycle.
const String harcappScheme = 'https';
const String harcappHost = 'harcapp.web.app';
const String harcappBaseUrl = '$harcappScheme://$harcappHost';
