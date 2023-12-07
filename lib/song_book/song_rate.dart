import 'dart:math';

import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'song_core.dart';


class RateStatisticsClipper extends CustomClipper<Path>{

  static const double radius = 15;

  final List<double> bars;

  const RateStatisticsClipper(this.bars);

  double safeRadius(double barPrev, double barNext) =>
      min((barPrev - barNext).abs()/2, radius);

  @override
  Path getClip(Size size) {
    double totalWidth = size.width;
    double width = totalWidth/5;
    double height = size.height;
    Path path = Path();
    path.moveTo(0, height);

    double br0 = height*(1-bars[0]); // bar remainer 0
    double br1 = height*(1-bars[1]); // bar remainer 1
    double br2 = height*(1-bars[2]); // bar remainer 2
    double br3 = height*(1-bars[3]); // bar remainer 3
    double br4 = height*(1-bars[4]); // bar remainer 4

    path.lineTo(0*width, br0 + safeRadius(height, br0)); // up

    path.arcToPoint(
      Offset(0*width + safeRadius(height, br0), br0),
      radius: Radius.circular(safeRadius(height, br0)),
      rotation: 90,
    );

    // -- Bar 0
    path.lineTo(1*width - safeRadius(br0, br1), br0); // right

    if(br1 > br0) {
      path.arcToPoint(
        Offset(1*width, br0 + safeRadius(br0, br1)),
        radius: Radius.circular(safeRadius(br0, br1)),
        rotation: 90,
      );

      path.lineTo(1*width, br1 - safeRadius(br0, br1)); // down

      path.arcToPoint(
          Offset(1*width + safeRadius(br0, br1), br1),
          radius: Radius.circular(safeRadius(br0, br1)),
          rotation: -90,
          clockwise: false
      );
    }else {
      path.arcToPoint(
          Offset(1*width, br0 - safeRadius(br0, br1)),
          radius: Radius.circular(safeRadius(br0, br1)),
          rotation: -90,
          clockwise: false
      );

      path.lineTo(1*width, br1 + safeRadius(br0, br1)); // up

      path.arcToPoint(
        Offset(1*width + safeRadius(br0, br1), br1),
        radius: Radius.circular(safeRadius(br0, br1)),
        rotation: 90,
      );
    }

    // -- Bar 1
    path.lineTo(2*width - safeRadius(br1, br2), br1); // right

    if(br2 > br1) {
      path.arcToPoint(
        Offset(2*width, br1 + safeRadius(br1, br2)),
        radius: Radius.circular(safeRadius(br1, br2)),
        rotation: 90,
      );

      path.lineTo(2*width, br2 - safeRadius(br1, br2)); // down

      path.arcToPoint(
          Offset(2*width + safeRadius(br1, br2), br2),
          radius: Radius.circular(safeRadius(br1, br2)),
          rotation: -90,
          clockwise: false
      );
    }else {
      path.arcToPoint(
          Offset(2*width, br1 - safeRadius(br1, br2)),
          radius: Radius.circular(safeRadius(br1, br2)),
          rotation: -90,
          clockwise: false
      );

      path.lineTo(2*width, br2 + safeRadius(br1, br2)); // up

      path.arcToPoint(
        Offset(2*width + safeRadius(br1, br2), br2),
        radius: Radius.circular(safeRadius(br1, br2)),
        rotation: 90,
      );
    }

    // -- Bar 2
    path.lineTo(3*width - safeRadius(br2, br3), br2); // right

    if(br3 > br2) {
      path.arcToPoint(
        Offset(3*width, br2 + safeRadius(br2, br3)),
        radius: Radius.circular(safeRadius(br2, br3)),
        rotation: 90,
      );

      path.lineTo(3*width, br3 - safeRadius(br2, br3)); // down

      path.arcToPoint(
          Offset(3*width+safeRadius(br2, br3), br3),
          radius: Radius.circular(safeRadius(br2, br3)),
          rotation: -90,
          clockwise: false
      );
    }else {
      path.arcToPoint(
          Offset(3*width, br2 - safeRadius(br2, br3)),
          radius: Radius.circular(safeRadius(br2, br3)),
          rotation: -90,
          clockwise: false
      );

      path.lineTo(3*width, br3 + safeRadius(br2, br3)); // up

      path.arcToPoint(
        Offset(3*width + safeRadius(br2, br3), br3),
        radius: Radius.circular(safeRadius(br2, br3)),
        rotation: 90,
      );
    }

    // -- Bar 3
    path.lineTo(4*width - safeRadius(br3, br4), br3); // right

    if(br4 > br3) {
      path.arcToPoint(
        Offset(4*width, br3 + safeRadius(br3, br4)),
        radius: Radius.circular(safeRadius(br3, br4)),
        rotation: 90,
      );

      path.lineTo(4*width, br4 - safeRadius(br3, br4)); // down

      path.arcToPoint(
          Offset(4*width+safeRadius(br3, br4), br4),
          radius: Radius.circular(safeRadius(br3, br4)),
          rotation: -90,
          clockwise: false
      );
    }else {
      path.arcToPoint(
          Offset(4*width, br3 - safeRadius(br3, br4)),
          radius: Radius.circular(safeRadius(br3, br4)),
          rotation: -90,
          clockwise: false
      );

      path.lineTo(4*width, br4 + safeRadius(br3, br4)); // down

      path.arcToPoint(
        Offset(4*width + safeRadius(br3, br4), br4),
        radius: Radius.circular(safeRadius(br3, br4)),
        rotation: 90,
      );
    }

    // -- Bar 4
    path.lineTo(5*width - safeRadius(br4, height), br4); // right

    path.arcToPoint(
      Offset(5*width, br4 + safeRadius(br4, height)),
      radius: Radius.circular(safeRadius(br4, height)),
      rotation: 90,
    );

    path.lineTo(totalWidth, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}

class RateCard<T extends SongCore> extends StatelessWidget{

  static const double HEIGHT = RateButton.HEIGHT;

  final T song;
  final Function(int rate, bool selected)? onTap;
  final List<double>? backgroundBars;
  final Widget? bottom;

  const RateCard(this.song, {this.onTap, this.backgroundBars, this.bottom})
      :assert(backgroundBars == null || backgroundBars.length == 5);

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(Dimen.defMarg),
        child: Material(
          color: background_(context),
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(AppCard.bigRadius),
          elevation: AppCard.bigElevation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  if(backgroundBars != null)
                    SizedBox(
                      height: RateButton.HEIGHT,
                      child: ClipPath(
                          clipper: RateStatisticsClipper(backgroundBars!),
                          child: Container(
                            color: cardEnab_(context),
                          )
                      ),
                    ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RateButton.highlightableFrom(song, SongRate.RATE_1, onTap: onTap),
                      ),
                      Expanded(
                          child: RateButton.highlightableFrom(song, SongRate.RATE_2, onTap: onTap)
                      ),
                      Expanded(
                          child: RateButton.highlightableFrom(song, SongRate.RATE_3, onTap: onTap)
                      ),
                      Expanded(
                          child: RateButton.highlightableFrom(song, SongRate.RATE_4, onTap: onTap)
                      ),
                      Expanded(
                          child: RateButton.highlightableFrom(song, SongRate.RATE_5, onTap: onTap)
                      ),

                    ],
                  )
                ],
              ),

              if(bottom != null)
                bottom!

            ],
          ),
        ),
      )
  );

}

