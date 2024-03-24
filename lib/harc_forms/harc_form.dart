import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum HarcFormTag{
  argumentacja, integracja, kontuzjogenne, muzyczne, orientacjaWTerenie,
  podzialNaGrupy, ruchowe, sprawdzanieWiedzy, wspolzawodnictwo, wyjazdowe, zespolowe;

  String get text{
   switch(this){
     case argumentacja: return 'Argumentacja';
     case integracja: return 'Integracja';
     case kontuzjogenne: return 'Kontuzjogenne';
     case muzyczne: return 'Muzyczne';
     case orientacjaWTerenie: return 'Orientacja w terenie';
     case podzialNaGrupy: return 'Podział na grupy';
     case ruchowe: return 'Ruchowe';
     case sprawdzanieWiedzy: return 'Sprawdz. wiedzy';
     case wspolzawodnictwo: return 'Współzawodnictwo';
     case wyjazdowe: return 'Wyjazdowe';
     case zespolowe: return 'Zespołowe';
   }
  }

  IconData get icon{
    switch(this){
      case argumentacja: return MdiIcons.commentText;
      case integracja: return MdiIcons.handshake;
      case kontuzjogenne: return MdiIcons.accountInjury;
      case muzyczne: return MdiIcons.music;
      case orientacjaWTerenie: return MdiIcons.map;
      case podzialNaGrupy: return MdiIcons.accountGroup;
      case ruchowe: return MdiIcons.run;
      case sprawdzanieWiedzy: return MdiIcons.school;
      case wspolzawodnictwo: return MdiIcons.trophy;
      case wyjazdowe: return MdiIcons.tent;
      case zespolowe: return MdiIcons.accountMultiple;
    }
  }

}

class HarcForm{

  final String filename;
  final String title;
  final IconData icon;
  final List<Meto> metos;
  final List<HarcFormTag> tags;
  final Color colorStart;
  final Color colorEnd;

  const HarcForm({
    required this.filename,
    required this.title,
    required this.icon,
    required this.metos,
    required this.tags,
    required this.colorStart,
    required this.colorEnd
  });
  
  bool containsMetos(Iterable<Meto> metos){
    if(this.metos.isEmpty && metos.isNotEmpty) return false;

    for(Meto meto in metos)
      if(!this.metos.contains(meto))
        return false;

    return true;
  }
  
  bool containsTags(Iterable<HarcFormTag> tags){
    if(this.tags.isEmpty && tags.isNotEmpty) return false;

    for(HarcFormTag tag in tags)
      if(!this.tags.contains(tag))
        return false;

    return true;
  }

}