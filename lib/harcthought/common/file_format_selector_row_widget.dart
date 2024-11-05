import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';

import 'file_format.dart';

class FileFormatWidget extends StatelessWidget {

  final FileFormat format;

  const FileFormatWidget(this.format, {super.key});

  @override
  Widget build(BuildContext context){

    IconData? subIcon = format.subIcon;

    return Material(
        color: format.color,
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                  format.displayName,
                  style: const AppTextStyle(
                    color: Colors.black,
                    fontWeight: weight.halfBold,
                  )
              ),
            ),

            if(subIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Icon(
                  subIcon,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),

          ],
        )
    );

  }

}


class FileFormatSelectorRowWidget extends StatelessWidget{

  final Iterable<FileFormat> fileFormats;
  final void Function(FileFormat) onTap;

  const FileFormatSelectorRowWidget(
    this.fileFormats,
    { required this.onTap,
      super.key
    });

  @override
  Widget build(BuildContext context) {

    List<Widget> formatButtons = [];

    for(FileFormat format in fileFormats){
      formatButtons.add(
          Expanded(
            child: SimpleButton(
                padding: const EdgeInsets.all(Dimen.defMarg),
                radius: 0,
                color: format.color.withOpacity(.5),
                child: Center(
                  child: FileFormatWidget(format),
                ),
                onTap: () => onTap(format),
            ),
          )
      );
    }

    return Row(children: formatButtons);
  }



}