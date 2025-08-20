import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'add_person.dart';

abstract class AddPersonResolver{

  const AddPersonResolver();

  Widget build(BuildContext context, ContributorIdentity data);

}

class AddPersonSimpleResolver extends AddPersonResolver{

  static String? name(ContributorIdentity data){
    return data.name;
  }

  final double? textSize;
  final Color? textColor;

  const AddPersonSimpleResolver({this.textSize, this.textColor});

  @override
  Widget build(BuildContext context, ContributorIdentity data) => Text(
      data.name??'',
      style: AppTextStyle(color: textColor??hintEnab_(context), fontSize: textSize??Dimen.textSizeNormal, fontWeight: weightHalfBold)
  );

}