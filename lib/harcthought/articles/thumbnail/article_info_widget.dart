import 'package:flutter/material.dart';
import 'package:harcapp_core/account/account_thumbnail_widget.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/date_to_str.dart';
import 'package:harcapp_core/dimen.dart';

import '../model/article.dart';

class ArticleInfoTitleWidget extends StatelessWidget{

  final CoreArticle article;
  final bool titleCenter;
  final double fontSize;

  const ArticleInfoTitleWidget(this.article, {this.titleCenter = false, this.fontSize = Dimen.textSizeBig, super.key});

  @override
  Widget build(BuildContext context) => Text(
    article.title,
    style: TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: iconEnab_(context)
    ),
    maxLines: 3,
    textAlign: titleCenter?TextAlign.center:TextAlign.start,
  );

}

class ArticleInfoAuthorDateWidget extends StatelessWidget{

  static const double accountThumbnailSize = 2*Dimen.textSizeNormal + 3.0;

  final CoreArticle article;
  final double fontSize;
  final bool showStats;
  final Color? authorThumbnailColor;

  const ArticleInfoAuthorDateWidget(this.article, {super.key, this.fontSize = Dimen.textSizeNormal, this.showStats = true, this.authorThumbnailColor});

  @override
  Widget build(BuildContext context) => Row(
    children: [

      AccountThumbnailWidget(
        name: article.author,
        verified: false,
        elevated: false,
        color: authorThumbnailColor??cardEnab_(context),
        borderColor: authorThumbnailColor??cardEnab_(context),
        size: accountThumbnailSize,
      ),

      const SizedBox(width: Dimen.iconMarg),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              article.author,
              style: AppTextStyle(
                  fontWeight: weight.halfBold,
                  fontSize: fontSize,
                  color: iconEnab_(context)
              )
          ),

          const SizedBox(height: 3.0),

          Text(
              dateToString(article.date, shortMonth: true, yearAbbr: 'A.D.'),
              style: AppTextStyle(
                  fontSize: fontSize,
                  color: iconEnab_(context)
              )
          ),
        ],
      ),

      Expanded(child: Container()),

      // if(showStats && (AccountData.loggedIn || (!AccountData.loggedIn && article.isSeen)))
      //   Icon(
      //     article.isSeen?
      //     MdiIcons.eye:
      //     MdiIcons.eyeOutline,
      //
      //     color:
      //     article.isSeen?
      //     iconEnab_(context):
      //     iconDisab_(context),
      //   ),
      // if(showStats && AccountData.loggedIn)
      //   const SizedBox(width: 6),
      // if(showStats && AccountData.loggedIn)
      //   Text(
      //       article.seenCountStr,
      //       style: AppTextStyle(
      //         color:
      //         article.isSeen?
      //         iconEnab_(context):
      //         iconDisab_(context),
      //       )
      //   ),

      // if(showStats)
      //   const SizedBox(width: Dimen.iconMarg),
      //
      // if(showStats && (AccountData.loggedIn || (!AccountData.loggedIn && article.isLiked)))
      //   Icon(
      //     article.isLiked?
      //     MdiIcons.heart:
      //     MdiIcons.heartOutline,
      //
      //     color:
      //     article.isLiked?
      //     iconEnab_(context):
      //     iconDisab_(context),
      //   ),
      // if(showStats && AccountData.loggedIn)
      //   const SizedBox(width: 6),
      // if(showStats && AccountData.loggedIn)
      //   Text(
      //       article.likeCountStr,
      //       style: AppTextStyle(
      //         color:
      //         article.isLiked?
      //         iconEnab_(context):
      //         iconDisab_(context),
      //       )
      //   ),

    ],
  );

}

class ArticleInfoWidget extends StatelessWidget{

  final CoreArticle article;
  final bool titleCenter;
  final bool showStats;

  const ArticleInfoWidget(this.article, {super.key, this.titleCenter = true, this.showStats = true});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArticleInfoTitleWidget(article),

        const SizedBox(height: 1*Dimen.iconMarg),

        ArticleInfoAuthorDateWidget(article, showStats: showStats)

      ],
    ),
  );

}