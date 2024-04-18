import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/graphical_resource.dart';

class ShortRead{

  final String title;
  final Color Function(BuildContext) titleColor;
  final String fileName;
  final String baseAssetsFolder;
  final GraphicalResource graphicalResource;
  final String? soundResource;
  final String? readingVoice;

  const ShortRead({
    required this.title,
    required this.titleColor,
    required this.fileName,
    required this.baseAssetsFolder,
    required this.graphicalResource,
    this.soundResource,
    this.readingVoice
  });

}