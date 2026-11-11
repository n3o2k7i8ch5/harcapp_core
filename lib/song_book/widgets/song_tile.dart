import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';

import '../song_core.dart';

/// Kafelek spisu treści śpiewnika — wspólny dla apki i strony.
class BaseSongTile extends StatelessWidget{

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Color? background;
  final Function()? onTap;

  const BaseSongTile({required this.child, this.leading, this.trailing, this.background, this.onTap, super.key});

  @override
  Widget build(BuildContext context) => SimpleButton(
    color: background??cardEnab_(context),
    radius: AppCard.bigRadius,
    onTap: onTap,
    child: Row(
      children: [

        if(leading != null)
          leading!,

        Expanded(child: child),

        if(trailing != null)
          trailing!

      ],
    ),
  );

}

/// Piosenka w spisie treści: tytuł, wykonawcy, tagi.
class SongTile<TSong extends SongCore> extends StatelessWidget{

  static const double linesSep = 6.0;

  static const double contentHeight = Dimen.textSizeNormal + 2*linesSep + 2*Dimen.textSizeTiny;
  static const double height = 2*Dimen.iconMarg + contentHeight;

  static String tagsAsString(SongCore song){
    String text = '';
    for(String tag in song.tags)
      text += '$tag    ';
    if(text.isEmpty) return '#';
    return text;
  }

  final TSong song;
  final Widget? leading;
  final Widget? trailing;
  final Color? background;
  final Function(TSong)? onTap;

  const SongTile(this.song, {this.leading, this.trailing, this.background, this.onTap, super.key});

  @override
  Widget build(BuildContext context) => BaseSongTile(
    leading: leading,
    trailing: trailing,
    background: background,
    onTap: onTap == null?null:() => onTap!(song),
    child: Padding(
      padding: EdgeInsets.all(Dimen.iconMarg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              if(!song.isOfficial)
                Icon(MdiIcons.pencil, size: Dimen.textSizeNormal, color: hintEnab_(context)),

              if(!song.isOfficial)
                const SizedBox(width: Dimen.defMarg),

              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '${song.title} ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                          fontWeight: weightHalfBold,
                          color: textEnab_(context),
                          fontSize: Dimen.textSizeNormal
                      ),
                    ),
                  )
              )

            ],
          ),

          if(song.performers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: linesSep),
              child: Text(
                  song.performersStr,
                  style: AppTextStyle(
                      fontWeight: weightHalfBold,
                      fontSize: Dimen.textSizeTiny,
                      color: hintEnab_(context)
                  ),
                  maxLines: 1
              ),
            ),

          Padding(
              padding: const EdgeInsets.only(top: linesSep),
              child: Text(
                  tagsAsString(song),
                  style: AppTextStyle(
                      fontSize: Dimen.textSizeTiny,
                      fontWeight: weightHalfBold,
                      color: hintEnab_(context)
                  ),
                  maxLines: 1
              )
          ),

          if(song.performers.isEmpty)
            const SizedBox(height: Dimen.textSizeTiny + linesSep)

        ],
      ),
    ),
  );

}
