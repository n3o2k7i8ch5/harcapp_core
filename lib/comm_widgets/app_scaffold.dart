import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';

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

  static void showMessage(
      BuildContext context,
      String text,
      { String buttonText:'Ok',
        Function()? onButtonPressed,
        Color? backgroundColor,
        Color? textColor,
        Duration duration: const Duration(seconds: 3)
      }){

    if(kIsWeb){
      Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0,
        webPosition: 'center',
        timeInSecForIosWeb: duration.inSeconds,
        webShowClose: true,
      );
      return;
    }

    showAppToast(
      context,
      text: text,
      background: backgroundColor,
      textColor: textColor,
      duration: duration,

      buttonText: buttonText,
      onButtonPressed: () => onButtonPressed==null?null:onButtonPressed()
    );

  }

}
