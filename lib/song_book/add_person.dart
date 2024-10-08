class AddPerson{

  static const String PARAM_NAME = 'name';
  static const String PARAM_EMAIL_REF = 'email_ref';
  static const String PARAM_USER_KEY_REF = 'user_key_ref';

  final String? name;
  final String? emailRef;
  final String? userKeyRef;

  const AddPerson({this.name, this.emailRef, this.userKeyRef});

  Map<String, dynamic> toMap() => {
    PARAM_NAME: name==null || name!.trim().isEmpty?null:name!.trim(),
    PARAM_EMAIL_REF: emailRef==null || emailRef!.trim().isEmpty?null:emailRef!.trim().toLowerCase(),
    PARAM_USER_KEY_REF: userKeyRef==null || userKeyRef!.trim().isEmpty?null:userKeyRef!.trim(),
  };

  static AddPerson fromRespMap(Map<String, dynamic> respMap) => AddPerson(
    name: respMap[PARAM_NAME],
    emailRef: respMap[PARAM_EMAIL_REF],
    userKeyRef: respMap[PARAM_USER_KEY_REF],
  );

  bool get isEmpty => (name == null || name!.trim().isEmpty) &&
      (emailRef == null || emailRef!.trim().isEmpty) &&
      (userKeyRef == null || userKeyRef!.trim().isEmpty);

  bool get isNotEmpty => !isEmpty;

  @override
  int get hashCode{
    if(userKeyRef != null && userKeyRef!.trim().isNotEmpty) return userKeyRef!.trim().hashCode;
    if(emailRef != null && emailRef!.trim().isNotEmpty) return emailRef!.trim().hashCode;
    if(name != null && name!.trim().isNotEmpty) return name!.trim().hashCode;
    return null.hashCode;
  }

  @override
  bool operator == (Object other) {
    if(!(other is AddPerson)) return false;

    if(userKeyRef != null && userKeyRef!.trim().isNotEmpty && userKeyRef!.trim() == other.userKeyRef?.trim())
      return true;

    if(emailRef != null && emailRef!.trim().isNotEmpty && emailRef == other.emailRef?.trim())
      return true;

    return name?.trim() == other.name?.trim();
  }

}