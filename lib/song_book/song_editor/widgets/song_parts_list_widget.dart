import 'dart:ui';

import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:provider/provider.dart';

import '../providers.dart';
import 'song_part_card.dart';
import '../song_raw.dart';
import 'scroll_to_bottom.dart';

class SongPartsListWidget extends StatelessWidget{

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

  bool _isLastSongPartIndex(BuildContext context, int index){
    int allItemsCount = CurrentItemProvider.of(context).song.songParts.length;
    if(header != null) allItemsCount++;
    if(footer != null) allItemsCount++;
    return index == allItemsCount - 1;
  }

  int _getSongPartIndex(int index){
    if(header != null) index--;
    return index;
  }

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, _){

      List<Object> items = [
        if(header != null) header!,
        ...prov.song.songParts,
        if(footer != null) footer!,
      ];

      List<Object> fixedItems = [
        if(header != null) header!,
        if(footer != null) footer!,
      ];

      return AnimatedReorderableListView(
        buildDefaultDragHandles: false,
        proxyDecorator: proxyDecorator,
        physics: physics??BouncingScrollPhysics(),
        controller: _controller,
        items: items,
        nonDraggableItems: fixedItems,
        lockedItems: fixedItems,
        clipBehavior: Clip.none,
        dragStartDelay: kIsWeb? Duration(milliseconds: 10): Duration(milliseconds: 300),
        isSameItem: (oldItem, newItem) => oldItem.hashCode == newItem.hashCode,
        onReorder: (int oldIndex, int newIndex){
          oldIndex = _getSongPartIndex(oldIndex);
          newIndex = _getSongPartIndex(newIndex);
          final SongPart songPart = prov.song.songParts.removeAt(oldIndex);
          prov.song.songParts.insert(newIndex, songPart);
          prov.notify();
          onReorderFinished?.call();
        },
        itemBuilder: (BuildContext context, int index) => Builder(
          key: ValueKey("song_part_${items[index].hashCode}"),
          builder: (context) {

            if(index == 0 && header != null)
              return header!;

            if(_isLastSongPartIndex(context, index) && footer != null)
              return footer!;

            int songPartIndex = _getSongPartIndex(index);
            SongPart item = prov.song.songParts[songPartIndex];
            Widget child;

            if(item.isRefren(context))
              child = Consumer<RefrenPartProvider>(
                  builder: (context, prov, child) => SongPartCard(
                    type: SongPartType.REFREN,
                    songPart: item,
                    topBuilder: (context, part) => TopRefrenButtons(
                      part,
                      index: songPartIndex,
                      onDelete: (songPart) => onDelete?.call(),
                    ),
                    onTap:
                    refrenTapable? () => onPartTap?.call(songPartIndex): null,
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
                        index: songPartIndex,
                        onDuplicate: (SongPart part){
                          scrollToBottom(_controller);
                          onDuplicate?.call();
                        },
                        onDelete: (SongPart part) => onDelete?.call(),
                      ),
                      onTap: () => onPartTap?.call(songPartIndex),
                    )
                ),
              );

            return Padding(
              padding: EdgeInsets.all(Dimen.defMarg),
              child: child,
            );

          },
        ),
        padding: EdgeInsets.only(bottom: Dimen.defMarg/2),
        shrinkWrap: shrinkWrap,
        enterTransition: [FadeIn()],
        exitTransition: [SlideInDown(), FadeIn()],
      );
    },
  );

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) => AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final color = Color.lerp(background_(context), cardEnab_(context), animValue);
      final double elevation = lerpDouble(0, AppCard.bigElevation, animValue)!;
      return Material(
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        elevation: elevation,
        color: color,
        child: child,
      );
    },
    child: child,
  );

  // @override
  // Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
  //   builder: (context, prov, _) => ImplicitlyAnimatedReorderableList<SongPart>(
  //     physics: physics??BouncingScrollPhysics(),
  //     controller: _controller,
  //     items: prov.song.songParts,
  //     insertDuration: Duration(milliseconds: prov.song.songParts.length<=1?0:200),
  //     removeDuration: Duration(milliseconds: prov.song.songParts.length==0?0:500),
  //     areItemsTheSame: (oldItem, newItem) => oldItem.hashCode == newItem.hashCode,
  //     onReorderFinished: (item, from, to, newItems){
  //       prov.song.songParts = newItems;
  //       prov.notify();
  //       onReorderFinished?.call();
  //     },
  //     itemBuilder: (context, itemAnimation, item, index) => Reorderable(
  //       key: ValueKey(item.hashCode),
  //       builder: (context, dragAnimation, inDrag) {
  //         final t = dragAnimation.value;
  //         final elevation = ui.lerpDouble(0, AppCard.bigElevation, t)!;
  //         final color = Color.lerp(background_(context), cardEnab_(context), t);
  //
  //         bool isRefren = item.isRefren(context);
  //
  //         Widget child;
  //
  //         if(isRefren)
  //           child = Consumer<RefrenPartProvider>(
  //               builder: (context, prov, child) => SongPartCard(
  //                 type: SongPartType.REFREN,
  //                 songPart: item,
  //                 topBuilder: (context, part) => TopRefrenButtons(
  //                   part,
  //                   onDelete: (songPart) => onDelete?.call(),
  //                 ),
  //                 onTap:
  //                 refrenTapable?
  //                     () => onPartTap?.call(index):
  //                 null,
  //               )
  //           );
  //
  //         else
  //           child = ChangeNotifierProvider<SongPartProvider>(
  //             create: (context) => SongPartProvider(item),
  //             builder: (context, child) => Consumer<SongPartProvider>(
  //                 builder: (context, prov, child) => SongPartCard(
  //                   type: SongPartType.ZWROTKA,
  //                   songPart: item,
  //                   topBuilder: (context, part) => TopZwrotkaButtons(
  //                     part,
  //                     onDuplicate: (SongPart part){
  //                       scrollToBottom(_controller);
  //                       onDuplicate?.call();
  //                     },
  //                     onDelete: (SongPart part) => onDelete?.call(),
  //                   ),
  //                   onTap: () => onPartTap?.call(index),
  //                 )
  //             ),
  //           );
  //
  //         return SizeFadeTransition(
  //           sizeFraction: 0.7,
  //           curve: Curves.easeInOut,
  //           animation: itemAnimation,
  //           child: AppCard(
  //               clipBehavior: Clip.none,
  //               padding: EdgeInsets.zero,
  //               margin: EdgeInsets.only(
  //                   top: ITEM_TOP_MARG,
  //                   right: Dimen.defMarg,
  //                   left: Dimen.defMarg,
  //                   bottom: ITEM_BOTTOM_MARG
  //               ),
  //               radius: AppCard.bigRadius,
  //               elevation: elevation,
  //               color: color,
  //               child: child
  //           ),
  //         );
  //       },
  //     ),
  //     padding: EdgeInsets.only(bottom: Dimen.defMarg/2),
  //     shrinkWrap: shrinkWrap,
  //     header: header,
  //     footer: Column(
  //       children: [
  //
  //         AnimatedContainer(
  //           duration: Duration(milliseconds: 1),
  //           height:
  //           prov.song.songParts.isEmpty?
  //           SongPartCard.EMPTY_HEIGHT + Dimen.iconFootprint + ITEM_TOP_MARG + ITEM_BOTTOM_MARG
  //               :0,
  //           child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //
  //                 Icon(MdiIcons.musicNoteOffOutline, color: hintEnab_(context)),
  //
  //                 SizedBox(height: Dimen.iconMarg),
  //
  //                 Text(
  //                   'Pusto!\nUżyj poniższych przycisków.',
  //                   textAlign: TextAlign.center,
  //                   style: AppTextStyle(
  //                     color: hintEnab_(context),
  //                     fontSize: Dimen.textSizeBig,
  //                   ),
  //                 ),
  //               ]
  //           ),
  //         ),
  //
  //         if(footer!=null) footer!,
  //
  //       ],
  //     ),
  //   ),
  // );
  //
}