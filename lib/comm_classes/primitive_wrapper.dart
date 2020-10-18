class PrimitiveWrapper<T> {

  T _value;
  PrimitiveWrapper(this._value);

  T get(){return _value;}
  set(T value){
    this._value = value;
  }

}