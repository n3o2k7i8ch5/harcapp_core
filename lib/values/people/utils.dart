import 'package:harcapp_core/values/people/data.all.g.dart';

import 'package:harcapp_core/values/people/models.dart';

Map<String, RegisteredContributor> _buildAllRegisteredPeopleByEmailMap(){
  Map<String, RegisteredContributor> result = {};

  for(final entry in allRegisteredPeople)
    for(final email in entry.emails)
      result[email] = entry;

  return result;
}

final Map<String, RegisteredContributor> allRegisteredPeopleByEmailMap = _buildAllRegisteredPeopleByEmailMap();