class SongRate{

  static const int RATE_NULL = 0;
  static const int RATE_1 = 1;
  static const int RATE_2 = 2;
  static const int RATE_3 = 3;
  static const int RATE_4 = 4;
  static const int RATE_5 = 5;

  static const String textLike1 = 'Tragedia';
  static const String textLike2 = 'Słabe';
  static const String textLike3 = 'Niezłe';
  static const String textLike4 = 'Świetne';
  static const String textLike5 = 'Perełka';

  static String text(int rate){
    switch(rate){
      case RATE_NULL: return '';
      case RATE_1: return textLike1;
      case RATE_2: return textLike2;
      case RATE_3: return textLike3;
      case RATE_4: return textLike4;
      case RATE_5: return textLike5;
      default: return '';
    }
  }

  static const Color colorNull = Colors.black;
  static const Color colorLike1 = Colors.orange;
  static const Color colorLike2 = Colors.lightBlueAccent;
  static const Color colorLike3 = Colors.blueAccent;
  static const Color colorLike4 = Colors.deepPurple;
  static const Color colorLike5 = Colors.pinkAccent;

  static Color color(int rate){
    switch(rate){
      case RATE_NULL: return colorNull;
      case RATE_1: return colorLike1;
      case RATE_2: return colorLike2;
      case RATE_3: return colorLike3;
      case RATE_4: return colorLike4;
      case RATE_5: return colorLike5;
      default: return colorNull;
    }
  }

