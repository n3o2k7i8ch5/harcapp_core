import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:oktoast/oktoast.dart';

import 'app_card.dart';
import 'app_text.dart';

ToastFuture showAppToast(
    BuildContext context,
    {String? header,
    required String text,
    Color? background,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    String? buttonText,
    void Function()? onButtonPressed,
}) => showToastWidget(
    Padding(
      padding: const EdgeInsets.only(
        right: 12.0,
        left: 12.0,
        bottom: 46.0,
      ),
      child: IntrinsicWidth(
        child: Material(
            borderRadius: BorderRadius.circular(12.0),
            elevation: 20.0,
            color: background??cardEnab_(context),
            child: Padding(
                padding: buttonText != null && onButtonPressed != null?
                const EdgeInsets.only(
                  left: 12.0,
                  top: 12.0 - Dimen.defMarg,
                  bottom: 12.0 - Dimen.defMarg,
                  right: 12.0 - Dimen.defMarg,
                ):
                const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(header != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                header,
                                style: AppTextStyle(color: textColor??textEnab_(context), fontSize: Dimen.TEXT_SIZE_BIG, fontWeight: weight.halfBold),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          AppText(
                            text,
                            color: textEnab_(context),
                            size: Dimen.TEXT_SIZE_BIG,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    if(buttonText != null && onButtonPressed != null)
                      SimpleButton.from(
                          textColor: textColor??iconEnab_(context),
                          radius: AppCard.defRadius,
                          margin: EdgeInsets.only(left: Dimen.defMarg),
                          padding: EdgeInsets.all(Dimen.defMarg),
                          text: buttonText,
                          onTap: (){
                            showToastWidget(
                              Container(),
                              context: context,
                              duration: Duration.zero,
                              dismissOtherToast: true
                            );
                            onButtonPressed.call();
                          }
                      )

                  ],
                )
            )
        ),
      )
    ),
    handleTouch: true,
    position: ToastPosition.bottom,
    duration: duration,
    dismissOtherToast: true,
);