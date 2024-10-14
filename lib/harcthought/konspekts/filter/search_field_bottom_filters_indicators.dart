
import 'package:flutter/cupertino.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

import 'konspekt_filters.dart';

abstract class SearchFieldBottomFilterIndicatorsWidget<T extends KonspektFilters> extends StatelessWidget{

  final T filters;

  const SearchFieldBottomFilterIndicatorsWidget(this.filters, {Key? key}) : super(key: key);

}

class SearchFieldBottomHarcerskieFilterIndicatorsWidget extends SearchFieldBottomFilterIndicatorsWidget<KonspektHarcerskieFilters>{

  const SearchFieldBottomHarcerskieFilterIndicatorsWidget(super.filters, {super.key});

  @override
  Widget build(BuildContext context) {

    List<Meto> sortedSelectedMetos = filters.selectedMetos.toList();
    sortedSelectedMetos.sort((t1, t2) => t1.index - t2.index);

    List<KonspektSphere> sortedSelectedSpheres = filters.selectedSpheres.toList();
    sortedSelectedSpheres.sort((t1, t2) => t1.index - t2.index);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6, left: Dimen.iconMarg, right: Dimen.iconMarg),
        child: SizedBox(
          height: 2*Dimen.defMarg + Dimen.textSizeNormal + 3,
          child: Row(
            children: [

              MetoRow(sortedSelectedMetos),

              ...sortedSelectedSpheres.map<Widget>((sphere) => Padding(
                padding: const EdgeInsets.only(left: MetoRow.separatorWidth),
                child: Icon(sphere.displayIcon, size: 18.0),
              )),

            ],
          ),
        )
    );

  }

}

class SearchFieldBottomKsztalcenieFilterIndicatorsWidget extends SearchFieldBottomFilterIndicatorsWidget<KonspektKsztalcenieFilters>{

  const SearchFieldBottomKsztalcenieFilterIndicatorsWidget(super.filters, {super.key});

  @override
  Widget build(BuildContext context) {

    List<Meto> sortedSelectedLevels = filters.selectedLevels.toList();
    sortedSelectedLevels.sort((t1, t2) => t1.index - t2.index);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 6, left: Dimen.iconMarg, right: Dimen.iconMarg),
        child: SizedBox(
          height: 2*Dimen.defMarg + Dimen.textSizeNormal + 3,
          child: Row(
            children: [

              MetoRow(sortedSelectedLevels),

            ],
          ),
        )
    );

  }

}