  static IconData IC_DATA_NULL = MdiIcons.heartOutline;
  static IconData IC_DATA_LIKE_1 = MdiIcons.musicRestQuarter;
  static IconData IC_DATA_LIKE_2 = MdiIcons.musicRestWhole;
  static IconData IC_DATA_LIKE_3 = MdiIcons.musicNoteQuarter;
  static IconData IC_DATA_LIKE_4 = MdiIcons.musicNoteEighth;
  static IconData IC_DATA_LIKE_5 = MdiIcons.musicNoteSixteenth;

  static IconData iconData(int rate){
    switch(rate){
      case RATE_NULL: return IC_DATA_NULL;
      case RATE_1: return IC_DATA_LIKE_1;
      case RATE_2: return IC_DATA_LIKE_2;
      case RATE_3: return IC_DATA_LIKE_3;
      case RATE_4: return IC_DATA_LIKE_4;
      case RATE_5: return IC_DATA_LIKE_5;
      default: return IC_DATA_NULL;
    }
  }

  // Svg to path converter:
  // https://fluttershapemaker.com/

  static Path like1Path(Size size){
    Path path = Path();
    path.moveTo(size.width*0.4879167,size.height*0.7004167);
    path.cubicTo(size.width*0.4545833,size.height*0.7333333,size.width*0.4533333,size.height*0.7850000,size.width*0.4850000,size.height*0.8158333);
    path.lineTo(size.width*0.4245833,size.height*0.8750000);
    path.cubicTo(size.width*0.3608333,size.height*0.8125000,size.width*0.3633333,size.height*0.7095833,size.width*0.4300000,size.height*0.6441667);
    path.cubicTo(size.width*0.4520833,size.height*0.6225000,size.width*0.4791667,size.height*0.6087500,size.width*0.5066667,size.height*0.6008333);
    path.lineTo(size.width*0.3750000,size.height*0.4725000);
    path.lineTo(size.width*0.4354167,size.height*0.4133333);
    path.lineTo(size.width*0.4508333,size.height*0.3987500);
    path.cubicTo(size.width*0.4925000,size.height*0.3579167,size.width*0.4937500,size.height*0.2933333,size.width*0.4541667,size.height*0.2545833);
    path.lineTo(size.width*0.3816667,size.height*0.1841667);
    path.lineTo(size.width*0.4425000,size.height*0.1250000);
    path.lineTo(size.width*0.6158333,size.height*0.2941667);
    path.cubicTo(size.width*0.6475000,size.height*0.3254167,size.width*0.6458333,size.height*0.3770833,size.width*0.6129167,size.height*0.4095833);
    path.lineTo(size.width*0.5220833,size.height*0.4979167);
    path.lineTo(size.width*0.6666667,size.height*0.6387500);
    path.lineTo(size.width*0.6504167,size.height*0.6550000);
    path.cubicTo(size.width*0.6295833,size.height*0.6754167,size.width*0.5991667,size.height*0.6858333,size.width*0.5716667,size.height*0.6783333);
    path.cubicTo(size.width*0.5433333,size.height*0.6708333,size.width*0.5108333,size.height*0.6783333,size.width*0.4879167,size.height*0.7004167);
    path.close();
    return path;
  }

