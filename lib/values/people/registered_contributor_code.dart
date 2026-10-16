import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

/// Nazwy, które nikogo nie nazywają: tyle zostaje z karty bez imienia
/// i nazwiska albo podpisanej „Anonim”.
const Set<String> _namelessConstNames = {'', 'OSOBA', 'ANONIM'};

/// `Adam Skłodowski` → `ADAM_SKLODOWSKI`, jak stałe w `data.dart`.
///
/// Stała ma **nazywać osobę**, a nie powtarzać to, co widzi użytkownik apki:
/// z kart podpisanych „Anonim” zrobiłby się ciąg `ANONIM`, `ANONIM_2`,
/// `ANONIM_3`, po którym nie poznasz, kto jest kto, ani nie znajdziesz wpisu
/// przy kolejnym zgłoszeniu tej samej osoby. Dlatego przy takiej karcie nazwa
/// idzie z [email] (`karina.powiecka@icloud.com` → `KARINA_POWIECKA`) —
/// w `data.dart` imię zostaje „Anonim”, tożsamość siedzi w nazwie stałej.
/// Bez nazwy i bez adresu — `OSOBA`.
String dartConstName(String name, {String? email}){
  String constNameOf(String text) => remPolChars(text)
      .toUpperCase()
      .replaceAll(RegExp('[^A-Z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');

  final constName = constNameOf(name);
  if(!_namelessConstNames.contains(constName)) return constName;

  final fromEmail = constNameOf((email ?? '').split('@').first);
  return _namelessConstNames.contains(fromEmail)? 'OSOBA': fromEmail;
}

/// Wpis osoby w kształcie `data.dart`, do wklejenia na koniec pliku — jeden dla
/// strony (okno mejla) i piosenkomatu (`people.dart`). [constName] — nazwa
/// stałej; domyślnie z imienia i nazwiska, a przy karcie bez nich z pierwszego
/// adresu ([dartConstName]).
String registeredContributorDartCode(RegisteredContributor registered, {String? constName}) => [
  'const RegisteredContributor ${constName ?? dartConstName(registered.person.name, email: registered.emails.firstOrNull)} = RegisteredContributor(',
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
