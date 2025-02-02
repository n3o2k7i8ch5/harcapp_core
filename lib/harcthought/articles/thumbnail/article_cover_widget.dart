import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/harcthought/articles/model/article.dart';

class ArticleCoverWidget extends StatelessWidget{

  final CoreArticle article;
  final ImageProvider? cover;
  final void Function(Uint8List cover)? onCoverLoaded;

  const ArticleCoverWidget(this.article, {super.key, this.cover, this.onCoverLoaded});

  @override
  Widget build(BuildContext context) => cover != null?
  Image(image: cover!, fit: BoxFit.cover):
  FutureBuilder<Uint8List?>(
      future: article.loadCover(), // async work
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: SpinKitCubeGrid(
                size: 64.0,
                color: iconDisab_(context),
              ),
            );
          default:
            if (snapshot.hasError)
              return const CoverProblemWidget();
            if(snapshot.data == null)
              return const CoverProblemWidget();
            onCoverLoaded?.call(snapshot.data!);
            return Image(image: MemoryImage(snapshot.data!), fit: BoxFit.cover);
        }

      });


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