  static Path like2Path(Size size) {
    Path path = Path();
    path.moveTo(size.width*0.7500000,size.height*0.4166667);
    path.lineTo(size.width*0.6666667,size.height*0.4166667);
    path.lineTo(size.width*0.6666667,size.height*0.5833333);
    path.lineTo(size.width*0.3333333,size.height*0.5833333);
    path.lineTo(size.width*0.3333333,size.height*0.4166667);
    path.lineTo(size.width*0.2500000,size.height*0.4166667);
    path.lineTo(size.width*0.2500000,size.height*0.3750000);
    path.lineTo(size.width*0.7500000,size.height*0.3750000);
    path.lineTo(size.width*0.7500000,size.height*0.4166667);
    path.close();
    return path;
  }

  static Path like3Path(Size size){
    Path path = Path();
    path.moveTo(size.width*0.5833333,size.height*0.1250000);
    path.lineTo(size.width*0.5833333,size.height*0.5650000);
    path.cubicTo(size.width*0.5587500,size.height*0.5504167,size.width*0.5304167,size.height*0.5416667,size.width*0.5000000,size.height*0.5416667);
    path.cubicTo(size.width*0.4079167,size.height*0.5416667,size.width*0.3333333,size.height*0.6162500,size.width*0.3333333,size.height*0.7083333);
    path.cubicTo(size.width*0.3333333,size.height*0.8004167,size.width*0.4079167,size.height*0.8750000,size.width*0.5000000,size.height*0.8750000);
    path.cubicTo(size.width*0.5920833,size.height*0.8750000,size.width*0.6666667,size.height*0.8004167,size.width*0.6666667,size.height*0.7083333);
    path.lineTo(size.width*0.6666667,size.height*0.1250000);
    path.lineTo(size.width*0.5833333,size.height*0.1250000);
    path.close();

    return path;
  }

  static Path like4Path(Size size){
    Path path = Path();
    path.moveTo(size.width*0.5000000,size.height*0.1250000);
    path.lineTo(size.width*0.5000000,size.height*0.5645833);
    path.cubicTo(size.width*0.4754167,size.height*0.5504167,size.width*0.4470833,size.height*0.5416667,size.width*0.4166667,size.height*0.5416667);
    path.cubicTo(size.width*0.3245833,size.height*0.5416667,size.width*0.2500000,size.height*0.6162500,size.width*0.2500000,size.height*0.7083333);
    path.cubicTo(size.width*0.2500000,size.height*0.8004167,size.width*0.3245833,size.height*0.8750000,size.width*0.4166667,size.height*0.8750000);
    path.cubicTo(size.width*0.5087500,size.height*0.8750000,size.width*0.5833333,size.height*0.8004167,size.width*0.5833333,size.height*0.7083333);
    path.lineTo(size.width*0.5833333,size.height*0.2916667);
    path.lineTo(size.width*0.7500000,size.height*0.2916667);
    path.lineTo(size.width*0.7500000,size.height*0.1250000);
    path.lineTo(size.width*0.5000000,size.height*0.1250000);
    path.close();

    return path;
  }

  static Path like5Path(Size size){
    Path path = Path();
    path.moveTo(size.width*0.7500000,size.height*0.2916667);
    path.lineTo(size.width*0.7500000,size.height*0.1250000);
    path.lineTo(size.width*0.5000000,size.height*0.1250000);
    path.lineTo(size.width*0.5000000,size.height*0.5645833);
    path.cubicTo(size.width*0.4754167,size.height*0.5504167,size.width*0.4470833,size.height*0.5416667,size.width*0.4166667,size.height*0.5416667);
    path.cubicTo(size.width*0.3245833,size.height*0.5416667,size.width*0.2500000,size.height*0.6162500,size.width*0.2500000,size.height*0.7083333);
    path.cubicTo(size.width*0.2500000,size.height*0.8004167,size.width*0.3245833,size.height*0.8750000,size.width*0.4166667,size.height*0.8750000);
    path.cubicTo(size.width*0.5087500,size.height*0.8750000,size.width*0.5833333,size.height*0.8004167,size.width*0.5833333,size.height*0.7083333);
    path.lineTo(size.width*0.5833333,size.height*0.4583333);
    path.lineTo(size.width*0.7500000,size.height*0.4583333);
    path.lineTo(size.width*0.7500000,size.height*0.3333333);
    path.lineTo(size.width*0.5833333,size.height*0.3333333);
    path.lineTo(size.width*0.5833333,size.height*0.2916667);
    path.lineTo(size.width*0.7500000,size.height*0.2916667);
    path.close();

    return path;
  }

