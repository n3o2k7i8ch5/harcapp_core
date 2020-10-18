import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget{

  final GlobalKey scaffoldKey;
  final PreferredSizeWidget appBar;
  final Widget drawer;
  final Widget body;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final Color backgroundColor;
  final bool avoidKeyboard;

  const AppScaffold({this.scaffoldKey, this.appBar, this.drawer, this.body, this.backgroundColor, this.bottomNavigationBar, this.floatingActionButton, this.avoidKeyboard: true});

  @override
  Widget build(BuildContext context) {

      return MediaQuery.removePadding(
          context: context,
          child: Scaffold(
            key: scaffoldKey,
            appBar: appBar,
            drawer: drawer,
            body: body,
            backgroundColor: backgroundColor,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            resizeToAvoidBottomPadding: avoidKeyboard,
          )
      );
  }

}