import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/harcthought/articles/model/article.dart';
import 'package:harcapp_core/logger.dart';

// This is a stateful widget for a reason. It's to prevent re-loading the image.
class ArticleCoverWidget extends StatelessWidget {

  final CoreArticle article;
  final Key? fallbackCoverKey;
  final bool bigResolution;
  final bool loadWebImage;

  const ArticleCoverWidget(this.article,
      { super.key,
        this.fallbackCoverKey,
        required this.bigResolution,
        this.loadWebImage = false, // Web images are huge. Don't load them by default.
      });

  @override
  Widget build(BuildContext context) =>
  !loadWebImage || article.imageUrl == null?
  _FallbackCoverWidget(article, key: fallbackCoverKey, big: bigResolution):
  CachedNetworkImage(
    imageUrl: article.imageUrl!,
    placeholder: (context, url) => _LoadingWidget(),
    errorWidget: (context, url, error){
      logger.w('Error loading article cover from ${article.uniqName}: $error. Loading fallback cover.');
      return _FallbackCoverWidget(article, big: bigResolution);
    },
  );

}

class _LoadingWidget extends StatelessWidget{

  const _LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      Center(
        child: SpinKitCubeGrid(
          size: 64.0,
          color: iconDisab_(context),
        ),
      );

}

class _FallbackCoverWidget extends StatefulWidget{

  final CoreArticle article;
  final bool big;

  const _FallbackCoverWidget(this.article, {super.key, required this.big});

  @override
  State<StatefulWidget> createState() => _FallbackCoverWidgetState();

}

class _FallbackCoverWidgetState extends State<_FallbackCoverWidget>{

  CoreArticle get article => widget.article;
  bool get big => widget.big;

  Uint8List? cover;

  @override
  void initState() {
    cover = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      cover != null?
      Image(image: MemoryImage(cover!), fit: BoxFit.cover):
      FutureBuilder<Uint8List?>(
        future: article.loadCover(big), // async work
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return _LoadingWidget();
            default:
              if (snapshot.hasError)
                return const CoverProblemWidget();
              if(snapshot.data == null)
                return const CoverProblemWidget();

              cover = snapshot.data;
              return Image(image: MemoryImage(snapshot.data!), fit: BoxFit.cover);
          }
        }
        );

}

class CoverProblemWidget extends StatelessWidget{

  const CoverProblemWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(
          child: Text(
              'Problem z pobieraniem\nokładki artykułu...',
              style: AppTextStyle(),
              textAlign: TextAlign.center
          )
      );

}