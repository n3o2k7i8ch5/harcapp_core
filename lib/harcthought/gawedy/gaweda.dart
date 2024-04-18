import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/graphical_resource.dart';
import 'package:harcapp_core/harcthought/common/short_read.dart';

class Gaweda extends ShortRead{

  const Gaweda({
    required String title,
    required Color Function(BuildContext) titleColor,
    required String fileName,
    required GraphicalResource graphicalResource,
    dynamic soundResource}):super(
      title: title,
      titleColor: titleColor,
      fileName: fileName,
      graphicalResource: graphicalResource,
      soundResource: soundResource,
  );

}