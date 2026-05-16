import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/srodowiska/choragwie.dart';
import 'package:harcapp_core/values/srodowiska/hufce.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:harcapp_core/values/srodowiska/okregi.dart';

// Top-level `final` w Dart inicjalizuje się leniwie RAZ przy pierwszym dostępie —
// mapy nie są przebudowywane przy każdym lookupie.
final Map<String, Hufiec> _hufceBySlug = {
  for (final h in hufce) h.slug: h,
};
final Map<String, Choragiew> _choragwieBySlug = {
  for (final c in choragwie) c.slug: c,
};
final Map<String, Okreg> _okregiBySlug = {
  for (final o in okregi) o.slug: o,
};
final Map<String, Org> _orgBySlug = {
  for (final o in Org.values) o.name: o,
};

Hufiec? hufiecBySlug(String slug) => _hufceBySlug[slug];
Choragiew? choragiewBySlug(String slug) => _choragwieBySlug[slug];
Okreg? okregBySlug(String slug) => _okregiBySlug[slug];
Org? orgBySlug(String slug) => _orgBySlug[slug];
