import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'song_core.dart';

class RateCard<T extends SongCore> extends StatelessWidget{

  static const double HEIGHT = RateButton.HEIGHT;

  final T song;
  final Function(int rate, bool selected)? onTap;
  final List<double>? backgroundBars;

  const RateCard(this.song, {this.onTap, this.backgroundBars})
      :assert(backgroundBars == null || backgroundBars.length == 5);

  Widget wrapBackgdoundBar({
    required BuildContext context,
    required int index,
    required Widget child,
  }){
    if(backgroundBars == null) return child;

    return Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: RateButton.HEIGHT*backgroundBars![index],
            child: Container(color: backgroundIcon_(context))
        ),
        child,
      ],
    );

  }

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.topCenter,
      child: AppCard(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.all(Dimen.defMarg),
          radius: AppCard.bigRadius,
          elevation: AppCard.bigElevation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: wrapBackgdoundBar(
                      context: context,
                      index: 0,
                      child: RateButton.from(song, SongRate.textLike1, SongRate.getIcon(1), SongRate.RATE_1, onTap),
                    ),
                  ),
                  Expanded(
                      child: wrapBackgdoundBar(
                          context: context,
                          index: 1,
                          child: RateButton.from(song, SongRate.textLike2, SongRate.getIcon(2), SongRate.RATE_2, onTap)
                      )
                  ),
                  Expanded(
                      child: wrapBackgdoundBar(
                          context: context,
                          index: 2,
                          child: RateButton.from(song, SongRate.textLike3, SongRate.getIcon(3), SongRate.RATE_3, onTap)
                      )
                  ),
                  Expanded(
                      child: wrapBackgdoundBar(
                          context: context,
                          index: 3,
                          child: RateButton.from(song, SongRate.textLike4, SongRate.getIcon(4), SongRate.RATE_4, onTap)
                      )
                  ),
                  Expanded(
                    child: wrapBackgdoundBar(
                        context: context,
                        index: 4,
                        child: RateButton.from(song, SongRate.textLike5, SongRate.getIcon(5), SongRate.RATE_5, onTap)
                    ),
                  ),

                ],
              ),
            ],
          )
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

  static Icon getIcon(int rate, {enabled = true, size = Dimen.ICON_SIZE}) => Icon(iconData(rate), color: color(rate).withAlpha(enabled?255:_disabledAlpha), size: size,);

}

class RateButton extends StatelessWidget{

  static const double HEIGHT = 2*Dimen.ICON_SIZE /*CHILD*/ + Dimen.TEXT_SIZE_SMALL /*TEXT*/ + 2* Dimen.defMarg /*PADDING*/;

  final String title;
  final Icon icon;
  final int rate;
  final Function(int rate, bool clicked)? onTap;
  final bool selected;
  final Color? background;
  final bool glow;

  const RateButton(this.title, this.icon, this.rate, this.selected, {this.background, this.glow =true, this.onTap});

  static RateButton from<T extends SongCore>(T song, String title, Icon icon, int rate, Function(int rate, bool clicked)? onTap){
    return RateButton(title, icon, rate, song.rate == rate, onTap: onTap);
  }

  @override
  Widget build(BuildContext context) => SimpleButton(
    radius: AppCard.bigRadius,
    padding: EdgeInsets.only(top: Dimen.defMarg, bottom: Dimen.defMarg),
    color: selected?backgroundIcon_(context):null,
    margin: EdgeInsets.zero,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          child: icon,
          height: 2*Dimen.ICON_SIZE,
        ),
        Text(
            title,
            style: AppTextStyle(
                fontSize: Dimen.TEXT_SIZE_SMALL,
                color: selected?textEnab_(context):hintEnab_(context),
                fontWeight: selected?weight.bold:weight.normal),
            textAlign: TextAlign.center
        )
      ],
    ),
    onTap: () => onTap?.call(rate, selected),
  );

}

class RateIcon{

  final int rate;
  final bool enabled;
  final double size;
  const RateIcon(this.rate, {this.enabled = true, this.size = Dimen.ICON_SIZE});

  static Icon build(BuildContext context, int rate, {bool enabled = true, double size = Dimen.ICON_SIZE}){
    switch(rate){
      case SongRate.RATE_NULL: return Icon(SongRate.IC_DATA_NULL, color: iconEnab_(context));
      case SongRate.RATE_1: return SongRate.getIcon(1);
      case SongRate.RATE_2: return SongRate.getIcon(2);
      case SongRate.RATE_3: return SongRate.getIcon(3);
      case SongRate.RATE_4: return SongRate.getIcon(4);
      case SongRate.RATE_5: return SongRate.getIcon(5);
      default: return Icon(SongRate.IC_DATA_NULL, color: iconEnab_(context));
    }
  }

}
