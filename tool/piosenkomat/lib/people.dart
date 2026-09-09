import 'dart:io';

import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/values/people/data.all.g.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:path/path.dart' as p;

import 'model.dart';

/// Osoba dodająca z zaimportowanej piosenki, której nie ma jeszcze
/// w `lib/values/people/data.dart`.
class NewContributor {
  final Person person;
  /// Nadawca pierwszy: to on jest `email_ref` w piosence.
  final List<String> emails;
  final List<String> songTitles;

  const NewContributor({
    required this.person,
    required this.emails,
    required this.songTitles,
  });
}

class PeopleReport {
  final List<NewContributor> newContributors;
  /// Nadawcy już obecni w `data.dart` (nic do dopisania).
  final Map<String, List<String>> knownByEmail;
  /// Piosenki bez bloku „Osoba dodająca”: w `data.dart` nie będzie kogo dopisać.
  final Map<String, List<String>> anonymousByEmail;

  const PeopleReport({
    required this.newContributors,
    required this.knownByEmail,
    required this.anonymousByEmail,
  });

  bool get isEmpty =>
      newContributors.isEmpty && knownByEmail.isEmpty && anonymousByEmail.isEmpty;
}

/// Zbiera osoby dodające z importów. Nadawca zawsze ląduje w `emails`,
/// bo to jego adres siedzi w `email_ref` piosenki i po nim `ContributorRef`
/// odnajduje osobę.
PeopleReport collectPeople(List<Classified> items) {
  final newOnes = <String, NewContributor>{};
  final known = <String, List<String>>{};
  final anonymous = <String, List<String>>{};

  for (final c in items) {
    if (c.verdict is! Import) continue;
    final v = c.verdict as Import;
    final registered = v.registered;

    if (allRegisteredPeopleByEmailMap.containsKey(v.sender)) {
      known.putIfAbsent(v.sender, () => []).add(c.title);
      continue;
    }
    if (registered == null) {
      anonymous.putIfAbsent(v.sender, () => []).add(c.title);
      continue;
    }

    final emails = <String>{
      v.sender,
      for (final e in registered.emails) e.trim().toLowerCase(),
    }..removeWhere((e) => e.isEmpty);

    final alreadyKnown = emails.any(allRegisteredPeopleByEmailMap.containsKey);
    if (alreadyKnown) {
      known.putIfAbsent(v.sender, () => []).add(c.title);
      continue;
    }

    final key = emails.first;
    final existing = newOnes.values
        .where((n) => n.emails.any(emails.contains))
        .firstOrNull;
    if (existing != null) {
      newOnes[existing.emails.first] = NewContributor(
        person: existing.person,
        emails: {...existing.emails, ...emails}.toList(),
        songTitles: [...existing.songTitles, c.title],
      );
    } else {
      newOnes[key] = NewContributor(
        person: registered.person,
        emails: emails.toList(),
        songTitles: [c.title],
      );
    }
  }

  return PeopleReport(
    newContributors: newOnes.values.toList()
      ..sort((a, b) => dartConstName(a.person.name).compareTo(dartConstName(b.person.name))),
    knownByEmail: known,
    anonymousByEmail: anonymous,
  );
}

/// `Adam Skłodowski` → `ADAM_SKLODOWSKI`, jak stałe w `data.dart`.
String dartConstName(String name) => remPolChars(name)
    .toUpperCase()
    .replaceAll(RegExp('[^A-Z0-9]+'), '_')
    .replaceAll(RegExp(r'^_+|_+$'), '');

