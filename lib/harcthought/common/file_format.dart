import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum FileFormat{
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

  IconData? get subIcon{
    switch(this){
      case pdf:
      case docx:
      case png:
      case webp:
      case svg:
      case url: return null;
      case urlPdf:
      case urlDocx:
      case urlPng:
      case urlWebp:
      case urlSvg: return MdiIcons.web;
    }
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

}