import 'package:harcapp_core/values/people/data.all.g.dart';

import 'package:harcapp_core/values/people/models.dart';

/// Klucz mapy to [normalizedEmail] — adresy w `data.dart` bywają pisane
/// wielką literą, a pytający mają adres z nagłówka mejla (zawsze małymi).
/// Bez tej normalizacji taki wpis nie dopasowałby się nigdy.
Map<String, RegisteredContributor> _buildAllRegisteredPeopleByEmailMap(){
  Map<String, RegisteredContributor> result = {};

  for(final entry in allRegisteredPeople)
    for(final email in entry.emails){
      final key = normalizedEmail(email);
      if(key.isEmpty) continue;
      result[key] = entry;
    }

  return result;
}

/// Adres w postaci, w jakiej jest kluczem [allRegisteredPeopleByEmailMap]
/// i w jakiej zapisujemy go w piosence (`ContributorRef.toApiJsonMap`).
String normalizedEmail(String email) => email.trim().toLowerCase();

/// Osoba o tym adresie, bez względu na wielkość liter i otaczające spacje.
RegisteredContributor? registeredPersonByEmail(String? email) =>
    email == null? null: allRegisteredPeopleByEmailMap[normalizedEmail(email)];

final Map<String, RegisteredContributor> allRegisteredPeopleByEmailMap = _buildAllRegisteredPeopleByEmailMap();
