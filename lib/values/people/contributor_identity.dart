import 'package:harcapp_core/values/people/models.dart';
import 'package:harcapp_core/values/people/utils.dart';

class ContributorIdentity{

  static const String PARAM_PERSON = 'person';
  static const String PARAM_EMAIL_REF = 'email_ref';
  static const String PARAM_USER_KEY_REF = 'user_key_ref';

  final Person? person;
  final String? emailRef;
  final String? userKeyRef;


  const ContributorIdentity({this.person, this.emailRef, this.userKeyRef});

  Map<String, dynamic> toApiJsonMap() => {
    if(person != null) PARAM_PERSON: person!.toApiJsonMap(),
    PARAM_EMAIL_REF: emailRef==null || emailRef!.trim().isEmpty?null:emailRef!.trim().toLowerCase(),
    PARAM_USER_KEY_REF: userKeyRef==null || userKeyRef!.trim().isEmpty?null:userKeyRef!.trim(),
  };

  static ContributorIdentity fromApiRespMap(Map<String, dynamic> respMap) {
    final personRaw = respMap[PARAM_PERSON];
    final Person? person = personRaw is Map<String, dynamic>
        ? Person.fromApiJsonMap(personRaw)
        : null;

    return ContributorIdentity(
      person: person,
      emailRef: respMap[PARAM_EMAIL_REF],
      userKeyRef: respMap[PARAM_USER_KEY_REF],
    );
  }

  /// Strict variant of [fromApiRespMap]: throws [StateError] if the resulting
  /// identity is empty (no `person`, `email_ref`, nor `user_key_ref`). Use on
  /// data paths where a missing identity is a bug, not a legacy artifact.
  static ContributorIdentity fromApiRespMapStrict(Map<String, dynamic> respMap) {
    final identity = fromApiRespMap(respMap);
    if(identity.isEmpty)
      throw StateError(
        '`ContributorIdentity` must specify at least one of '
        '`$PARAM_PERSON`, `$PARAM_EMAIL_REF`, `$PARAM_USER_KEY_REF`',
      );
    return identity;
  }

  Person? resolve(){

    if(emailRef != null) {
      RegisteredContributor? registeredPerson = allRegisteredPeopleByEmailMap[emailRef];
      if(registeredPerson != null)
        return registeredPerson.person;
    }

    return person;
  }

  bool get isEmpty => (emailRef == null || emailRef!.trim().isEmpty) &&
      (userKeyRef == null || userKeyRef!.trim().isEmpty) &&
      (person == null || person!.isEmpty);

  bool get isNotEmpty => !isEmpty;

  @override
  int get hashCode{
    if(userKeyRef != null && userKeyRef!.trim().isNotEmpty) return userKeyRef!.trim().hashCode;
    if(emailRef != null && emailRef!.trim().isNotEmpty) return emailRef!.trim().hashCode;
    if(person != null) return person.hashCode;
    return null.hashCode;
  }

  @override
  bool operator == (Object other) {
    if(!(other is ContributorIdentity)) return false;

    if(userKeyRef != null && userKeyRef!.trim().isNotEmpty && userKeyRef!.trim() == other.userKeyRef?.trim())
      return true;

    if(emailRef != null && emailRef!.trim().isNotEmpty && emailRef == other.emailRef?.trim())
      return true;

    return person == other.person;
  }

}
