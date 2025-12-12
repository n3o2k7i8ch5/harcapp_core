import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';

import '../org.dart';

class Person{

  final String name;
  final RankHarc? rankHarc;
  final RankInstr? rankInstr;
  final String? druzyna;
  final String? hufiec;
  final Org? org;
  final String? comment;
  final List<String> email;

  const Person({
    required this.name,
    this.rankHarc,
    this.rankInstr,
    this.druzyna,
    this.hufiec,
    this.org,
    this.comment,
    this.email = const []
  });

  bool get isEmpty =>
      name.trim().isEmpty &&
      rankHarc == null &&
      rankInstr == null &&
      druzyna == null &&
      hufiec == null &&
      org == null &&
      (comment == null || comment!.trim().isEmpty) &&
      email.isEmpty;

  bool get isNotEmpty => !isEmpty;

  Map toApiJsonMap() =>
      {
        'name': name,
        'rankHarc': rankHarc?.apiParam,
        'rankInstr': rankInstr?.apiParam,
        'druzyna': druzyna,
        'hufiec': hufiec,
        'org': org?.asParam,
        'comment': comment,
        'email': email.isEmpty ? null : email
      };

  static Person fromApiJsonMap(Map<String, dynamic> json) => Person(
    name: json['name'] as String,
    rankHarc: json['rankHarc'] == null ? null : RankHarc.fromApiParam(json['rankHarc'] as String),
    rankInstr: json['rankInstr'] == null? null : RankInstr.fromApiParam(json['rankInstr'] as String),
    druzyna: json['druzyna'] as String?,
    hufiec: json['hufiec'] as String?,
    org: json['org'] == null ? null : Org.fromParam(json['org'] as String),
    comment: json['comment'] as String?,
    email: (json['email'] as List?)?.cast<String>() ?? [],
  );
}