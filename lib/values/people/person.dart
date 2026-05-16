import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

import '../org.dart';

class Person{

  final String name;
  final RankHarc? rankHarc;
  final RankInstr? rankInstr;
  final String? druzyna;
  final Srodowisko? srodowisko;
  final Org? _explicitOrg;
  final String? comment;
  final List<String> email;

  /// Org as defined for this person; prefers the one carried by [srodowisko]
  /// (via hufiec/chorągiew), otherwise falls back to the explicit value.
  Org? get org => srodowisko?.choragiew?.org ?? _explicitOrg;

  const Person({
    required this.name,
    this.rankHarc,
    this.rankInstr,
    this.druzyna,
    this.srodowisko,
    Org? org,
    this.comment,
    this.email = const []
  }) : _explicitOrg = org;

  bool get isEmpty =>
      name.trim().isEmpty &&
      rankHarc == null &&
      rankInstr == null &&
      (druzyna == null || druzyna!.trim().isEmpty) &&
      srodowisko == null &&
      org == null &&
      (comment == null || comment!.trim().isEmpty) &&
      email.where((e) => e.trim().isNotEmpty).isEmpty;

  bool get isNotEmpty => !isEmpty;

  Map toApiJsonMap() =>
      {
        'name': name,
        'rankHarc': rankHarc?.apiParam,
        'rankInstr': rankInstr?.apiParam,
        'druzyna': druzyna,
        'srodowisko': srodowisko?.toJsonMap(),
        'org': org?.asParam,
        'comment': comment,
        'email': email.isEmpty ? null : email
      };

  static Person fromApiJsonMap(Map<String, dynamic> json) => Person(
    name: json['name'] as String,
    rankHarc: json['rankHarc'] == null ? null : RankHarc.fromApiParam(json['rankHarc'] as String),
    rankInstr: json['rankInstr'] == null? null : RankInstr.fromApiParam(json['rankInstr'] as String),
    druzyna: json['druzyna'] as String?,
    srodowisko: Srodowisko.fromJson(json['srodowisko']),
    org: json['org'] == null ? null : Org.fromParam(json['org'] as String),
    comment: json['comment'] as String?,
    email: (json['email'] as List?)?.cast<String>() ?? [],
  );
}
