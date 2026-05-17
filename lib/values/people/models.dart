import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/rank_instr.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

import 'contributor_ref.dart';

class Person{

  final String name;
  final RankHarc? rankHarc;
  final RankInstr? rankInstr;
  final String? druzyna;
  final Srodowisko? srodowisko;
  final String? comment;

  Org? get org => srodowisko?.org;

  const Person({
    required this.name,
    this.rankHarc,
    this.rankInstr,
    this.druzyna,
    this.srodowisko,
    this.comment,
  });

  bool get isEmpty =>
      name.trim().isEmpty &&
      rankHarc == null &&
      rankInstr == null &&
      (druzyna == null || druzyna!.trim().isEmpty) &&
      srodowisko == null &&
      (comment == null || comment!.trim().isEmpty);

  bool get isNotEmpty => !isEmpty;

  Map toApiJsonMap() =>
      {
        'name': name,
        'rankHarc': rankHarc?.apiParam,
        'rankInstr': rankInstr?.apiParam,
        'druzyna': druzyna,
        'srodowisko': srodowisko?.toJsonMap(),
        'comment': comment,
      };

  static Person fromApiJsonMap(Map<String, dynamic> json) => Person(
    name: json['name'] as String,
    rankHarc: json['rankHarc'] == null ? null : RankHarc.fromApiParam(json['rankHarc'] as String),
    rankInstr: json['rankInstr'] == null? null : RankInstr.fromApiParam(json['rankInstr'] as String),
    druzyna: json['druzyna'] as String?,
    srodowisko: Srodowisko.fromJson(json['srodowisko']),
    comment: json['comment'] as String?,
  );
}

class RegisteredContributor{
  final Person person;
  final List<String> emails;
  final String? userKey;

  const RegisteredContributor({required this.person, required this.emails, this.userKey});

  ContributorRef toContributorRef() => ContributorRef(
      person: person,
      emailRef: emails.firstOrNull,
      userKeyRef: userKey
  );
}