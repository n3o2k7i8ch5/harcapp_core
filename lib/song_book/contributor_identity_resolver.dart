import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'package:harcapp_core/values/people/contributor_identity.dart';

abstract class ContributorIdentityResolver{

  const ContributorIdentityResolver();

  Widget build(BuildContext context, ContributorIdentity data);

}

class ContributorIdentitySimpleResolver extends ContributorIdentityResolver{

  static String? name(ContributorIdentity data){
    return data.person?.name;
  }

  final double? textSize;
  final Color? textColor;

  const ContributorIdentitySimpleResolver({this.textSize, this.textColor});

  @override
  Widget build(BuildContext context, ContributorIdentity data) => Text(
      data.person?.name??'',
      style: AppTextStyle(color: textColor??hintEnab_(context), fontSize: textSize??Dimen.textSizeNormal, fontWeight: weightHalfBold)
  );

}