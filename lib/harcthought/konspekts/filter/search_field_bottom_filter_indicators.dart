
import 'package:flutter/cupertino.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_widgets/meto_row.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/harcthought/konspekts/konspekt.dart';

import 'konspekts_filters.dart';

abstract class SearchFieldBottomFilterIndicatosWidget<T extends KonspektsFilters> extends StatelessWidget{

  final T filters;

  const SearchFieldBottomFilterIndicatosWidget(this.filters, {Key? key}) : super(key: key);

}

class SearchFieldBottomKsztalcenioweFiltersWidget extends SearchFieldBottomFilterIndicatosWidget<KonspektsKsztalcenioweFilters>{

  const SearchFieldBottomKsztalcenioweFiltersWidget(super.filters, {super.key});

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

class SearchFieldBottomHarcerskieFiltersWidget extends SearchFieldBottomFilterIndicatosWidget<KonspektsHarcerskieFilters>{

  const SearchFieldBottomHarcerskieFiltersWidget(super.filters, {super.key});

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