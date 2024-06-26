import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/network.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/values/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SoundPlayerWidget extends StatefulWidget{

  static const double height = Dimen.iconFootprint;

  final String source;
  final String? name;
  final bool isWebAsset;
  final bool autoStart;

  const SoundPlayerWidget({
    required this.source,
    required this.name,
    required this.isWebAsset,
    this.autoStart = false,

    super.key
  });

  @override
  State<StatefulWidget> createState() => SoundPlayerWidgetState();

}

class SoundPlayerWidgetState extends State<SoundPlayerWidget>{

  String get source => widget.source;
  String? get name => widget.name;
  bool get isWeb => widget.isWebAsset;
  bool get autoStart => widget.autoStart;

  late AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {

    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
        isWeb?
        Audio.network(source):
        Audio(source),
        autoStart: autoStart
    );
    assetsAudioPlayer.playlistAudioFinished.listen((Playing playing) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            children: [

              if(assetsAudioPlayer.current.valueOrNull != null)
                PlayerBuilder.currentPosition(
                    player: assetsAudioPlayer,
                    builder: (context, duration) => Container(
                      color: backgroundIcon_(context),
                      height: Dimen.iconFootprint,
                      width: (duration.inMilliseconds/assetsAudioPlayer.current.value!.audio.duration.inMilliseconds)*constraints.maxWidth,
                    )
                ),

              Row(
                children: [

                  AppButton(
                    icon: Icon(
                        assetsAudioPlayer.isPlaying.value?
                        MdiIcons.pause:
                        MdiIcons.play
                    ),
                    onTap: () async {
                      if(isWeb && !await isNetworkAvailable() && !assetsAudioPlayer.isPlaying.value) {
                        showAppToast(context, text: noInternetMessage);
                        return;
                      }

                      await assetsAudioPlayer.playOrPause();
                      if(mounted) setState((){});
                    },
                  ),

                  Expanded(
                    child: AppText(name??'<i>Anonimowe nagranie</i>'),
                  ),

                  AppButton(
                    icon: Icon(MdiIcons.rewind),
                    onLongPress: assetsAudioPlayer.isPlaying.value?
                    (){
                      assetsAudioPlayer.seek(Duration.zero);
                      if(mounted) showAppToast(context, text: 'Od początku!', duration: const Duration(seconds: 1));
                      if(mounted) setState((){});
                    }: null,
                    onTap: assetsAudioPlayer.isPlaying.value?
                    () async {
                      await assetsAudioPlayer.seekBy(const Duration(seconds: -2));
                      if(mounted) showAppToast(context, text: '-2 sekundy', duration: const Duration(seconds: 1));
                      if(mounted) setState((){});
                    }: null,
                  ),

                  AppButton(
                    icon: Icon(MdiIcons.fastForward),
                    onTap:
                    assetsAudioPlayer.isPlaying.value?
                    () async {
                      await assetsAudioPlayer.seekBy(const Duration(seconds: 2));
                      if(mounted) showAppToast(context, text: '+2 sekundy', duration: const Duration(seconds: 1));
                      if(mounted) setState((){});
                    }: null,
                  ),


                ],
              ),
            ],
          )
      );

}