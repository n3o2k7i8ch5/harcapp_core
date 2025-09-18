import 'package:harcapp_core/values/people/data.all.g.dart';

import 'package:harcapp_core/values/people/person.dart';

Map<String, Person> _buildAllPeopleByEmailMap(){
  Map<String, Person> result = {};

  for(Person person in allPeople)
    for(String email in person.email)
      result[email] = person;

  return result;
}

final Map<String, Person> allPeopleByEmailMap = _buildAllPeopleByEmailMap();
