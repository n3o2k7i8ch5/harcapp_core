import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../comm_classes/app_navigator.dart';

class AppBarBackButton extends StatelessWidget{

  const AppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) => AppButton(
    icon: Icon(MdiIcons.arrowLeft),
    onTap: () => popPage(context),
  );

}