  static Path Function(Size) path(int rate){
    switch(rate){
      case RATE_NULL: return (Size size) => Path();
      case RATE_1: return like1Path;
      case RATE_2: return like2Path;
      case RATE_3: return like3Path;
      case RATE_4: return like4Path;
      case RATE_5: return like5Path;
      default: return (Size size) => Path();
    }
  }

  static int _disabledAlpha = 128;
  
  static Widget getIcon(int rate, {bool enabled = true, size = Dimen.ICON_SIZE, bool glow = false}) =>
      DecoratedIcon(
        iconData(rate),
        color: color(rate).withAlpha(enabled?255:_disabledAlpha),
        size: size,
        shadows: glow?[
          BoxShadow(
            blurRadius: 42.0,
            color: color(rate),
          ),
          BoxShadow(
            blurRadius: 12.0,
            color: color(rate),
          ),
        ]:null,
      );

}

class RateButton extends StatelessWidget{

  static const double HEIGHT = 2*Dimen.ICON_SIZE /*CHILD*/ + Dimen.TEXT_SIZE_SMALL /*TEXT*/ + 2* Dimen.defMarg /*PADDING*/;

  final int rate;
  final bool selected;
  final bool highlightSelectedBackground;
  final Function(int rate, bool clicked)? onTap;

  const RateButton(this.rate, this.selected, {this.highlightSelectedBackground = true, this.onTap});

  static RateButton highlightableFrom<T extends SongCore>(
      T song,
      int rate,
      { Function(int rate, bool clicked)? onTap
      }) => RateButton(rate, song.rate == rate, highlightSelectedBackground: true, onTap: onTap);


  @override
  Widget build(BuildContext context) => SimpleButton(
    radius: AppCard.bigRadius,
    color: selected && highlightSelectedBackground?backgroundIcon_(context):null,
    padding: EdgeInsets.only(top: Dimen.defMarg, bottom: Dimen.defMarg),
    margin: EdgeInsets.zero,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          child: SongRate.getIcon(
            rate,
            size: selected?(Dimen.ICON_SIZE+4):Dimen.ICON_SIZE,
            glow: selected
          ),
          height: 2*Dimen.ICON_SIZE,
        ),
        Text(
            SongRate.text(rate),
            style: AppTextStyle(
                fontSize: Dimen.TEXT_SIZE_SMALL,
                color: selected?iconEnab_(context):textEnab_(context),
                fontWeight: selected?weight.bold:weight.normal
            ),
            textAlign: TextAlign.center
        )
      ],
    ),
    onTap: () => onTap?.call(rate, selected),
  );

}

// class RateIcon{
//
//   final int rate;
//   final bool enabled;
//   final double size;
//   const RateIcon(this.rate, {this.enabled = true, this.size = Dimen.ICON_SIZE});
//
//   static Icon build(BuildContext context, int rate, {bool enabled = true, double size = Dimen.ICON_SIZE}){
//     switch(rate){
//       case SongRate.RATE_NULL: return Icon(SongRate.IC_DATA_NULL, color: iconEnab_(context));
//       case SongRate.RATE_1: return SongRate.getIconX(1);
//       case SongRate.RATE_2: return SongRate.getIcon(2);
//       case SongRate.RATE_3: return SongRate.getIcon(3);
//       case SongRate.RATE_4: return SongRate.getIcon(4);
//       case SongRate.RATE_5: return SongRate.getIcon(5);
//       default: return Icon(SongRate.IC_DATA_NULL, color: iconEnab_(context));
//     }
//   }
//
// }
