import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/harcthought/articles/model/common.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'article_text_style.dart';

class ParagraphArticleElementWidget extends StatelessWidget{

  final ParagraphArticleElement paragraph;
  final String? fontFamily;

  const ParagraphArticleElementWidget(this.paragraph, {this.fontFamily, super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: RText(
        paragraph.text,
        fontFamily,
        textAlign: TextAlign.justify,
        size: FONT_SIZE_NORM,
        height: FONT_SIZE_HEIGHT,
      )
  );

}

class HeaderArticleElementWidget extends StatelessWidget{

  final HeaderArticleElement header;

  const HeaderArticleElementWidget(this.header, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Text(
        header.text,
        textAlign: TextAlign.start,
        style: const AppTextStyle(
          fontSize: 24.0,
          fontWeight: weight.bold,
        ),
      )
  );
}

class ListItemArticleElementWidget extends StatelessWidget{

  final ListItemArticleElement item;
  final String? fontFamily;

  const ListItemArticleElementWidget(this.item, {this.fontFamily, super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimen.iconMarg),
            child: SizedBox(
              // Added to compensate the textStyle height.
                height: Dimen.iconSize + FONT_SIZE_NORM*(FONT_SIZE_HEIGHT-1),
                width: Dimen.iconSize,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: item.index == null?
                    Icon(MdiIcons.circleMedium):
                    Center(
                      child: Text(
                        item.index.toString(),
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: FONT_SIZE_NORM,
                          fontWeight: FontWeight.w900,
                          height: FONT_SIZE_HEIGHT,
                        ),
                      ),
                    )
                )
            ),
          ),

          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: (Dimen.iconSize - FONT_SIZE_NORM)/2
                ),
                child: RText(
                  item.text,
                  fontFamily,
                  textAlign: TextAlign.justify,
                  size: FONT_SIZE_NORM,
                  height: FONT_SIZE_HEIGHT,
                )
            ),
          )

        ],
      )
  );
}

class QuoteArticleElementWidget extends StatelessWidget{

  final QuoteArticleElement quote;

  const QuoteArticleElementWidget(this.quote, {super.key});

  TextStyle get style => const HeaderTextStyle(
      fontSize: 20.0,
      fontStyle: FontStyle.italic
  );

  @override
  Widget build(BuildContext context){
    var wordWrapText = TextPainter(text: TextSpan(style: style, text: '„${quote.text}”'),
      textDirection: TextDirection.ltr,
    );
    wordWrapText.layout(maxWidth: MediaQuery.of(context).size.width - 2*32.0 - 3 - Dimen.iconMarg);

    return Row(
      children: [

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
                '„${quote.text}”',
                textAlign: TextAlign.end,
                style: style
            ),
          ),
        ),

        const SizedBox(width: Dimen.iconMarg)

      ],
    );
  }
}

class PictureArticleElementWidget extends StatelessWidget{

  static Widget getImage(String imgUrl) => CachedNetworkImage(
    imageUrl: imgUrl,
    placeholder: (context, _) => AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: SpinKitChasingDots(
          size: Dimen.iconSize,
          color: iconEnab_(context),
        ),
      ),
    ),
    errorWidget: (context, _, __) => AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(Dimen.iconMarg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(MdiIcons.close),
              const SizedBox(height: Dimen.iconMarg),
              Text(imgUrl),

            ],
          ),
        )
    ),
    fit: BoxFit.cover,
  );

  final PictureArticleElement picture;

  const PictureArticleElementWidget(this.picture, {super.key});

  @override
  Widget build(BuildContext context) => AppCard(
      elevation: AppCard.bigElevation,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          getImage(picture.link),

          if(picture.desc != null && picture.desc!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(Dimen.defMarg),
              child: Text(
                  picture.desc!,
                  style: const AppTextStyle(
                      fontSize: Dimen.textSizeTiny,
                      fontWeight: weight.halfBold
                  ),
                  textAlign: TextAlign.end
              ),
            ),
        ],
      )
  );
}

class YoutubeArticleElementWidget extends StatelessWidget{

  final YoutubeArticleElement item;

  const YoutubeArticleElementWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {

    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(item.link)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return AppCard(
      elevation: AppCard.bigElevation,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
      ),
    );
  }
}

class CustomArticleElementWidget extends StatelessWidget{

  static Widget getWidget(String html, String? fontFamily) => HtmlWidget(
    html,
    textStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: FONT_SIZE_NORM,
      height: FONT_SIZE_HEIGHT,
    ),
    customWidgetBuilder: (element){

      if(element.localName == 'figure' && element.children.length == 1)
        return getWidget(
            element.children[0].outerHtml, fontFamily
        );

      if(element.localName == 'img')
        return PictureArticleElementWidget.getImage(
            element.attributes['src']??''
        );

      return null;
    },
  );

  final CustomArticleElement item;
  final String? fontFamily;

  const CustomArticleElementWidget(this.item, {this.fontFamily, super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: cardEnab_(context),
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        elevation: AppCard.bigElevation,
        child: getWidget(item.html, fontFamily),
      )
  );
}