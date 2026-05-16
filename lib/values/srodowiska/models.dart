import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/srodowiska/lookups.dart';

class Okreg {
  final String slug;
  final String name;
  final Org org;
  const Okreg(this.slug, this.name, this.org);

  /// Globally unique ID in the form `<slug>@<org>`.
  String get id => '$slug@${org.name}';
}

class Choragiew {
  final String slug;
  final String name;
  final Org org;
  final Okreg? okreg;
  const Choragiew(this.slug, this.name, this.org, {this.okreg});

  /// Globally unique ID in the form `<slug>@<okreg?>@<org>` — the okreg slot
  /// is always present; empty when the organization (e.g. ZHP) has no okręgi.
  String get id => '$slug@${okreg?.slug ?? ''}@${org.name}';
}

class Hufiec {
  final String slug;
  final String name;
  final Choragiew choragiew;
  const Hufiec(this.slug, this.name, this.choragiew);

  /// Globally unique ID in the form `<slug>@<choragiew.id>`.
  String get id => '$slug@${choragiew.id}';
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

  const Srodowisko({this.hufiecSlug, this.choragiewSlug, this.okregSlug, this.orgSlug, this.custom})
      : assert(
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

  const Srodowisko.hufiec(String slug, {String? custom}) : this(hufiecSlug: slug, custom: custom);
  const Srodowisko.choragiew(String slug, {String? custom}) : this(choragiewSlug: slug, custom: custom);
  const Srodowisko.okreg(String slug, {String? custom}) : this(okregSlug: slug, custom: custom);
  const Srodowisko.org(String slug, {String? custom}) : this(orgSlug: slug, custom: custom);
  const Srodowisko.custom(String text) : this(custom: text);

  Hufiec? get hufiec => hufiecSlug == null ? null : hufiecBySlug(hufiecSlug!);
  Choragiew? get choragiew {
    final h = hufiec;
    if(h != null) return h.choragiew;
    if(choragiewSlug != null) return choragiewBySlug(choragiewSlug!);
    return null;
  }
  Okreg? get okreg {
    final c = choragiew;
    if(c?.okreg != null) return c!.okreg;
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

  /// Primary label. Prefers user-typed [custom] when set, otherwise falls back
  /// to the most specific structured field.
  String? get displayName =>
      custom
          ?? hufiec?.name
          ?? choragiew?.name
          ?? okreg?.name
          ?? org?.fullName;

  Map<String, dynamic> toJsonMap() => {
    if(hufiecSlug != null) 'hufiecSlug': hufiecSlug,
    if(choragiewSlug != null) 'choragiewSlug': choragiewSlug,
    if(okregSlug != null) 'okregSlug': okregSlug,
    if(orgSlug != null) 'orgSlug': orgSlug,
    if(custom != null) 'custom': custom,
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
    );
  }
}
