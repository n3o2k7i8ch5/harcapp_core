class MissingDecodeParamError extends Error{

  String paramName;

  MissingDecodeParamError(this.paramName);

  @override
  String toString() => 'MissingDecodeParamError. Missing param: $paramName.';

}

class InvalidDecodeParamError extends Error{

  String paramName;
  dynamic paramValue;

  InvalidDecodeParamError(this.paramName, this.paramValue);

  @override
  String toString() => 'InvalidDecodeParamError. Invalid value: "$paramValue" for param: "$paramName".';

}