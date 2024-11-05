import 'package:flutter/material.dart';

enum PoradnikFormat{
  pdf,
  docx;

  String get title{
    switch(this){
      case PoradnikFormat.pdf: return 'PDF';
      case PoradnikFormat.docx: return 'DOCX';
    }
  }

  String get extension{
    switch(this){
      case PoradnikFormat.pdf: return 'pdf';
      case PoradnikFormat.docx: return 'docx';
    }
  }
}

class Poradnik{

  static const double mainTitleHeightFactor = 0.041;
  static const double subTitleHeightFactor = 0.028;
  static const double titlePaddingFactor = 0.018;

  final String name;
  final String title;
  final String? coverTitle;
  final List<PoradnikFormat> formats;
  final Color? titleColor;
  final Widget Function(BuildContext context, Poradnik poradnik, double width, double height)? coverTitleBuilder;
  
  const Poradnik({
    required this.name,
    required this.title,
    this.coverTitle,
    required this.formats,
    this.titleColor,
    this.coverTitleBuilder
  });

  String getDownloadUrl(PoradnikFormat format) => "https://gitlab.com/n3o2k7i8ch5/harcapp_data/raw/master/poradniki/$name/$name.${format.extension}";

}