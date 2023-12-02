import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/tag/tag.dart';
import 'package:harcapp_core/tag/tags_widget.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

class SongTagsWidget extends StatelessWidget{

  final bool linear;
  final void Function(List<String> tags)? onChanged;

  const SongTagsWidget({this.linear= true, this.onChanged});

  @override
  Widget build(BuildContext context) {

    return Consumer<TagsProvider>(
      builder: (context, prov, child){

        Function onTagTap = (String tag, bool checked){
          if(checked) prov.remove(tag);
          else prov.add(tag);

          onChanged?.call(prov.checkedTags);
        };

        return Column(
          children: [

            Padding(
              padding: EdgeInsets.only(left: Dimen.ICON_MARG),
              child: TitleShortcutRowWidget(
                title: 'Tagi${prov.count==0?'':' (${prov.count})'}',
                textAlign: TextAlign.start,
                //icon: MdiIcons.tagOutline,
              ),
            ),

            if(linear)
              TagsWidget.linear(
                onTagTap: onTagTap as dynamic Function(String, bool)?,
                allTags: Tag.ALL_TAG_NAMES,
                checkedTags: prov.checkedTags,
                fontSize: Dimen.TEXT_SIZE_NORMAL,
              )
            else
              TagsWidget.wrap(
                onTagTap: onTagTap as dynamic Function(String, bool)?,
                allTags: Tag.ALL_TAG_NAMES,
                checkedTags: prov.checkedTags,
                fontSize: Dimen.TEXT_SIZE_NORMAL,
              )

          ],
        );
      },
    );
  }

}