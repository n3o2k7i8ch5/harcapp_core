import 'package:flutter/material.dart' hide Element;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


enum ArticleSource{
  harcApp,
  azymut,
  pojutrze;

  String get displayName{
    switch(this){
      case harcApp: return 'HarcApp';
      case azymut: return 'Azymut';
      case pojutrze: return 'Pojutrze';
    }
  }

  String get name{
    switch(this){
      case harcApp: return 'harcapp';
      case azymut: return 'azymut';
      case pojutrze: return 'pojutrze';
    }
  }

  String get shaPrefTag{
    switch(this){
      case harcApp: return 'HARCAPP';
      case azymut: return 'AZYMUT';
      case pojutrze: return 'POJUTRZE';
    }
  }

  static ArticleSource? fromName(String name){
    switch(name){
      case 'harcapp': return ArticleSource.harcApp;
      case 'azymut': return ArticleSource.azymut;
      case 'pojutrze': return ArticleSource.pojutrze;
      default: return null;
    }
  }

  static Widget get icon => Icon(MdiIcons.bookOpenBlankVariant, size: 16.0);

}
