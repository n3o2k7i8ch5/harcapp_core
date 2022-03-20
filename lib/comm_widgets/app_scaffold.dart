import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';

import 'app_text.dart';

class AppScaffold extends StatelessWidget{

  final GlobalKey? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool avoidKeyboard;
  final bool extendBody;

  const AppScaffold({this.scaffoldKey, this.appBar, this.drawer, this.body, this.backgroundColor, this.bottomNavigationBar, this.floatingActionButton, this.avoidKeyboard: true, this.extendBody: false});

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
      context: context,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(
          child: body!,
        ),
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        resizeToAvoidBottomInset: avoidKeyboard,
        extendBody: extendBody,
      )
  );

  static void showMessage(BuildContext context, String text, {String buttonText:'Ok', Function(BuildContext)? onButtonPressed, Color? background, String? tag, Duration duration: const Duration(seconds: 3)}){

    if(kIsWeb){
      Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
        webPosition: 'center',
        timeInSecForIosWeb: duration.inSeconds,
        webShowClose: true,
      );
      return;
    }

    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
        getSnackBar(
          context,
          text,
          buttonText: buttonText,
          onButtonPressed: () => onButtonPressed!=null?onButtonPressed(context):Scaffold.of(context).hideCurrentSnackBar(),
          background: background,
          tag: tag,
          duration: duration,
        )
    );

  }

}

String? _snackBarTag;
bool _isSnackbarActive = false;
bool isSnackBarActive({String? tag}) => tag==null?_isSnackbarActive:_isSnackbarActive&&tag == _snackBarTag;

SnackBar getSnackBar(BuildContext context, String text, {String buttonText:'Ok', required Function onButtonPressed, Color? background, String? tag, Duration duration: const Duration(seconds: 3)}){

  return SnackBar(
    backgroundColor: background == null? accent_(context) : background,
    elevation: 6.0,
    behavior: SnackBarBehavior.fixed,
    content: AppText(text, color: accentIcon_(context)),
    action: SnackBarAction(
        label: buttonText,
        textColor: accentIcon_(context),
        onPressed: onButtonPressed as void Function()
    ),//
    duration: duration,
  );
}

void showMessage(GlobalKey<ScaffoldState> key, String text, {String buttonText:'Ok', Function? onButtonPressed, Color? background, String? tag, Duration duration: const Duration(seconds: 3)}){
  _snackBarTag = tag;
  _isSnackbarActive = true;
  key.currentState
    ?..hideCurrentSnackBar()
    ..showSnackBar(
        getSnackBar(
          key.currentContext!,
          text,
          buttonText: buttonText,
          onButtonPressed: () => onButtonPressed!=null?onButtonPressed():key.currentState!.hideCurrentSnackBar(),
          background: background,
          tag: tag,
          duration: duration,
        )
    ).closed.then((SnackBarClosedReason reason) => _isSnackbarActive = false);
}