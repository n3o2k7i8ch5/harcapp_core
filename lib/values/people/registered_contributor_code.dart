import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

/// `Adam Skłodowski` → `ADAM_SKLODOWSKI`, jak stałe w `data.dart`. Bez imienia
/// i nazwiska — `OSOBA`.
String dartConstName(String name){
  final constName = remPolChars(name)
      .toUpperCase()
      .replaceAll(RegExp('[^A-Z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
  return constName.isEmpty? 'OSOBA': constName;
}

/// Wpis osoby w kształcie `data.dart`, do wklejenia na koniec pliku — jeden dla
/// strony (okno mejla) i piosenkomatu (`people.dart`). [constName] — nazwa
/// stałej; domyślnie z imienia i nazwiska ([dartConstName]).
String registeredContributorDartCode(RegisteredContributor registered, {String? constName}) => [
  'const RegisteredContributor ${constName ?? dartConstName(registered.person.name)} = RegisteredContributor(',
  '  person: Person(',
  for(final f in _personFields(registered.person)) '    $f,',
  '  ),',
  '  emails: [${registered.emails.map(dartStringLiteral).join(', ')}],',
  ');',
].join('\n');

/// Napis Darta w apostrofach, z `\`, `'` i `$` wyescapowanymi.
String dartStringLiteral(String s) =>
    "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'";

List<String> _personFields(Person person) => [
  'name: ${dartStringLiteral(person.name)}',
  if(_has(person.druzyna)) 'druzyna: ${dartStringLiteral(person.druzyna!)}',
  if(person.srodowisko != null) 'srodowisko: ${_srodowiskoDartCode(person.srodowisko!)}',
  if(person.rankHarc != null) 'rankHarc: RankHarc.${person.rankHarc!.name}',
  if(person.rankInstr != null) 'rankInstr: RankInstr.${person.rankInstr!.name}',
  if(_has(person.comment)) 'comment: ${dartStringLiteral(person.comment!)}',
];

/// Ten sam kształt, co w `data.dart`: konstruktor strukturalny, flagi tylko
/// gdy wyłączone, `custom` jako fallback.
String _srodowiskoDartCode(Srodowisko s){
  final flags = <String>[];
  String head;
  if(s.hufiecSlug != null){
    head = 'Srodowisko.hufiec(${dartStringLiteral(s.hufiecSlug!)}';
    if(!s.showHufiec) flags.add('showHufiec: false');
    if(!s.showChoragiew) flags.add('showChoragiew: false');
    if(!s.showOkreg) flags.add('showOkreg: false');
    if(!s.showOrg) flags.add('showOrg: false');
  } else if(s.choragiewSlug != null){
    head = 'Srodowisko.choragiew(${dartStringLiteral(s.choragiewSlug!)}';
    if(!s.showChoragiew) flags.add('showChoragiew: false');
    if(!s.showOkreg) flags.add('showOkreg: false');
    if(!s.showOrg) flags.add('showOrg: false');
  } else if(s.okregSlug != null){
    head = 'Srodowisko.okreg(${dartStringLiteral(s.okregSlug!)}';
    if(!s.showOkreg) flags.add('showOkreg: false');
    if(!s.showOrg) flags.add('showOrg: false');
  } else if(s.orgSlug != null && !_has(s.custom)){
    head = 'Srodowisko.org(${dartStringLiteral(s.orgSlug!)}';
    if(!s.showOrg) flags.add('showOrg: false');
  } else {
    head = 'Srodowisko.custom(${dartStringLiteral(s.custom ?? '')}';
    if(s.orgSlug != null) flags.add('orgSlug: ${dartStringLiteral(s.orgSlug!)}');
  }
  if(_has(s.custom) && !head.startsWith('Srodowisko.custom')){
    flags.insert(0, 'custom: ${dartStringLiteral(s.custom!)}');
  }
  return flags.isEmpty? '$head)': '$head, ${flags.join(', ')})';
}

bool _has(String? s) => s != null && s.trim().isNotEmpty;
