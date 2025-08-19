import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/song_book/song_contribution_rules.dart';
import 'package:harcapp_core/values/dimen.dart';

class SongContributionWidget extends StatelessWidget{

  const SongContributionWidget({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.all(Dimen.sideMarg),
    child: AppText(
      songContributionRules.values.first,
      size: Dimen.textSizeBig,
      height: 1.2,
    ),
  );


}