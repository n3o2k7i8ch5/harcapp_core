import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'errors.dart';

class TextProvider extends ChangeNotifier{

  static TextProvider of(BuildContext context) => Provider.of<TextProvider>(context, listen: false);
  static notify_(BuildContext context) => of(context).notify();

  late TextEditingController controller;

  TextProvider({String text = ''}){
    controller = TextEditingController(text: text);
  }

  String get text => controller.text;
  set text(String value){
    controller.text = value;
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class ChordsProvider extends ChangeNotifier{

  static ChordsProvider of(BuildContext context) => Provider.of<ChordsProvider>(context, listen: false);
  static notify_(BuildContext context) => of(context).notify();

  late TextEditingController controller;

  ChordsProvider({String chords = ''}){
    controller = TextEditingController(text: chords);
  }

  String get chords => controller.text;
  set chords(String value){
    controller.text = value;
    notifyListeners();
  }

  void notify() => notifyListeners();

}

class ErrorProvider<T extends SongEditError> extends ChangeNotifier{

  static ErrorProvider of(BuildContext context) => Provider.of<ErrorProvider>(context, listen: false);
  static notify_(BuildContext context) => of(context).notify();

  late List<T> _errorList;
  late Map<int?, T> _errorMap;

  ErrorProvider({Function(ErrorProvider<T> errProv)? init}){
    _errorList = [];
    _errorMap = {};

    if(init != null) init(this);
  }

  void add(T error){
    _errorList.add(error);
    _errorMap[error.line] = error;
  }

  int get length => _errorList.length;

  void clear(){
    _errorList.clear();
    _errorMap.clear();
  }

  T? errorAt(int line){
    return _errorMap[line];
  }

  void notify() => notifyListeners();
}
