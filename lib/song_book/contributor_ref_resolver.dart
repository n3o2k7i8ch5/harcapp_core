import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'package:harcapp_core/values/people/contributor_ref.dart';

abstract class ContributorRefResolver{

  const ContributorRefResolver();

  Widget build(BuildContext context, ContributorRef data);

}

class ContributorRefSimpleResolver extends ContributorRefResolver{

  static String? name(ContributorRef data){
    return data.person?.name;
  }

  final double? textSize;
  final Color? textColor;

  const ContributorRefSimpleResolver({this.textSize, this.textColor});

  @override
  Widget build(BuildContext context, ContributorRef data) => Text(
      data.person?.name??'',
      style: AppTextStyle(color: textColor??hintEnab_(context), fontSize: textSize??Dimen.textSizeNormal, fontWeight: weightHalfBold)
  );

}