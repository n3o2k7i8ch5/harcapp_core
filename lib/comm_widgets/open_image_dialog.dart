import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors.dart';
import '../comm_classes/app_text_style.dart';
import '../comm_classes/common.dart';
import 'app_card.dart';

Future<void> openImageDialog(
  BuildContext context,
  String title,
  String assetPath,
  {
    required bool web,
    double? maxWidth,
  }) async => showDialog(
    context: context,
    builder: (context) => ImageDialog(title, assetPath, web, maxWidth: maxWidth)
);

class ImageDialog extends StatelessWidget{

  final String title;
  final String path;
  final bool web;
  final double? maxWidth;

  const ImageDialog(this.title, this.path, this.web, {this.maxWidth});

  @override
  Widget build(BuildContext context){

    Widget child = Padding(
      padding: EdgeInsets.all(Dimen.sideMarg),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppCard.bigRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarX(
              titleWidget: Text(
                title,
                style: AppTextStyle(color: iconEnab_(context)),
              ),
              iconTheme: IconThemeData(color: iconEnab_(context)),
            ),
            if(web)
              Image.network(
                path,
                loadingBuilder: (_, __, ___) => Padding(
                  padding: EdgeInsets.all(Dimen.sideMarg),
                  child: SpinKitChasingDots(
                    size: 64.0,
                    color: iconEnab_(context),
                  ),
                ),
                errorBuilder: (_, __, stackTrace){
                  Logger().w(stackTrace.toString());
                  return Center(
                    child: SizedBox(
                      height: 64.0 + 2*Dimen.sideMarg,
                      child: Center(
                        child: Column(
                          children: [

                            SelectableText(
                              'Błąd ładowania obrazka'
                                  '\n\n$path',
                              style: AppTextStyle(),
                              textAlign: TextAlign.center,
                            ),

                            SimpleButton.from(
                              context: context,
                              text: 'Otwórz w przeglądarce',
                              icon: Icons.open_in_browser,
                              onTap: () => launchURL(path)
                            )

                          ],
                        )
                      ),
                    ),
                  );
                }
              )
            else
              Image.asset(path)
          ],
        ),
      ),
    );

    if(maxWidth == null)
      return Center(child: child);
    else
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: child,
        ),
      );

  }

}