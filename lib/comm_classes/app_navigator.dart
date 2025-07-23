import 'package:flutter/material.dart';

Duration get pageTransDuration{
  MaterialPageRoute route = MaterialPageRoute<Scaffold>(
      builder: (context) => Container()
  );
  if(route.navigator == null) return Duration(milliseconds: 300);
  return route.transitionDuration;
}

Future<void> popPage(BuildContext context, {bool root = false}) async {
  Navigator.of(context, rootNavigator: root).pop();
  await Future.delayed(pageTransDuration);
}

Future pushPage(BuildContext context, {required Widget Function(BuildContext) builder}) => Navigator.push(
    context,
    MaterialPageRoute(builder: builder)
);

Future pushReplacePage(BuildContext context, {required Widget Function(BuildContext) builder}) {
  ScaffoldState? state;
  try{
    state = Scaffold.of(context);
  } catch(e) {}
  if(state != null && state.isDrawerOpen){
    state.closeDrawer();
    return pushPage(context, builder: builder);
  }else
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: builder)
    );
}
