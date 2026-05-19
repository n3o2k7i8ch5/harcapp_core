import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/srodowiska/lookups.dart';

class Okreg {
  final String slug;
  final String name;
  final Org org;
  const Okreg(this.slug, this.name, this.org);

  /// Pseudo-okręg dla organizacji bez okręgów (np. ZHP). UI traktuje takie
  /// okręgi jak `null` i nie pokazuje ich w wyborze.
  bool get isDummy => slug.startsWith('_');

  /// Globally unique ID in the form `<slug>@<org>`.
  String get id => '$slug@${org.name}';
}

class Choragiew {
  final String slug;
  final String name;
  final Okreg okreg;
  const Choragiew(this.slug, this.name, this.okreg);

  /// Pojedyncze źródło prawdy o organizacji — czytane przez okręg.
  Org get org => okreg.org;

  /// Globally unique ID in the form `<slug>@<okreg.id>`.
  String get id => '$slug@${okreg.id}';
}

class Hufiec {
  final String slug;
  final String name;
  final String? patron;
  final Choragiew choragiew;
  const Hufiec(this.slug, this.name, this.choragiew, {this.patron});

  /// Globally unique ID in the form `<slug>@<choragiew.id>`.
  String get id => '$slug@${choragiew.id}';

  String get displayName => patron == null ? name : '$name im. $patron';
}

class Srodowisko {
  /// At most one of [hufiecSlug] / [choragiewSlug] / [okregSlug] / [orgSlug]
  /// may be set — these are hierarchical (hufiec implies choragiew, choragiew
  /// implies okreg/org, okreg implies org). [custom] is independent free-form
  /// text and may coexist with any of them.
  final String? hufiecSlug;
  final String? choragiewSlug;
  final String? okregSlug;
  final String? orgSlug;
  final String? custom;

  /// Per-level display flags. Default `true` (show). Setting a level to
  /// `false` hides it from generated display lines, even if it is implied by
  /// a more specific slug (e.g. hufiec → choragiew → okreg → org). Useful
  /// when only some of the auto-derived structural levels should appear in UI.
  final bool showHufiec;
  final bool showChoragiew;
  final bool showOkreg;
  final bool showOrg;

  const Srodowisko({
    this.hufiecSlug,
    this.choragiewSlug,
    this.okregSlug,
    this.orgSlug,
    this.custom,
    this.showHufiec = true,
    this.showChoragiew = true,
    this.showOkreg = true,
    this.showOrg = true,
  })  : assert(
          (hufiecSlug != null ? 1 : 0)
        + (choragiewSlug != null ? 1 : 0)
        + (okregSlug != null ? 1 : 0)
        + (orgSlug != null ? 1 : 0) <= 1,
          'At most one of hufiecSlug/choragiewSlug/okregSlug/orgSlug may be set',
        ),
        assert(
          hufiecSlug != null
          || choragiewSlug != null
          || okregSlug != null
          || orgSlug != null
          || custom != null,
          'At least one field must be set',
        );

  const Srodowisko.hufiec(
    String slug, {
    String? custom,
    bool showHufiec = true,
    bool showChoragiew = true,
    bool showOkreg = true,
    bool showOrg = true,
  }) : this(
          hufiecSlug: slug,
          custom: custom,
          showHufiec: showHufiec,
          showChoragiew: showChoragiew,
          showOkreg: showOkreg,
          showOrg: showOrg,
        );

  const Srodowisko.choragiew(
    String slug, {
    String? custom,
    bool showChoragiew = true,
    bool showOkreg = true,
    bool showOrg = true,
  }) : this(
          choragiewSlug: slug,
          custom: custom,
          showChoragiew: showChoragiew,
          showOkreg: showOkreg,
          showOrg: showOrg,
        );

  const Srodowisko.okreg(
    String slug, {
    String? custom,
    bool showOkreg = true,
    bool showOrg = true,
  }) : this(
          okregSlug: slug,
          custom: custom,
          showOkreg: showOkreg,
          showOrg: showOrg,
        );

  const Srodowisko.org(String slug, {String? custom, bool showOrg = true})
      : this(orgSlug: slug, custom: custom, showOrg: showOrg);

  /// Wolnotekstowe środowisko. Można dorzucić [orgSlug] (np. `'zhp'`,
  /// `Org.zhp.name`), żeby zachować informację o organizacji obok tekstu.
  const Srodowisko.custom(String text, {String? orgSlug})
      : this(custom: text, orgSlug: orgSlug);

  Hufiec? get hufiec => hufiecSlug == null ? null : hufiecBySlug(hufiecSlug!);
  Choragiew? get choragiew {
    final h = hufiec;
    if(h != null) return h.choragiew;
    if(choragiewSlug != null) return choragiewBySlug(choragiewSlug!);
    return null;
  }
  Okreg? get okreg {
    final c = choragiew;
    if(c != null && !c.okreg.isDummy) return c.okreg;
    if(okregSlug != null) return okregBySlug(okregSlug!);
    return null;
  }
  Org? get org {
    final c = choragiew;
    if(c != null) return c.org;
    final o = okreg;
    if(o != null) return o.org;
    if(orgSlug != null) return orgBySlug(orgSlug!);
    return null;
  }

  /// Display lines, ordered from most-specific to most-general, filtered by
  /// per-level visibility flags. [custom] (if any) always comes first.
  List<String> get displayLines => [
    if(custom != null) custom!,
    if(showHufiec && hufiec != null) hufiec!.displayName,
    if(showChoragiew && choragiew != null) choragiew!.name,
    if(showOkreg && okreg != null) okreg!.name,
    if(showOrg && org != null) org!.fullName,
  ];

  /// Primary single-line label — the first visible line, or null if none.
  String? get displayName => displayLines.isEmpty ? null : displayLines.first;

  Map<String, dynamic> toJsonMap() => {
    if(hufiecSlug != null) 'hufiecSlug': hufiecSlug,
    if(choragiewSlug != null) 'choragiewSlug': choragiewSlug,
    if(okregSlug != null) 'okregSlug': okregSlug,
    if(orgSlug != null) 'orgSlug': orgSlug,
    if(custom != null) 'custom': custom,
    // Persist only the hidden levels — defaults stay implicit.
    if(!showHufiec) 'hideHufiec': true,
    if(!showChoragiew) 'hideChoragiew': true,
    if(!showOkreg) 'hideOkreg': true,
    if(!showOrg) 'hideOrg': true,
  };

  static Srodowisko? fromJson(Object? json){
    if(json is! Map) return null;
    final hufiecSlug = json['hufiecSlug'] as String?;
    final choragiewSlug = json['choragiewSlug'] as String?;
    final okregSlug = json['okregSlug'] as String?;
    final orgSlug = json['orgSlug'] as String?;
    final custom = json['custom'] as String?;
    if(hufiecSlug == null && choragiewSlug == null && okregSlug == null && orgSlug == null && custom == null) return null;
    return Srodowisko(
      hufiecSlug: hufiecSlug,
      choragiewSlug: choragiewSlug,
      okregSlug: okregSlug,
      orgSlug: orgSlug,
      custom: custom,
      showHufiec: json['hideHufiec'] != true,
      showChoragiew: json['hideChoragiew'] != true,
      showOkreg: json['hideOkreg'] != true,
      showOrg: json['hideOrg'] != true,
    );
  }
}
