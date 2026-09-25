import 'package:piosenkomat/hrcpsng.dart';
import 'package:piosenkomat/similarity.dart';
import 'package:piosenkomat/classify.dart';
import 'package:piosenkomat/model.dart';
import 'package:piosenkomat/people.dart';
import 'package:piosenkomat/plan.dart';
import 'package:harcapp_core/values/people/data.all.g.dart';
import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';
import 'package:harcapp_core/values/rank_harc.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _jan = RegisteredContributor(
  person: Person(
    name: 'Jan Skłodowski-Testowy',
    druzyna: "33. CDH „Czarne stopy” im. O'Briena",
    srodowisko: Srodowisko.hufiec('ziemi_cieszynskiej', showChoragiew: false, showOkreg: false),
    rankHarc: RankHarc.dhc,
  ),
  emails: ['jan.testowy@example.com', 'Jan.Drugi@Example.com'],
);

void _indexTests() {
  test('każdy adres z bazy ludzi daje się odnaleźć', () {
    // Indeks kluczuje adresem znormalizowanym, a pytający mają adres
    // z nagłówka mejla (małymi literami). Wpis pisany wielką literą bez tego
    // nie dopasowałby się nigdy i wracałby jako „nowa osoba”.
    final zgubione = [
      for (final osoba in allRegisteredPeople)
        for (final email in osoba.emails)
          if (registeredPersonByEmail(email) == null) email,
    ];
    expect(zgubione, isEmpty);
  });

  test('wielkość liter i spacje w pytaniu nie mają znaczenia', () {
    final email = allRegisteredPeople
        .expand((o) => o.emails)
        .firstWhere((e) => e.trim().isNotEmpty);
    final osoba = registeredPersonByEmail(email);
    expect(osoba, isNotNull);
    expect(registeredPersonByEmail(email.toUpperCase()), same(osoba));
    expect(registeredPersonByEmail('  ${email.toLowerCase()} '), same(osoba));
    expect(registeredPersonByEmail(null), isNull);
  });
}

/// Tak, jak robi to `strip`: osoby z piosenek, które wchodzą, plus dodatkowe
/// adresy z planu przebiegu.
PeopleReport peopleOf(List<Classified> items) => collectPeople(
      contributorSourcesOf(
        [for (final c in items) if (c.goesToFile) c.song!],
        otherEmailsBySender: otherEmailsBySender(RunPlan.fromClassified(items)),
      ),
    );

