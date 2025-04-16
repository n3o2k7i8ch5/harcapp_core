import 'package:flutter/material.dart';
import 'package:harcapp_core/harcthought/common/file_format.dart';

class Poradnik{

  static const double mainTitleHeightFactor = 0.041;
  static const double subTitleHeightFactor = 0.028;
  static const double titlePaddingFactor = 0.020;

  final String name;
  final String title;
  final int pageCount;
  final String description;
  final String? coverTitle;
  final String? coverSource;
  final List<FileFormat> formats;
  final Color? titleColor;
  final Widget Function(BuildContext context, Poradnik poradnik, double width, double height)? coverTitleBuilder;

  const Poradnik({
    required this.name,
    required this.title,
    required this.pageCount,
    required this.description,
    this.coverTitle,
    this.coverSource,
    required this.formats,
    this.titleColor,
    this.coverTitleBuilder,
  });

  String getDownloadUrl(FileFormat format) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/$name/$name.${format.extension}";

}