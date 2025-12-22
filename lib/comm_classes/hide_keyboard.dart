import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<void> hideKeyboard(BuildContext context) async {
  FocusScopeNode focusScope = FocusScope.of(context);
  await SystemChannels.textInput.invokeMethod('TextInput.hide');
  focusScope.unfocus();
}