void main() {
  _indexTests();
  test('nowa osoba: stała jak w data.dart, nadawca pierwszy w emails', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(registered: _jan), id: 'a'),
    ], book: SongBook.empty);
    final report = peopleOf(items);
    expect(report.newContributors, hasLength(1));
    final n = report.newContributors.single;
    expect(n.emails, ['jan.testowy@example.com', 'jan.drugi@example.com']);
    expect(n.songTitles, ['Piosenka testowa XYZ']);

    final dart = emitPeopleDart(report);
    expect(dart, contains('const RegisteredContributor JAN_SKLODOWSKI_TESTOWY = RegisteredContributor('));
    expect(dart, contains("name: 'Jan Skłodowski-Testowy',"));
    expect(dart, contains(r"druzyna: '33. CDH „Czarne stopy” im. O\'Briena',"));
    expect(dart, contains("srodowisko: Srodowisko.hufiec('ziemi_cieszynskiej', showChoragiew: false, showOkreg: false),"));
    expect(dart, contains('rankHarc: RankHarc.dhc,'));
    expect(dart, contains("emails: ['jan.testowy@example.com', 'jan.drugi@example.com'],"));
    expect(dart, contains('// piosenka: Piosenka testowa XYZ'));
  });

  test('ta sama osoba w dwu piosenkach → jedna stała, dwa tytuły', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(registered: _jan), id: 'a'),
      msgFrom(await completeEmail(registered: _jan, song: sampleSong(title: 'Druga', lyrics: 'Zupełnie inny tekst o morzu i żaglach')), id: 'b'),
    ], book: SongBook.empty);
    final report = peopleOf(items);
    expect(report.newContributors, hasLength(1));
    expect(report.newContributors.single.songTitles, hasLength(2));
  });

  test('nadawca już w data.dart → nic do dopisania', () async {
    final known = allRegisteredPeople.firstWhere((r) => r.emails.isNotEmpty);
    final email = known.emails.first;
    final items = classifyBatch([
      msgFrom(await completeEmail(from: 'Ktoś <$email>', registered: known), id: 'a'),
    ], book: SongBook.empty);
    final report = peopleOf(items);
    expect(report.newContributors, isEmpty);
    expect(report.knownByEmail.keys, [email.toLowerCase()]);
    expect(emitPeopleDart(report), contains('// Już w data.dart'));
  });

  test('bez bloku osoby → tylko adnotacja', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(), id: 'a'),
    ], book: SongBook.empty);
    final report = peopleOf(items);
    expect(report.newContributors, isEmpty);
    expect(report.anonymousByEmail.keys, ['jan.testowy@example.com']);
  });

  test('kolizja nazwy stałej dostaje sufiks i ostrzeżenie', () async {
    final existing = allRegisteredPeople.first.person.name;
    final clash = RegisteredContributor(
      person: Person(name: existing),
      emails: const ['nowy.adres.xyz@example.com'],
    );
    final items = classifyBatch([
      msgFrom(await completeEmail(from: 'X <nowy.adres.xyz@example.com>', registered: clash), id: 'a'),
    ], book: SongBook.empty);
    final dart = emitPeopleDart(peopleOf(items));
    expect(dart, contains('const RegisteredContributor ${dartConstName(existing)}_2 = '));
    expect(dart, contains('// UWAGA: w data.dart jest już ${dartConstName(existing)}.'));
  });

  test('osoba przeżywa plik i strip; wywalona przy przeglądzie nie wchodzi', () async {
    final items = classifyBatch([
      msgFrom(await completeEmail(registered: _jan), id: 'a'),
      msgFrom(
        await completeEmail(
          from: 'Ewa Testowa <ewa.testowa@example.com>',
          registered: const RegisteredContributor(
            person: Person(name: 'Ewa Testowa'),
            emails: ['ewa.testowa@example.com'],
          ),
          song: sampleSong(title: 'Wywalona', lyrics: 'Zupełnie inny tekst o morzu i żaglach'),
        ),
        id: 'b',
      ),
    ], book: SongBook.empty);
    final plan = RunPlan.fromClassified(items);

    // Tak jak strona: piosenki przez plik i z powrotem, jednej brak.
    final dir = tempDir();
    final path = '${dir.path}/reviewed-new.hrcpsng';
    writeHrcpsng(path, [for (final c in items) c.song!], withPiosenkomatData: true);
    final reviewed = [
      for (final s in readHrcpsng(path)) if (s.title != 'Wywalona') s,
    ];
    stripPiosenkomat(reviewed);

    final report = collectPeople(contributorSourcesOf(reviewed,
        otherEmailsBySender: otherEmailsBySender(plan)));
    expect(report.newContributors.map((n) => n.person.name), ['Jan Skłodowski-Testowy'],
        reason: 'osoba tylko od wywalonej piosenki nie ma po co wchodzić do data.dart');
    expect(report.newContributors.single.emails,
        ['jan.testowy@example.com', 'jan.drugi@example.com'],
        reason: 'drugi adres piosenka gubi — dokłada go plan przebiegu');
  });

  test('dartConstName', () {
    expect(dartConstName('Agnieszka Radecka-Kubicka'), 'AGNIESZKA_RADECKA_KUBICKA');
    expect(dartConstName('  Łukasz  Żółw '), 'LUKASZ_ZOLW');
  });

  test('srodowisko: custom z orgSlug i org bez flag', () {
    final r = PeopleReport(
      newContributors: [
        NewContributor(
          person: const Person(name: 'A B', srodowisko: Srodowisko.custom('Eldorado', orgSlug: 'zhr')),
          emails: const ['a@b.pl'],
          songTitles: const ['x'],
        ),
        NewContributor(
          person: const Person(name: 'C D', srodowisko: Srodowisko.org('zhp')),
          emails: const ['c@d.pl'],
          songTitles: const ['y'],
        ),
      ],
      knownByEmail: const {},
      anonymousByEmail: const {},
    );
    final dart = emitPeopleDart(r);
    expect(dart, contains("Srodowisko.custom('Eldorado', orgSlug: 'zhr')"));
    expect(dart, contains("Srodowisko.org('zhp')"));
  });
}
