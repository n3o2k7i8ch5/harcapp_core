import 'apel_ewan_folder.dart';

class ApelEwanPersistentFolder extends ApelEwanFolder{

  static final List<ApelEwanPersistentFolder> _all = [];

  /// Read-only list of registered persistent folders. Populated by core's
  /// [loadAllApelEwans] (omega + dekalog); apps may register additional ones
  /// through [register].
  static List<ApelEwanPersistentFolder> get all => List.unmodifiable(_all);

  /// Adds [folder] to the registry. Replaces any previously registered folder
  /// with the same id (safe under hot reload).
  static void register(ApelEwanPersistentFolder folder) {
    _all.removeWhere((f) => f.id == folder.id);
    _all.add(folder);
  }

  /// Looks up a registered folder by its [slug] (e.g. `omega`, `dekalog`).
  /// Returns null if no matching folder is registered.
  static ApelEwanPersistentFolder? bySlug(String slug) {
    for (final f in _all) {
      if (f.slug == slug) return f;
    }
    return null;
  }

  /// URL slug derived from [id] by stripping all underscores
  /// (e.g. `__omega__` → `omega`). Used in shareable harcapp.web.app links.
  String get slug => id.replaceAll('_', '');

  @override
  final String name;

  @override
  final String iconKey;

  @override
  final String colorsKey;

  /// Default variant key shown when an apel from this folder is opened —
  /// e.g. omegaFolder uses 'ogolne', dekalogFolder uses 'dekalog'. Falls back
  /// to the apel's first variant if the apel doesn't define this one.
  final String variantId;

  const ApelEwanPersistentFolder({
    required super.id,
    required super.apelEwans,
    required this.name,
    required this.iconKey,
    required this.colorsKey,
    required this.variantId,
  });

  @override
  bool get isEmpty => apelEwans.isEmpty;

}
