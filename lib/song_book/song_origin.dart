/// Pochodzenie piosenki: z jakiej bajki, filmu, serialu, musicalu albo czego
/// to przeróbka. Pod tytułem każde to osobna linia — „Z bajki: Shrek”.
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_widgets/app_dropdown.dart';

import 'song_tags.dart';

/// Rodzaj pochodzenia. [id] jedzie do JSON-a piosenki, [label] — na ekran.
/// Nowy rodzaj to nowa pozycja tutaj.
enum SongOriginType implements IconTextEnum{
  animation('animation', 'Z bajki', MdiIcons.castle, tag: SongTag.TAG_Z_BAJEK),
  film('film', 'Z filmu', MdiIcons.movieOpenOutline),
  series('series', 'Z serialu', MdiIcons.televisionClassic),
  musical('musical', 'Z musicalu', MdiIcons.dramaMasks),
  rewrite('rewrite', 'Przeróbka', MdiIcons.textBoxEditOutline, tag: SongTag.TAG_PRZEROBKI);

  const SongOriginType(this.id, this.label, this.icon, {this.tag});

  final String id;
  final String label;
  @override
  final IconData icon;
  /// Tag, który piosenka z takim pochodzeniem musi mieć — filtr w apce działa
  /// po tagach. `null`, gdy dla tego rodzaju tagu nie ma.
  final String? tag;

  @override
  String get text => label;

  /// Nieznane id (piosenka z nowszej apki) to `null`, nie błąd — taki wpis
  /// po prostu się nie pokaże.
  static SongOriginType? byId(String? id) => values.where((t) => t.id == id).firstOrNull;
}

/// Jedno pochodzenie: rodzaj i nazwa („Shrek”, „Pieśń wielorybników”).
class SongOrigin{

  static const String PARAM_TYPE = 'type';
  static const String PARAM_VALUE = 'value';

  final SongOriginType type;
  final String value;

  const SongOrigin(this.type, this.value);

  /// Linia pod tytułem: „Z bajki: Shrek”.
  String get text => '${type.label}: $value';

  SongOrigin withValue(String value) => SongOrigin(type, value);

  Map<String, String> toJsonMap() => {
    PARAM_TYPE: type.id,
    PARAM_VALUE: value.trim(),
  };

  /// `null` dla wpisu, którego nie ma jak pokazać: nieznany rodzaj, pusta
  /// nazwa albo coś innego niż mapa.
  static SongOrigin? fromJsonMap(Object? map){
    if(map is! Map) return null;
    final type = map[PARAM_TYPE];
    final value = map[PARAM_VALUE];
    final knownType = type is String? SongOriginType.byId(type): null;
    if(knownType == null || value is! String || value.trim().isEmpty) return null;
    return SongOrigin(knownType, value.trim());
  }

  /// Lista z JSON-a piosenki, bez wpisów, których nie ma jak pokazać — jeden
  /// zły wpis nie może wywrócić wczytania całej piosenki.
  static List<SongOrigin> listFromJson(Object? list) => [
    if(list is List)
      for(final item in list)
        if(fromJsonMap(item) case final origin?) origin,
  ];

  @override
  bool operator ==(Object other) => other is SongOrigin && other.type == type && other.value == value;

  @override
  int get hashCode => Object.hash(type, value);

  @override
  String toString() => text;

}
