import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/meto.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/comm_widgets/app_bar.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/gradient_icon.dart';
import 'package:harcapp_core/comm_widgets/meto.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'harc_form.dart';

class BaseHarcFormWidget extends StatefulWidget{

  final HarcForm form;
  final bool withAppBar;

  const BaseHarcFormWidget(this.form, {this.withAppBar = true, super.key});

  @override
  State<StatefulWidget> createState() => BaseHarcFormWidgetState();

}

class BaseHarcFormWidgetState extends State<BaseHarcFormWidget>{

  HarcForm get form => widget.form;

  String? text;

  void run() async {
    text = await readStringFromAssets('packages/harcapp_core/assets/forms/${form.filename}');
    setState((){});
  }

  @override
  void initState() {
    run();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
    physics: const BouncingScrollPhysics(),
    slivers: [

      if(widget.withAppBar)
        SliverAppBarX(
          title: form.title,
          floating: false,
          stretch: true,
          actions: [

            Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimen.iconMarg),
                  child: GradientIcon(
                    form.icon,
                    colorStart: form.colorStart,
                    colorEnd: form.colorEnd,
                    size: 32,
                  ),
                )
            )

          ],
        ),

      SliverPadding(
        padding: const EdgeInsets.all(Dimen.sideMarg),
        sliver: SliverList(delegate: SliverChildListDelegate([

          _TagWrapWidget(form),

          const SizedBox(height: 2*Dimen.sideMarg),

          if(text != null)
            Text(
              text!,
              style: const AppTextStyle(
                fontSize: Dimen.textSizeBig,
              ),
              textAlign: TextAlign.justify,
            ),

          const SizedBox(height: 2*Dimen.sideMarg),

          MetoGridWidget(form),

          const SizedBox(height: Dimen.sideMarg),

        ])),
      )
    ],
  );

}

class _TagWidget extends StatelessWidget{

  final HarcFormTag tag;

  const _TagWidget(this.tag);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [

      Icon(tag.icon),
      const SizedBox(width: Dimen.iconMarg),

      Text(
        tag.text,
        style: const AppTextStyle(fontWeight: weightHalfBold, fontSize: Dimen.textSizeNormal),
        textAlign: TextAlign.center,
      ),
    ],
  );

}

class _TagWrapWidget extends StatelessWidget{
  
  final HarcForm form;
  
  const _TagWrapWidget(this.form);
  
  @override
  Widget build(BuildContext context){

    List<Widget> children = [];
    
    for(int i=0; i<form.tags.length; i++){
      children.add(_TagWidget(form.tags[i]));

      if(i<form.tags.length-1)
        children.add(const SizedBox(width: Dimen.iconMarg));
    }
    
    return Wrap(spacing: Dimen.defMarg, runSpacing: Dimen.defMarg, children: children);
    
  }
  
}

class _MetoTile extends StatelessWidget{

  final Meto meto;
  final bool enabled;

  const _MetoTile(this.meto, this.enabled);

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: enabled?1:0.5,
    child: Material(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        elevation: enabled?AppCard.bigElevation:0,
        borderRadius: BorderRadius.circular(AppCard.defRadius),
        child: MetoTile(
          meto: meto,
          iconSize: 42.0,
          trailing: Padding(
            padding: const EdgeInsets.all(Dimen.defMarg),
            child: Container(
                decoration: BoxDecoration(
                  color: background_(context),
                  borderRadius: BorderRadius.circular(AppCard.defRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimen.defMarg),
                  child: enabled?
                  Icon(MdiIcons.check):
                  Icon(MdiIcons.close),
                )
            ),
          ),
        )
    ),
  );

}

class MetoGridWidget extends StatelessWidget{

  final HarcForm form;
  const MetoGridWidget(this.form, {super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [

      Row(
        children: [

          Expanded(child: _MetoTile(Meto.zuch, form.metos.contains(Meto.zuch))),
          const SizedBox(width: Dimen.iconMarg),
          Expanded(child: _MetoTile(Meto.harc, form.metos.contains(Meto.harc))),

        ],
      ),

      const SizedBox(height: Dimen.iconMarg),

      Row(
        children: [

          Expanded(child: _MetoTile(Meto.hs, form.metos.contains(Meto.hs))),
          const SizedBox(width: Dimen.iconMarg),
          Expanded(child: _MetoTile(Meto.wedro, form.metos.contains(Meto.wedro))),

        ],
      ),

    ],
  );

}