/// Fragment Darta do doklejenia na koniec `lib/values/people/data.dart`.
String emitPeopleDart(PeopleReport report) {
  final taken = {
    for (final r in allRegisteredPeople) dartConstName(r.person.name),
  };
  final buf = StringBuffer()
    ..writeln('// Wygenerowane przez piosenkomat. Doklej do lib/values/people/data.dart,')
    ..writeln('// potem `dart run build_runner build` (albo zostaw to pre-commitowi).')
    ..writeln('// Adresy w `emails` to `email_ref` z zaimportowanych piosenek.')
    ..writeln();

  for (final n in report.newContributors) {
    var name = dartConstName(n.person.name);
    if (name.isEmpty) name = 'OSOBA';
    var unique = name;
    for (var i = 2; taken.contains(unique); i++) {
      unique = '${name}_$i';
    }
    taken.add(unique);
    if (unique != name) {
      buf.writeln('// UWAGA: w data.dart jest już $name. Jeśli to ta sama osoba, nie dodawaj');
      buf.writeln('// tej stałej, tylko dopisz jej adresy do `emails` istniejącej.');
    }
    for (final t in n.songTitles) {
      buf.writeln('// piosenka: $t');
    }
    buf.writeln('const RegisteredContributor $unique = RegisteredContributor(');
    buf.writeln('  person: Person(');
    for (final f in _personFields(n.person)) {
      buf.writeln('    $f,');
    }
    buf.writeln('  ),');
    buf.writeln('  emails: [${n.emails.map(_str).join(', ')}],');
    buf.writeln(');');
  }

  if (report.knownByEmail.isNotEmpty) {
    buf.writeln();
    buf.writeln('// Już w data.dart (nic do dopisania):');
    for (final e in report.knownByEmail.entries) {
      buf.writeln('//   ${e.key}: ${e.value.join('; ')}');
    }
  }
  if (report.anonymousByEmail.isNotEmpty) {
    buf.writeln();
    buf.writeln('// Bez bloku „Osoba dodająca” (piosenka ma tylko email_ref):');
    for (final e in report.anonymousByEmail.entries) {
      buf.writeln('//   ${e.key}: ${e.value.join('; ')}');
    }
  }
  return buf.toString();
}

List<String> _personFields(Person person) => [
      'name: ${_str(person.name)}',
      if (_has(person.druzyna)) 'druzyna: ${_str(person.druzyna!)}',
      if (person.srodowisko != null)
        'srodowisko: ${_srodowisko(person.srodowisko!)}',
      if (person.rankHarc != null) 'rankHarc: RankHarc.${person.rankHarc!.name}',
      if (person.rankInstr != null) 'rankInstr: RankInstr.${person.rankInstr!.name}',
      if (_has(person.comment)) 'comment: ${_str(person.comment!)}',
    ];

/// Ten sam kształt, co w `data.dart`: konstruktor strukturalny, flagi tylko
/// gdy wyłączone, `custom` jako fallback.
String _srodowisko(Srodowisko s) {
  final flags = <String>[];
  String head;
  if (s.hufiecSlug != null) {
    head = 'Srodowisko.hufiec(${_str(s.hufiecSlug!)}';
    if (!s.showHufiec) flags.add('showHufiec: false');
    if (!s.showChoragiew) flags.add('showChoragiew: false');
    if (!s.showOkreg) flags.add('showOkreg: false');
    if (!s.showOrg) flags.add('showOrg: false');
  } else if (s.choragiewSlug != null) {
    head = 'Srodowisko.choragiew(${_str(s.choragiewSlug!)}';
    if (!s.showChoragiew) flags.add('showChoragiew: false');
    if (!s.showOkreg) flags.add('showOkreg: false');
    if (!s.showOrg) flags.add('showOrg: false');
  } else if (s.okregSlug != null) {
    head = 'Srodowisko.okreg(${_str(s.okregSlug!)}';
    if (!s.showOkreg) flags.add('showOkreg: false');
    if (!s.showOrg) flags.add('showOrg: false');
  } else if (s.orgSlug != null && !_has(s.custom)) {
    head = 'Srodowisko.org(${_str(s.orgSlug!)}';
    if (!s.showOrg) flags.add('showOrg: false');
  } else {
    head = 'Srodowisko.custom(${_str(s.custom ?? '')}';
    if (s.orgSlug != null) flags.add('orgSlug: ${_str(s.orgSlug!)}');
  }
  if (_has(s.custom) && !head.startsWith('Srodowisko.custom')) {
    flags.insert(0, 'custom: ${_str(s.custom!)}');
  }
  return flags.isEmpty ? '$head)' : '$head, ${flags.join(', ')})';
}

bool _has(String? s) => s != null && s.trim().isNotEmpty;

String _str(String s) =>
    "'${s.replaceAll(r'\', r'\\').replaceAll("'", r"\'").replaceAll(r'$', r'\$')}'";

/// `out/import-X.hrcpsng` → `out/import-X.people.dart`.
String peoplePathFor(String hrcpsngPath) =>
    p.setExtension(hrcpsngPath, '.people.dart');

void writePeopleDart(String path, PeopleReport report) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(emitPeopleDart(report));
}
