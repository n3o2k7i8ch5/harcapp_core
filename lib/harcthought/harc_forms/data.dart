import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'harc_form.dart';

List<HarcForm> allForms = [

  HarcForm(
    filename: 'przysiady_z_zerdzia',
    title: 'Przysiady z żerdzią',
    icon: MdiIcons.human,
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    tags: [HarcFormTag.kara, HarcFormTag.ruchowe, HarcFormTag.zespolowe],
    colorStart: Colors.red[600]!,
    colorEnd: Colors.orange
  ),

  HarcForm(
      filename: 'trzy_katy',
      title: 'Trzy kąty',
      icon: MdiIcons.angleRight,
      metos: [Meto.hs, Meto.wedro],
      tags: [HarcFormTag.integracja],
      colorStart: Colors.yellow[600]!,
      colorEnd: Colors.orange
  ),

  HarcForm(
      filename: 'dwuscienna_dyskusja',
      title: 'Dwuścienna dyskusja',
      icon: MdiIcons.wall,
      metos: [Meto.hs, Meto.wedro],
      tags: [HarcFormTag.argumentacja],
      colorStart: Colors.red,
      colorEnd: Colors.brown[800]!
  ),

  HarcForm(
      filename: 'niewidzialne_pismo',
      title: 'Niewidzialne pismo',
      icon: MdiIcons.fruitCitrus,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [],
      colorStart: Colors.yellow,
      colorEnd: Colors.yellow[900]!
  ),

  HarcForm(
    filename: 'warcaby_warunkowe',
    title: 'Warcaby warunkowe',
    icon: MdiIcons.chessPawn,
    metos: [Meto.harc, Meto.hs, Meto.wedro],
    tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy],
    colorStart: Colors.blueAccent,
    colorEnd: Colors.purple
  ),

  HarcForm(
    filename: 'bukmacher',
    title: 'Bukmacher',
    icon: MdiIcons.gold,
    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy],
    colorStart: Colors.yellow,
    colorEnd: Colors.deepOrange
  ),

  HarcForm(
    filename: 'tak_nie',
    title: 'Tak-nie',
    icon: MdiIcons.circleHalfFull,
    metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
    tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy, HarcFormTag.ruchowe],
    colorStart: Colors.blueGrey,
    colorEnd: Colors.black
  ),

  HarcForm(
      filename: 'wieza_papieru',
      title: 'Wieża papieru',
      icon: MdiIcons.scriptOutline,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.grey,
      colorEnd: Colors.blue
  ),

  HarcForm(
      filename: 'antymapa',
      title: 'Anty-mapa',
      icon: MdiIcons.mapOutline,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.orientacjaWTerenie],
      colorStart: Colors.orange,
      colorEnd: Colors.brown
  ),

  HarcForm(
      filename: 'pajeczyna',
      title: 'Pajęczyna',
      icon: MdiIcons.spiderWeb,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.ruchowe],
      colorStart: Colors.grey,
      colorEnd: Colors.blue
  ),

  HarcForm(
      filename: 'jaka_to_melodia',
      title: 'Jaka to melodia',
      icon: MdiIcons.music,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.muzyczne, HarcFormTag.sprawdzanieWiedzy],
      colorStart: Colors.pinkAccent,
      colorEnd: Colors.deepPurple
  ),

  HarcForm(
      filename: 'pantomima',
      title: 'Pantomima',
      icon: MdiIcons.dramaMasks,
      metos: [Meto.zuch, Meto.harc],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.green,
      colorEnd: Colors.blueAccent
  ),

  HarcForm(
      filename: 'ino',
      title: 'I.N.O.',
      icon: MdiIcons.mapMarkerOutline,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.wspolzawodnictwo, HarcFormTag.orientacjaWTerenie],
      colorStart: Colors.green[800]!,
      colorEnd: Colors.lightGreen
  ),

  HarcForm(
      filename: 'sad_nad_sprawa',
      title: 'Sąd nad sprawą',
      icon: MdiIcons.gavel,
      metos: [Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.argumentacja],
      colorStart: Colors.deepPurple,
      colorEnd: Colors.blue
  ),

  HarcForm(
      filename: 'wieza_kubeczkow',
      title: 'Wieża kubeczków',
      icon: MdiIcons.beerOutline,
      metos: [Meto.zuch, Meto.harc, Meto.hs],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.grey,
      colorEnd: Colors.orange
  ),

  HarcForm(
      filename: 'odkladanie_miotly',
      title: 'Odkładanie miotły',
      icon: MdiIcons.broom,
      metos: [Meto.zuch, Meto.harc, Meto.hs],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.orange,
      colorEnd: Colors.brown
  ),

  HarcForm(
      filename: 'milczace_ustalenia',
      title: 'Milczące ustalenia',
      icon: MdiIcons.microphoneOff,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.deepPurple,
      colorEnd: Colors.blue
  ),

  HarcForm(
      filename: 'milczaca_polwidoczna_kolejnosc',
      title: 'Milcząca, pół-widoczna kolejność',
      icon: MdiIcons.microphoneVariantOff,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe],
      colorStart: Colors.deepPurple,
      colorEnd: Colors.purpleAccent
  ),

  HarcForm(
      filename: 'pocieta_historia',
      title: 'Pocięta historia',
      icon: MdiIcons.contentCut,
      metos: [Meto.harc, Meto.hs],
      tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy],
      colorStart: Colors.orange,
      colorEnd: Colors.brown
  ),

  HarcForm(
      filename: 'grupowe_wygibasy',
      title: 'Grupowe wygibasy',
      icon: MdiIcons.gymnastics,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.ruchowe],
      colorStart: Colors.orange,
      colorEnd: Colors.red[600]!
  ),

  HarcForm(
      filename: 'dzwig_zespolowy',
      title: 'Dźwig zespołowy',
      icon: MdiIcons.crane,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.ruchowe],
      colorStart: Colors.red,
      colorEnd: Colors.deepPurple
  ),

  HarcForm(
      filename: 'okrety_podwodne',
      title: 'Okręty podwodne',
      icon: MdiIcons.submarine,
      metos: [Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.ruchowe, HarcFormTag.kontuzjogenne],
      colorStart: Colors.teal,
      colorEnd: Colors.blue[700]!
  ),

  HarcForm(
      filename: 'atomy',
      title: 'Atomy',
      icon: MdiIcons.atomVariant,
      metos: [Meto.zuch, Meto.harc],
      tags: [HarcFormTag.podzialNaGrupy, HarcFormTag.ruchowe],
      colorStart: Colors.deepPurple,
      colorEnd: Colors.blue
  ),

  HarcForm(
      filename: 'srajtasma',
      title: 'Srajtaśma',
      icon: MdiIcons.paperRoll,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.integracja],
      colorStart: Colors.grey,
      colorEnd: Colors.brown
  ),

  HarcForm(
      filename: 'postaw_na_milion',
      title: 'Postaw na milion',
      icon: MdiIcons.cashMultiple,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy],
      colorStart: Colors.teal,
      colorEnd: Colors.yellow[700]!
  ),

  HarcForm(
      filename: 'wyscig_po_totem',
      title: 'Wyścig po totem',
      icon: MdiIcons.horseshoe,
      metos: [Meto.zuch, Meto.harc, Meto.hs, Meto.wedro],
      tags: [HarcFormTag.zespolowe, HarcFormTag.sprawdzanieWiedzy, HarcFormTag.ruchowe, HarcFormTag.kontuzjogenne],
      colorStart: Colors.red,
      colorEnd: Colors.deepPurple[700]!
  ),

];