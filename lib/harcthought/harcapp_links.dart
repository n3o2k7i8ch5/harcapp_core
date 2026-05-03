import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan.dart';
import 'package:harcapp_core/harcthought/apel_ewan/apel_ewan_persistent_folder.dart';
import 'package:harcapp_core/harcthought/articles/model/article.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';
import 'package:harcapp_core/harcthought/harc_forms/harc_form.dart';
import 'package:harcapp_core/harcthought/harcapp_host.dart';
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

  static const String scheme = harcappScheme;
  static const String host = harcappHost;
  static const String baseUrl = harcappBaseUrl;

  // ---------------- Path templates ----------------
  // Long forms (active).
  static const String poradnikListTemplate = '/poradnik';
  static const String poradnikItemTemplate = '/poradnik/:name';
  static const String poradnikItemFileTemplate = '/poradnik/:name/:ext';

  static const String konspektRootListTemplate = '/konspekty';
  static const String konspektListTemplate = '/konspekty/:category';
  static const String konspektItemTemplate = '/konspekty/:category/:name';

  static const String formaListTemplate = '/konspekty/formy';
  static const String formaItemTemplate = '/konspekty/formy/:filename';

  static const String apelEwanFolderListTemplate = '/rozwazania_ewangeliczne';
  static const String apelEwanFolderTemplate = '/rozwazania_ewangeliczne/:folder';
  static const String apelEwanItemTemplate = '/rozwazania_ewangeliczne/:folder/:apel';

  static const String articleListTemplate = '/articles';
  static const String articleSourceListTemplate = '/articles/:source';
  static const String articleItemTemplate = '/articles/:source/:localId';

  // Short forms (reserved — not yet wired up).
  static const String poradnikListTemplateShort = '/p';
  static const String poradnikItemTemplateShort = '/p/:name';
  static const String poradnikItemFileTemplateShort = '/p/:name/:ext';
  static const String konspektRootListTemplateShort = '/k';
  static const String konspektListTemplateShort = '/k/:category';
  static const String konspektItemTemplateShort = '/k/:category/:name';
  static const String formaListTemplateShort = '/f';
  static const String formaItemTemplateShort = '/f/:filename';
  static const String apelEwanFolderListTemplateShort = '/r';
  static const String apelEwanFolderTemplateShort = '/r/:folder';
  static const String apelEwanItemTemplateShort = '/r/:folder/:apel';
  static const String articleListTemplateShort = '/a';
  static const String articleSourceListTemplateShort = '/a/:source';
  static const String articleItemTemplateShort = '/a/:source/:localId';

  // ---------------- go_router path helpers ----------------
  // Web router has separate routes per KonspektCategory; these helpers fill
  // the :category segment while leaving :name as a go_router placeholder.
  static String konspektCategoryListPath(KonspektCategory category, {bool short = false}) {
    final tpl = short ? konspektListTemplateShort : konspektListTemplate;
    final cat = short ? category.pathShort : category.path;
    return tpl.replaceFirst(':category', cat);
  }

  static String konspektCategoryItemPath(KonspektCategory category, {bool short = false}) {
    final tpl = short ? konspektItemTemplateShort : konspektItemTemplate;
    return tpl.replaceFirst(':category', category.path);
  }

  // ---------------- Builders ----------------
  // List pages (section-level share targets).
  static String poradnikList({bool short = false}) {
    final tpl = short ? poradnikListTemplateShort : poradnikListTemplate;
    return '$baseUrl$tpl';
  }

  static String konspektList({bool short = false}) {
    final tpl = short ? konspektRootListTemplateShort : konspektRootListTemplate;
    return '$baseUrl$tpl';
  }

  static String konspektCategoryList(KonspektCategory category, {bool short = false}) =>
      '$baseUrl${konspektCategoryListPath(category, short: short)}';

  static String formaList({bool short = false}) {
    final tpl = short ? formaListTemplateShort : formaListTemplate;
    return '$baseUrl$tpl';
  }

  static String apelEwanFolderList({bool short = false}) {
    final tpl = short ? apelEwanFolderListTemplateShort : apelEwanFolderListTemplate;
    return '$baseUrl$tpl';
  }

  static String articleList({bool short = false}) {
    final tpl = short ? articleListTemplateShort : articleListTemplate;
    return '$baseUrl$tpl';
  }

  static String articleSourceList(ArticleSource source, {bool short = false}) {
    final tpl = short ? articleSourceListTemplateShort : articleSourceListTemplate;
    return '$baseUrl${_fill(tpl, {'source': source.name})}';
  }

  // Item pages.
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
    final cat = short ? category.pathShort : category.path;
    return '$baseUrl${_fill(tpl, {'category': cat, 'name': name})}';
  }

  static String forma(String filename, {bool short = false}) {
    final tpl = short ? formaItemTemplateShort : formaItemTemplate;
    return '$baseUrl${_fill(tpl, {'filename': filename})}';
  }

  static String apelEwanFolder(String slug, {bool short = false}) {
    final tpl = short ? apelEwanFolderTemplateShort : apelEwanFolderTemplate;
    return '$baseUrl${_fill(tpl, {'folder': slug})}';
  }

  static String apelEwanItem(String folderSlug, String apelDirName, {bool short = false}) {
    final tpl = short ? apelEwanItemTemplateShort : apelEwanItemTemplate;
    return '$baseUrl${_fill(tpl, {'folder': folderSlug, 'apel': apelDirName})}';
  }

  static String article(ArticleSource source, String localId, {bool short = false}) {
    final tpl = short ? articleItemTemplateShort : articleItemTemplate;
    return '$baseUrl${_fill(tpl, {'source': source.name, 'localId': localId})}';
  }

  static String poradnikOf(Poradnik p, {bool short = false}) =>
      poradnik(p.name, short: short);

  static String poradnikFileOf(Poradnik p, FileFormat format, {bool short = false}) =>
      poradnikFile(p.name, format, short: short);

  static String konspektOf(Konspekt k, {bool short = false}) =>
      konspekt(k.category, k.name, short: short);

  static String formaOf(HarcForm f, {bool short = false}) =>
      forma(f.filename, short: short);

  static String apelEwanFolderOf(ApelEwanPersistentFolder f, {bool short = false}) =>
      apelEwanFolder(f.slug, short: short);

  static String apelEwanItemOf(ApelEwanPersistentFolder f, ApelEwan apel, {bool short = false}) =>
      apelEwanItem(f.slug, apel.dirName, short: short);

  static String articleOf(CoreArticle a, {bool short = false}) =>
      article(a.source, a.localId, short: short);

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
      if (segs.length == 2) return const FormaListLink();
      if (segs.length == 3) return FormaLink(filename: segs[2]);
      return null;
    }
    if (segs[0] == 'f') {
      if (segs.length == 1) return const FormaListLink();
      if (segs.length == 2) return FormaLink(filename: segs[1]);
      return null;
    }

    // Poradnik: /poradnik(/:name(/:ext)) or /p(/:name(/:ext))
    if (segs[0] == 'poradnik' || segs[0] == 'p') {
      if (segs.length == 1) return const PoradnikListLink();
      if (segs.length == 2) {
        return PoradnikLink(name: segs[1], format: FileFormat.pdf);
      }
      if (segs.length == 3) {
        final fmt = FileFormat.fromApiParam(segs[2]) ?? FileFormat.pdf;
        return PoradnikLink(name: segs[1], format: fmt);
      }
      return null;
    }

    // Konspekt: /konspekty(/<category>(/:name)) or /k(/<category>(/:name))
    // Accepts both long ('harcerskie') and short ('h') category segments.
    // Bare /konspekty is the section landing — mobile shows a category tab bar.
    if (segs[0] == 'konspekty' || segs[0] == 'k') {
      if (segs.length == 1) return const KonspektListLink();
      if (segs.length == 2) {
        final category = KonspektCategory.fromAnyPath(segs[1]);
        if (category != null) return KonspektCategoryListLink(category: category);
        return null;
      }
      if (segs.length == 3) {
        final category = KonspektCategory.fromAnyPath(segs[1]);
        if (category != null) {
          return KonspektLink(category: category, name: segs[2]);
        }
      }
      return null;
    }

    // Apel ewangeliczny: /rozwazania_ewangeliczne(/:folder) or /r(/:folder).
    if (segs[0] == 'rozwazania_ewangeliczne' || segs[0] == 'r') {
      if (segs.length == 1) return const ApelEwanFolderListLink();
      if (segs.length == 2) return ApelEwanFolderLink(slug: segs[1]);
      return null;
    }

    // Article: /articles(/:source(/:localId)) or /a(/:source(/:localId)).
    if (segs[0] == 'articles' || segs[0] == 'a') {
      if (segs.length == 1) return const ArticleListLink();
      if (segs.length == 2) {
        final source = ArticleSource.fromName(segs[1]);
        if (source != null) return ArticleSourceListLink(source: source);
        return null;
      }
      if (segs.length == 3) {
        final source = ArticleSource.fromName(segs[1]);
        if (source != null) {
          return ArticleLink(source: source, localId: segs[2]);
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

class ApelEwanFolderLink extends HarcappLink {
  final String slug;
  const ApelEwanFolderLink({required this.slug});
}

class ArticleLink extends HarcappLink {
  final ArticleSource source;
  final String localId;
  const ArticleLink({required this.source, required this.localId});
}

class PoradnikListLink extends HarcappLink {
  const PoradnikListLink();
}

/// /konspekty section landing — mobile shows a category tab bar.
class KonspektListLink extends HarcappLink {
  const KonspektListLink();
}

class KonspektCategoryListLink extends HarcappLink {
  final KonspektCategory category;
  const KonspektCategoryListLink({required this.category});
}

class FormaListLink extends HarcappLink {
  const FormaListLink();
}

class ApelEwanFolderListLink extends HarcappLink {
  const ApelEwanFolderListLink();
}

class ArticleListLink extends HarcappLink {
  const ArticleListLink();
}

class ArticleSourceListLink extends HarcappLink {
  final ArticleSource source;
  const ArticleSourceListLink({required this.source});
}