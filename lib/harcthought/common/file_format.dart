import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_dropdown.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum FileFormat implements IconTextEnum{
  pdf, docx, png, webp, svg, url, urlPdf, urlDocx, urlPng, urlWebp, urlSvg;

  Color get color{
    switch(this){
      case pdf: return Colors.red;
      case docx: return Colors.blue;
      case png: return Colors.yellow[600]!;
      case webp: return Colors.orange;
      case svg: return Colors.deepPurpleAccent;
      case url: return Colors.grey;
      case urlPdf: return Colors.red;
      case urlDocx: return Colors.blue;
      case urlPng: return Colors.yellow[600]!;
      case urlWebp: return Colors.orange;
      case urlSvg: return Colors.deepPurpleAccent;
    }
  }

  static FileFormat? fromName(String name){
    switch(name.toLowerCase()){
      case 'pdf': return FileFormat.pdf;
      case 'docx': return FileFormat.docx;
      case 'png': return FileFormat.png;
      case 'webp': return FileFormat.webp;
      case 'svg': return FileFormat.svg;
      case 'url': return FileFormat.url;
      case 'urlpdf': return FileFormat.urlPdf;
      case 'urldocx': return FileFormat.urlDocx;
      case 'urlpng': return FileFormat.urlPng;
      case 'urlwebp': return FileFormat.urlWebp;
      case 'urlsvg': return FileFormat.urlSvg;
      default: return null;
    }
  }

  String get displayName{
    switch(this){
      case pdf: return 'PDF';
      case docx: return 'DOC';
      case png: return 'PNG';
      case webp: return 'WEBP';
      case svg: return 'SVG';
      case url: return 'URL';
      case urlPdf: return 'PDF';
      case urlDocx: return 'DOC';
      case urlPng: return 'PNG';
      case urlWebp: return 'WEBP';
      case urlSvg: return 'SVG';
    }
  }

  bool get isUrl{
    switch(this){
      case url:
      case urlPdf:
      case urlDocx:
      case urlPng:
      case urlWebp:
      case urlSvg: return true;
      default: return false;
    }}

  IconData? get subIcon{
    if(isUrl && this != url) return MdiIcons.web;
    else return null;
  }

  String get extension{
    switch(this){
      case pdf: return 'pdf';
      case docx: return 'docx';
      case png: return 'png';
      case webp: return 'webp';
      case svg: return 'svg';
      case url: return '';
      case urlPdf: return 'pdf';
      case urlDocx: return 'docx';
      case urlPng: return 'png';
      case urlWebp: return 'webp';
      case urlSvg: return 'svg';
    }
  }

  @override
  String get text => displayName;

  @override
  IconData get icon => subIcon??MdiIcons.fileOutline;

}