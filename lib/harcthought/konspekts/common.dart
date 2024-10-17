import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StringListWidget extends StatelessWidget{

  final List<String> data;
  final EdgeInsets? padding;

  const StringListWidget(this.data, {this.padding, super.key});

  @override
  Widget build(BuildContext context) => SelectionArea(
    child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(
          left: Dimen.sideMarg,
          right: Dimen.sideMarg,
          bottom: Dimen.sideMarg,
        ),
        itemBuilder: (context, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(MdiIcons.circleMedium, size: Dimen.textSizeBig + 2),
            const SizedBox(width: Dimen.defMarg),
            Expanded(child: AppText(data[index], size: Dimen.textSizeBig))
          ],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: Dimen.defMarg),
        itemCount: data.length
    ),
  );

}