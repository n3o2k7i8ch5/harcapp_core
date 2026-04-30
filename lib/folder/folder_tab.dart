import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';

import 'folder_icon.dart';

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

  final Widget? leading;
  final String text;
  final String? subText;
  final CrossAxisAlignment textAlignment;
  final TextStyle? subTextStyle;

  const FolderTwoLineTab({
    this.leading,
    required this.text,
    this.subText,
    this.textAlignment = CrossAxisAlignment.start,
    this.subTextStyle,
    super.key
  });

  @override
  Widget build(BuildContext context) => FolderBaseTab(
    leading: leading,
    textWidget: Column(
        crossAxisAlignment: textAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const AppTextStyle(fontWeight: weightHalfBold)),
          if(subText!=null) Text(subText!, style: subTextStyle ?? const AppTextStyle()),
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
  final CrossAxisAlignment textAlignment;
  final TextStyle? countTextStyle;
  const FolderTab({
    required this.iconKey,
    required this.colorsKey,
    required this.folderName,
    required this.countText,
    this.textAlignment = CrossAxisAlignment.start,
    this.countTextStyle,
    super.key
  });

  @override
  Widget build(BuildContext context) => FolderTwoLineTab(
    leading: FolderIcon(iconKey, colorsKey),
    text: folderName,
    subText: countText,
    textAlignment: textAlignment,
    subTextStyle: countTextStyle,
  );

  @override
  Size get preferredSize => const Tab(text: '').preferredSize;

}
