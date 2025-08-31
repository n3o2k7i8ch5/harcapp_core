import 'package:flutter/widgets.dart';
import 'package:harcapp_core/comm_widgets/title_show_row_widget.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/song_book/song_tags.dart';
import 'package:harcapp_core/tag/tags_widget.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

class SongTagsWidget extends StatelessWidget{

  final bool linear;
  final EdgeInsets padding;
  final void Function(List<String> tags)? onChanged;

  const SongTagsWidget({
    this.linear= true,
    this.padding = EdgeInsets.zero,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) => Consumer<TagsProvider>(
    builder: (context, prov, child){

      Function onTagTap = (String tag, bool checked){
        if(checked) prov.remove(tag);
        else prov.add(tag);

        onChanged?.call(prov.checkedTags);
      };

      return Column(
        children: [

          SizedBox(height: padding.top),

          Padding(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            child: TitleShortcutRowWidget(
              title: 'Tagi${prov.count==0?'':' (${prov.count})'}',
              textAlign: TextAlign.left,
            ),
          ),

          if(linear)
            TagsWidget.linear(
              onTagTap: onTagTap as dynamic Function(String, bool)?,
              allTags: SongTag.ALL,
              padding: EdgeInsets.only(left: padding.left, right: padding.right),
              checkedTags: prov.checkedTags,
              fontSize: Dimen.textSizeNormal,
            )
          else
            TagsWidget.wrap(
              onTagTap: onTagTap as dynamic Function(String, bool)?,
              allTags: SongTag.ALL,
              padding: EdgeInsets.only(left: padding.left, right: padding.right),
              checkedTags: prov.checkedTags,
              fontSize: Dimen.textSizeNormal,
            ),

          SizedBox(height: padding.bottom),

        ],
      );
    },
  );

}