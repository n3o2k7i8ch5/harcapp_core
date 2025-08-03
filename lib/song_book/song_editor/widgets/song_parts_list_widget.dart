import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';
import 'package:implicitly_animated_reorderable_list_2/transitions.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers.dart';
import 'song_part_card.dart';
import '../song_raw.dart';
import 'scroll_to_bottom.dart';

class SongPartsListWidget extends StatelessWidget{

  static const double ITEM_TOP_MARG = Dimen.defMarg;
  static const double ITEM_BOTTOM_MARG = 12.0;

  final ScrollController _controller;
  final ScrollPhysics? physics;
  final Widget? header;
  final Widget? footer;
  final bool refrenTapable;
  final void Function(int index)? onPartTap;
  final bool shrinkWrap;
  final void Function()? onDelete;
  final void Function()? onDuplicate;
  final void Function()? onReorderFinished;

  SongPartsListWidget({
    ScrollController? controller,
    this.physics,
    this.header,
    this.footer,
    this.refrenTapable = false,
    this.onPartTap,
    this.shrinkWrap = false,
    this.onDelete,
    this.onDuplicate,
    this.onReorderFinished,
  }): _controller = controller??ScrollController();

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, _) => ImplicitlyAnimatedReorderableList<SongPart>(
      physics: physics??BouncingScrollPhysics(),
      controller: _controller,
      items: prov.song.songParts,
      insertDuration: Duration(milliseconds: prov.song.songParts.length<=1?0:200),
      removeDuration: Duration(milliseconds: prov.song.songParts.length==0?0:500),
      areItemsTheSame: (oldItem, newItem) => oldItem.hashCode == newItem.hashCode,
      onReorderFinished: (item, from, to, newItems){
        prov.song.songParts = newItems;
        prov.notify();
        onReorderFinished?.call();
      },
      itemBuilder: (context, itemAnimation, item, index) => Reorderable(
        key: ValueKey(item.hashCode),
        builder: (context, dragAnimation, inDrag) {
          final t = dragAnimation.value;
          final elevation = ui.lerpDouble(0, AppCard.bigElevation, t)!;
          final color = Color.lerp(background_(context), cardEnab_(context), t);

          bool isRefren = item.isRefren(context);

          Widget child;

          if(isRefren)
            child = Consumer<RefrenPartProvider>(
                builder: (context, prov, child) => SongPartCard(
                  type: SongPartType.REFREN,
                  songPart: item,
                  topBuilder: (context, part) => TopRefrenButtons(
                    part,
                    onDelete: (songPart) => onDelete?.call(),
                  ),
                  onTap:
                  refrenTapable?
                      () => onPartTap?.call(index):
                  null,
                )
            );

          else
            child = ChangeNotifierProvider<SongPartProvider>(
              create: (context) => SongPartProvider(item),
              builder: (context, child) => Consumer<SongPartProvider>(
                  builder: (context, prov, child) => SongPartCard(
                    type: SongPartType.ZWROTKA,
                    songPart: item,
                    topBuilder: (context, part) => TopZwrotkaButtons(
                      part,
                      onDuplicate: (SongPart part){
                        scrollToBottom(_controller);
                        onDuplicate?.call();
                      },
                      onDelete: (SongPart part) => onDelete?.call(),
                    ),
                    onTap: () => onPartTap?.call(index),
                  )
              ),
            );

          return SizeFadeTransition(
            sizeFraction: 0.7,
            curve: Curves.easeInOut,
            animation: itemAnimation,
            child: AppCard(
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.only(
                    top: ITEM_TOP_MARG,
                    right: Dimen.defMarg,
                    left: Dimen.defMarg,
                    bottom: ITEM_BOTTOM_MARG
                ),
                radius: AppCard.bigRadius,
                elevation: elevation,
                color: color,
                child: child
            ),
          );
        },
      ),
      padding: EdgeInsets.only(bottom: Dimen.defMarg/2),
      shrinkWrap: shrinkWrap,
      header: header,
      footer: Column(
        children: [

          AnimatedContainer(
            duration: Duration(milliseconds: 1),
            height:
            prov.song.songParts.isEmpty?
            SongPartCard.EMPTY_HEIGHT + Dimen.iconFootprint + ITEM_TOP_MARG + ITEM_BOTTOM_MARG
                :0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(MdiIcons.musicNoteOffOutline, color: hintEnab_(context)),

                  SizedBox(height: Dimen.iconMarg),

                  Text(
                    'Pusto!\nUżyj poniższych przycisków.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle(
                      color: hintEnab_(context),
                      fontSize: Dimen.textSizeBig,
                    ),
                  ),
                ]
            ),
          ),

          if(footer!=null) footer!,

        ],
      ),
    ),
  );

}