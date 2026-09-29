import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

/// Wpis osoby jako kod Darta, do wklejenia w `data.dart`. W tym samym kształcie
/// starsze wersje apki i strony wkładały osobę do mejla (`### Osoba dodająca`)
/// — parser zgłoszeń dalej go czyta.
String registeredContributorDartCode(RegisteredContributor registered){
  final person = registered.person;

  final personFields = <String>[];
  if(person.name.isNotEmpty) personFields.add("name: '${person.name}'");
  if(person.druzyna != null && person.druzyna!.isNotEmpty) personFields.add("druzyna: '${person.druzyna}'");
  if(person.srodowisko != null) personFields.add("srodowisko: ${_srodowiskoDartCode(person.srodowisko!)}");
  if(person.rankInstr != null) personFields.add("rankInstr: RankInstr.${person.rankInstr!.name}");
  if(person.rankHarc != null) personFields.add("rankHarc: RankHarc.${person.rankHarc!.name}");
  if(person.comment != null && person.comment!.isNotEmpty) personFields.add("comment: '${person.comment}'");

  final varName = remPolChars(person.name).toUpperCase().replaceAll(' ', '_');
  final emailsLiteral = '[${registered.emails.map((e) => '"$e"').join(', ')}]';

  return [
    'RegisteredContributor $varName = const RegisteredContributor(',
    '  person: Person(',
    for(final f in personFields) '    $f,',
    '  ),',
    '  emails: $emailsLiteral,',
    ');',
  ].join('\n');
}

/// Literał Darta dla [Srodowisko]: konstruktor strukturalny (`hufiec`/
/// `choragiew`/`okreg`/`org`), gdy odpowiedni slug jest ustawiony; `custom`
/// tylko wtedy, gdy slugów nie ma.
String _srodowiskoDartCode(Srodowisko s){
  final args = <String>[];
  String primary;
  if(s.hufiecSlug != null){
    primary = "Srodowisko.hufiec('${s.hufiecSlug}'";
    if(!s.showHufiec) args.add('showHufiec: false');
    if(!s.showChoragiew) args.add('showChoragiew: false');
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.choragiewSlug != null){
    primary = "Srodowisko.choragiew('${s.choragiewSlug}'";
    if(!s.showChoragiew) args.add('showChoragiew: false');
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.okregSlug != null){
    primary = "Srodowisko.okreg('${s.okregSlug}'";
    if(!s.showOkreg) args.add('showOkreg: false');
    if(!s.showOrg) args.add('showOrg: false');
  } else if(s.orgSlug != null){
    primary = "Srodowisko.org('${s.orgSlug}'";
    if(!s.showOrg) args.add('showOrg: false');
  } else {
    return "Srodowisko.custom('${s.custom ?? s.displayName}')";
  }
  return args.isEmpty ? '$primary)' : '$primary, ${args.join(', ')})';
}
