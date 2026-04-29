import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/folder_icon.dart';

class FolderBaseTab extends StatelessWidget implements PreferredSizeWidget{

  final Widget? leading;
  final String? text;
  final Widget? textWidget;
  const FolderBaseTab({
    this.leading,
    this.text,
    this.textWidget,
    super.key
  }): assert(text != null || textWidget != null, 'Either `text` or `textWidget` must be provided');

  @override
  Widget build(BuildContext context) => Tab(
    child: IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(child: SizedBox(width: 24.0)),
          if(leading!=null) leading!,
          if(leading!=null) const SizedBox(width: 32.0),
          textWidget??Text(text!, style: const AppTextStyle(fontWeight: weightHalfBold)),
          if(leading!=null) const SizedBox(width: 12.0),
          const Flexible(child: SizedBox(width: 24.0)),
        ],
      ),
    )
  );

  @override
  Size get preferredSize => const Tab(text: '').preferredSize;

}

class FolderTwoLineTab extends StatelessWidget implements PreferredSizeWidget{

  final String? text;
  final String? subText;

  const FolderTwoLineTab({
    this.text,
    this.subText,
    super.key
  });

  @override
  Widget build(BuildContext context) => FolderBaseTab(
    textWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text!, style: const AppTextStyle(fontWeight: weightBold)),
          if(subText!=null) Text(subText!, style: const AppTextStyle()),
        ]
    ),
  );

  @override
  Size get preferredSize => const Tab(text: '').preferredSize;

}

class FolderTab extends StatelessWidget implements PreferredSizeWidget{

  final String iconKey;
  final String colorsKey;
  final String folderName;
  final String countText;
  const FolderTab({
    required this.iconKey,
    required this.colorsKey,
    required this.folderName,
    required this.countText,
    super.key
  });

  @override
  Widget build(BuildContext context) => FolderBaseTab(
    leading: FolderIcon(iconKey, colorsKey),
    text: folderName,
    textWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(folderName, style: const AppTextStyle(fontWeight: weightHalfBold)),
          Text(countText, style: const AppTextStyle()),
        ]
    ),
  );

  @override
  Size get preferredSize => const Tab(text: '').preferredSize;

}
