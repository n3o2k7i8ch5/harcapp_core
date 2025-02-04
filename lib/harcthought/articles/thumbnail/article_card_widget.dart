import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/blur.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/articles/model/article.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';

import 'article_cover_widget.dart';
import 'article_info_widget.dart';

class ArticleCardWidget extends StatelessWidget{

  static const double height = 242;

  final CoreArticle article;
  final Key? coverKey;
  final void Function(
      BuildContext context,
      CoreArticle article
  )? onTap;
  final double radius;
  final EdgeInsets margin;
  final bool disableHeroTag;
  final double elevation;
  final Widget? infoBottomTrailing;

  double get padding => 2*Dimen.iconMarg;

  const ArticleCardWidget(
      this.article,
      { super.key,
        this.coverKey,
        this.onTap,
        this.radius=0,
        this.margin=EdgeInsets.zero,
        this.disableHeroTag=false,
        this.elevation=0,
        this.infoBottomTrailing,
      });

  @override
  Widget build(BuildContext context) => SizedBox(
      height: ArticleCardWidget.height,
      child: SimpleButton(
          onTap: onTap==null?null:() => onTap!(context, article),
          radius: AppCard.bigRadius,
          elevation: elevation,
          margin: margin,
          child: Stack(
            fit: StackFit.expand,
            children: [

              ArticleCoverWidget(
                  key: coverKey,
                  article,
                  bigResolution: true,
              ),

              Positioned(
                  top: Dimen.defMarg,
                  left: Dimen.defMarg,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppCard.bigRadius)
                    ),
                    child: Blur(
                      child: Container(
                        color: cardEnab_(context).withOpacity(.85),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimen.defMarg, horizontal: Dimen.iconMarg),
                          child: Row(
                            children: [
                              ArticleSource.icon,
                              SizedBox(width: Dimen.defMarg),
                              Text(
                                  article.source.displayName,
                                  style: AppTextStyle(fontWeight: weight.halfBold, color: iconEnab_(context))
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Positioned(
                bottom: -.1,
                left: -.1,
                right: -.1,
                child: Blur(
                  child: Container(
                    color: cardEnab_(context).withOpacity(.85),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimen.iconMarg).subtract(
                          const EdgeInsets.only(top: (1.2 - 1)*Dimen.textSizeBig)
                      ),
                      child: ArticleInfoWidget(article, infoBottomTrailing: infoBottomTrailing),
                    ),
                  ),
                ),
              )

            ],
          )
      )
  );

}
