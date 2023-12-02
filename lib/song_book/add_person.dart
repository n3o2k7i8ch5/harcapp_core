class AddPerson{

  static const String PARAM_NAME = 'name';
  static const String PARAM_EMAIL_REF = 'email_ref';
  static const String PARAM_USER_KEY_REF = 'user_key_ref';

  final String? name;
  final String? emailRef;
  final String? userKeyRef;

  const AddPerson({this.name, this.emailRef, this.userKeyRef});

  Map<String, dynamic> toMap() => {
    PARAM_NAME: name==null?null:name!.isEmpty?null:name,
    PARAM_EMAIL_REF: emailRef==null?null:emailRef!.isEmpty?null:emailRef,
    PARAM_USER_KEY_REF: userKeyRef==null?null:userKeyRef!.isEmpty?null:userKeyRef,
  };

  static AddPerson fromRespMap(Map<String, dynamic> respMap) => AddPerson(
    name: respMap[PARAM_NAME],
    emailRef: respMap[PARAM_EMAIL_REF],
    userKeyRef: respMap[PARAM_USER_KEY_REF],
  );

  bool get isEmpty => (name == null || name!.isEmpty) &&
      (emailRef == null || emailRef!.isEmpty) &&
      (userKeyRef == null || userKeyRef!.isEmpty);

  bool get isNotEmpty => !isEmpty;

  @override
  int get hashCode{
    if(userKeyRef != null && userKeyRef!.isNotEmpty) return userKeyRef.hashCode;
    if(emailRef != null && emailRef!.isNotEmpty) return emailRef.hashCode;
    return name.hashCode;
  }

  @override
  bool operator == (Object other) {
    if(!(other is AddPerson)) return false;

    if(userKeyRef != null && userKeyRef!.isNotEmpty && userKeyRef == other.userKeyRef)
      return true;

    if(emailRef != null && emailRef!.isNotEmpty && emailRef == other.emailRef)
      return true;

    return name == other.name;
  }

}