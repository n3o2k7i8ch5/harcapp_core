import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/data.all.g.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';

import 'hrcpsng.dart';

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
  /// Piosenki bez karty osoby: w `data.dart` nie będzie kogo dopisać.
  final Map<String, List<String>> anonymousByEmail;
  /// Zgłoszenia w cudzym imieniu: adres nadawcy jest tylko do odpisania, więc
  /// do `data.dart` nie idzie. Osobę dodającą przypisujesz ręcznie.
  final Map<String, List<String>> senderNotContributorByEmail;

  const PeopleReport({
    required this.newContributors,
    required this.knownByEmail,
    required this.anonymousByEmail,
    this.senderNotContributorByEmail = const {},
  });
}

/// Piosenka, która wchodzi do apki — tyle o niej, ile trzeba, żeby dopisać
/// osobę dodającą do `data.dart`.
class ContributorSource {
  /// Adres nadawcy: to on siedzi w `email_ref` piosenki i po nim
  /// `ContributorRef` odnajduje osobę.
  final String sender;
  final String title;
  /// Karta osoby wyjęta z piosenki — a więc już po Twoich poprawkach
  /// z przeglądu, nie ta sparsowana z mejla.
  final Person? person;
  /// Pozostałe adresy, które autor zadeklarował w mejlu. Piosenka ich nie
  /// niesie (`ContributorRef` ma jeden `emailRef`), więc idą bokiem, z planu.
  final List<String> otherEmails;
  /// Czy nadawca zgłaszał **własną** piosenkę. Przy `false` jego adres nie
  /// trafia do `data.dart`.
  final bool senderIsContributor;

  const ContributorSource({
    required this.sender,
    required this.title,
    this.person,
    this.otherEmails = const [],
    this.senderIsContributor = true,
  });

  ContributorSource withEmails(List<String> emails) => ContributorSource(
        sender: sender,
        title: title,
        person: person,
        otherEmails: emails,
        senderIsContributor: senderIsContributor,
      );
}

/// Dokłada adresy z planu przebiegu do zebranych źródeł — plan czyta się
/// dopiero po `strip`, a źródła powstają przed nim.
List<ContributorSource> withOtherEmails(
  List<ContributorSource> sources,
  Map<String, List<String>> otherEmailsBySender,
) =>
    [
      for (final c in sources)
        c.withEmails(otherEmailsBySender[c.sender] ?? c.otherEmails),
    ];

/// Osoby z piosenek, które **wchodzą do apki** — czyli z `final-*.hrcpsng`,
/// po przeglądzie. Wcześniej nie ma sensu: kogo wywalisz na stronie, tego nie
/// ma po co dopisywać do `data.dart`.
List<ContributorSource> contributorSourcesOf(
  List<SongRaw> songs, {
  Map<String, List<String>> otherEmailsBySender = const {},
}) {
  final out = <ContributorSource>[];
  for (final song in songs) {
    final sender = (song.contributorData?.email ?? '').trim().toLowerCase();
    if (sender.isEmpty) continue;
    out.add(ContributorSource(
      sender: sender,
      title: song.title,
      person: _personOf(song, sender),
      otherEmails: otherEmailsBySender[sender] ?? const [],
      // Ślad piosenkomatu zdejmuje `strip`, więc tylko dopóki jest.
      senderIsContributor: song.piosenkomatData?.senderIsContributor ?? true,
    ));
  }
  return out;
}

/// Karta osoby dopięta do adresu nadawcy. Zwykle `_enrich` wstawił adres
/// wprost w jej `emailRef`; jeśli przy przeglądzie adres z niej zniknął,
/// a karta jest w piosence jedna — to ona.
Person? _personOf(SongRaw song, String sender) {
  for (final c in song.contribRefs) {
    if (c.person != null &&
        (c.emailRef ?? '').trim().toLowerCase() == sender) return c.person;
  }
  final withPerson = [for (final c in song.contribRefs) if (c.person != null) c];
  return withPerson.length == 1 && (withPerson.single.emailRef ?? '').trim().isEmpty
      ? withPerson.single.person
      : null;
}

/// Zbiera osoby dodające z piosenek, które wchodzą. Nadawca zawsze ląduje
/// w `emails`, bo to jego adres siedzi w `email_ref` piosenki.
PeopleReport collectPeople(List<ContributorSource> items) {
  final newOnes = <String, NewContributor>{};
  final known = <String, List<String>>{};
  final anonymous = <String, List<String>>{};
  final notContributor = <String, List<String>>{};

  for (final c in items) {
    final sender = c.sender;

    // Adres nadawcy jest tu śladem zgody, nie wkładem. Karta też nie wchodzi:
    // nie ma jej z czym związać.
    if (!c.senderIsContributor) {
      notContributor.putIfAbsent(sender, () => []).add(c.title);
      continue;
    }

    if (registeredPersonByEmail(sender) != null) {
      known.putIfAbsent(sender, () => []).add(c.title);
      continue;
    }
    if (c.person == null) {
      anonymous.putIfAbsent(sender, () => []).add(c.title);
      continue;
    }

    final emails = <String>{
      sender,
      for (final e in c.otherEmails) e.trim().toLowerCase(),
    }..removeWhere((e) => e.isEmpty);

    final alreadyKnown = emails.any((e) => registeredPersonByEmail(e) != null);
    if (alreadyKnown) {
      known.putIfAbsent(sender, () => []).add(c.title);
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
        person: c.person!,
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
    senderNotContributorByEmail: notContributor,
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

void writePeopleDart(String path, PeopleReport report) =>
    writeText(path, emitPeopleDart(report));
