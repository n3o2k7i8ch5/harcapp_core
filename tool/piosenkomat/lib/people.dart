import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/people/data.all.g.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/registered_contributor_code.dart';
import 'package:harcapp_core/values/people/utils.dart';

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

/// Osoba już w `data.dart`, ale pod innym adresem niż ten, z którego przyszło
/// zgłoszenie. [newEmails] trzeba dopisać do `emails` jej wpisu — inaczej
/// `ContributorRef.resolve()` nie znajdzie jej po `email_ref` piosenki.
class KnownWithNewEmails {
  final RegisteredContributor registered;
  final List<String> newEmails;
  final List<String> songTitles;

  const KnownWithNewEmails({
    required this.registered,
    required this.newEmails,
    required this.songTitles,
  });
}

/// Adresy jednego nadawcy wskazują **różne** osoby z `data.dart` — nie
/// zgadujemy, która to ta.
class AmbiguousContributor {
  final String sender;
  final List<RegisteredContributor> matches;
  final List<String> songTitles;

  const AmbiguousContributor({
    required this.sender,
    required this.matches,
    required this.songTitles,
  });
}

class PeopleReport {
  final List<NewContributor> newContributors;
  /// Nadawcy już obecni w `data.dart` (nic do dopisania).
  final Map<String, List<String>> knownByEmail;
  /// Znani z innego adresu — do dopisania ręcznie w istniejącym wpisie.
  final List<KnownWithNewEmails> knownWithNewEmails;
  /// Adresy nadawcy z kilku różnych wpisów `data.dart`.
  final List<AmbiguousContributor> ambiguous;
  /// Piosenki bez karty osoby: w `data.dart` nie będzie kogo dopisać.
  final Map<String, List<String>> anonymousByEmail;
  /// Zgłoszenia w cudzym imieniu: adres nadawcy jest tylko do odpisania, więc
  /// do `data.dart` nie idzie. Osobę dodającą przypisujesz ręcznie.
  final Map<String, List<String>> senderNotContributorByEmail;

  const PeopleReport({
    required this.newContributors,
    required this.knownByEmail,
    required this.anonymousByEmail,
    this.knownWithNewEmails = const [],
    this.ambiguous = const [],
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
}

/// Osoby z piosenek, które **wchodzą do apki** — czyli z `final-*.hrcpsng`,
/// po przeglądzie. Wcześniej nie ma sensu: kogo wywalisz na stronie, tego nie
/// ma po co dopisywać do `data.dart`.
List<ContributorSource> contributorSourcesOf(
  List<SongRaw> songs, {
  Map<String, List<String>> otherEmailsBySender = const {},
}) {
  final out = <ContributorSource>[];
  for (final song in songs) {
    final sender = normalizedEmail(song.contributorData?.email ?? '');
    if (sender.isEmpty) continue;
    out.add(ContributorSource(
      sender: sender,
      title: song.title,
      person: _personOf(song, sender),
      otherEmails: otherEmailsBySender[sender] ?? const [],
      // Ze śladu piosenkomatu — dlatego osoby czyta się z przyjętych piosenek,
      // nie z `final-*`.
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
        normalizedEmail(c.emailRef ?? '') == sender) return c.person;
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
  // Po tożsamości wpisu: dwie piosenki tej samej osoby to jeden komentarz.
  final withNewEmails = <RegisteredContributor, KnownWithNewEmails>{};
  final ambiguous = <String, AmbiguousContributor>{};

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
      for (final e in c.otherEmails) normalizedEmail(e),
    }..removeWhere((e) => e.isEmpty);

    // Nadawcy nie ma w `data.dart`, ale może być pod innym swoim adresem.
    final matches = <RegisteredContributor>{
      for (final e in emails)
        if (registeredPersonByEmail(e) case final r?) r,
    };
    if (matches.length > 1) {
      final prev = ambiguous[sender];
      ambiguous[sender] = AmbiguousContributor(
        sender: sender,
        matches: matches.toList(),
        songTitles: [...?prev?.songTitles, c.title],
      );
      continue;
    }
    if (matches.length == 1) {
      final registered = matches.single;
      final prev = withNewEmails[registered];
      withNewEmails[registered] = KnownWithNewEmails(
        registered: registered,
        newEmails: {
          ...?prev?.newEmails,
          for (final e in emails)
            if (registeredPersonByEmail(e) == null) e,
        }.toList(),
        songTitles: [...?prev?.songTitles, c.title],
      );
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
    knownWithNewEmails: withNewEmails.values.toList(),
    ambiguous: ambiguous.values.toList(),
    anonymousByEmail: anonymous,
    senderNotContributorByEmail: notContributor,
  );
}

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
    final name = dartConstName(n.person.name);
    final unique = uniqueName(name, taken.contains, separator: '_');
    taken.add(unique);
    if (unique != name) {
      buf.writeln('// UWAGA: w data.dart jest już $name. Jeśli to ta sama osoba, nie dodawaj');
      buf.writeln('// tej stałej, tylko dopisz jej adresy do `emails` istniejącej.');
    }
    for (final t in n.songTitles) {
      buf.writeln('// piosenka: $t');
    }
    buf.writeln(registeredContributorDartCode(RegisteredContributor(person: n.person, emails: n.emails),
        constName: unique));
  }

  if (report.knownWithNewEmails.isNotEmpty) {
    buf.writeln();
    buf.writeln('// Znani z innego adresu — dopisz do `emails` istniejącego wpisu:');
    for (final k in report.knownWithNewEmails) {
      buf.writeln('//   ${k.registered.person.name} (w data.dart pod ${k.registered.emails.join(', ')}): '
          '${k.newEmails.map(dartStringLiteral).join(', ')}  ← ${k.songTitles.join('; ')}');
    }
  }
  if (report.ambiguous.isNotEmpty) {
    buf.writeln();
    buf.writeln('// Adresy wskazują różne osoby z data.dart — sprawdź, zanim cokolwiek dopiszesz:');
    for (final a in report.ambiguous) {
      final who = [
        for (final r in a.matches) '${r.person.name} (${r.emails.join(', ')})',
      ].join(', ');
      buf.writeln('//   ${a.sender}: $who  ← ${a.songTitles.join('; ')}');
    }
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

void writePeopleDart(String path, PeopleReport report) =>
    writeText(path, emitPeopleDart(report));
