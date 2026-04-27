import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/harc_forms/harc_form.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';
import 'package:harcapp_core/harcthought/poradnik/poradnik.dart';

/// Single source of truth for shareable harcapp.web.app links — used by:
///   - harcapp_web router
///   - harcapp_web Firebase Hosting redirects (firebase.json — keep in sync manually)
///   - harcapp mobile App Links / Universal Links + share buttons
///
/// Long forms are active. Short forms are reserved (constants only) — to be
/// enabled later by flipping the `short` flag on builders and registering them
/// in the router / hosting redirects / mobile intent filters.
class HarcappLinks {
  HarcappLinks._();

  static const String scheme = 'https';
  static const String host = 'harcapp.web.app';
  static const String baseUrl = '$scheme://$host';

  // ---------------- Path templates ----------------
  // Long forms (active).
  static const String poradnikListTemplate = '/poradnik';
  static const String poradnikItemTemplate = '/poradnik/:name';
  static const String poradnikItemFileTemplate = '/poradnik/:name/:ext';

  static const String konspektListTemplate = '/konspekty/:category';
  static const String konspektItemTemplate = '/konspekty/:category/:name';

  static const String formaListTemplate = '/konspekty/formy';
  static const String formaItemTemplate = '/konspekty/formy/:filename';

  // Short forms (reserved — not yet wired up).
  static const String poradnikItemTemplateShort = '/p/:name';
  static const String poradnikItemFileTemplateShort = '/p/:name/:ext';
  static const String konspektItemTemplateShort = '/k/:category/:name';
  static const String formaItemTemplateShort = '/f/:filename';

  // ---------------- go_router path helpers ----------------
  // Web router has separate routes per KonspektCategory; these helpers fill
  // the :category segment while leaving :name as a go_router placeholder.
  static String konspektCategoryListPath(KonspektCategory category, {bool short = false}) {
    final tpl = konspektListTemplate;
    return tpl.replaceFirst(':category', category.path);
  }

  static String konspektCategoryItemPath(KonspektCategory category, {bool short = false}) {
    final tpl = short ? konspektItemTemplateShort : konspektItemTemplate;
    return tpl.replaceFirst(':category', category.path);
  }

  // ---------------- Builders ----------------
  static String poradnik(String name, {bool short = false}) {
    final tpl = short ? poradnikItemTemplateShort : poradnikItemTemplate;
    return '$baseUrl${_fill(tpl, {'name': name})}';
  }

  static String poradnikFile(String name, FileFormat format, {bool short = false}) {
    final tpl = short ? poradnikItemFileTemplateShort : poradnikItemFileTemplate;
    return '$baseUrl${_fill(tpl, {'name': name, 'ext': format.extension})}';
  }

  static String konspekt(KonspektCategory category, String name, {bool short = false}) {
    final tpl = short ? konspektItemTemplateShort : konspektItemTemplate;
    return '$baseUrl${_fill(tpl, {'category': category.path, 'name': name})}';
  }

  static String forma(String filename, {bool short = false}) {
    final tpl = short ? formaItemTemplateShort : formaItemTemplate;
    return '$baseUrl${_fill(tpl, {'filename': filename})}';
  }

  static String poradnikOf(Poradnik p, {bool short = false}) =>
      poradnik(p.name, short: short);

  static String poradnikFileOf(Poradnik p, FileFormat format, {bool short = false}) =>
      poradnikFile(p.name, format, short: short);

  static String konspektOf(Konspekt k, {bool short = false}) =>
      konspekt(k.category, k.name, short: short);

  static String formaOf(HarcForm f, {bool short = false}) =>
      forma(f.filename, short: short);

  // ---------------- Parser ----------------
  /// Parse any harcapp.web.app URL (long or short form) into a typed link.
  /// Returns null for unrecognized URLs or non-harcapp hosts.
  static HarcappLink? parse(Uri uri) {
    if (uri.host.isNotEmpty && uri.host != host) return null;
    return parsePath(uri.path);
  }

  static HarcappLink? parsePath(String path) {
    final segs = Uri(path: path).pathSegments.where((s) => s.isNotEmpty).toList();
    if (segs.isEmpty) return null;

    // Forma — must precede konspekt because it nests under /konspekty/formy/.
    if (segs[0] == 'konspekty' && segs.length >= 2 && segs[1] == 'formy') {
      if (segs.length == 3) return FormaLink(filename: segs[2]);
      return null;
    }
    if (segs[0] == 'f' && segs.length == 2) {
      return FormaLink(filename: segs[1]);
    }

    // Poradnik: /poradnik/:name(/:ext) or /p/:name(/:ext)
    if (segs[0] == 'poradnik' || segs[0] == 'p') {
      if (segs.length == 2) {
        return PoradnikLink(name: segs[1], format: FileFormat.pdf);
      }
      if (segs.length == 3) {
        final fmt = FileFormat.fromApiParam(segs[2]) ?? FileFormat.pdf;
        return PoradnikLink(name: segs[1], format: fmt);
      }
      return null;
    }

    // Konspekt: /konspekty/<category>/:name or /k/<category>/:name
    if (segs[0] == 'konspekty' || segs[0] == 'k') {
      if (segs.length == 3) {
        final category = KonspektCategory.fromApiParam(segs[1]);
        if (category != null) {
          return KonspektLink(category: category, name: segs[2]);
        }
      }
      return null;
    }

    return null;
  }

  static String _fill(String template, Map<String, String> values) {
    var out = template;
    values.forEach((key, value) {
      out = out.replaceAll(':$key', Uri.encodeComponent(value));
    });
    return out;
  }
}

sealed class HarcappLink {
  const HarcappLink();
}

class PoradnikLink extends HarcappLink {
  final String name;
  final FileFormat format;
  const PoradnikLink({required this.name, required this.format});
}

class KonspektLink extends HarcappLink {
  final KonspektCategory category;
  final String name;
  const KonspektLink({required this.category, required this.name});
}

class FormaLink extends HarcappLink {
  final String filename;
  const FormaLink({required this.filename});
}