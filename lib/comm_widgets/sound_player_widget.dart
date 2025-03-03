import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/network.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';
import 'package:harcapp_core/dimen.dart';
import 'package:harcapp_core/values/strings.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SoundPlayerWidget extends StatefulWidget{

  static const double height = Dimen.iconFootprint;

  final String source;
  final String? name;
  final bool isWebAsset;

  const SoundPlayerWidget({
    required this.source,
    required this.name,
    required this.isWebAsset,
    super.key
  });

  @override
  State<StatefulWidget> createState() => SoundPlayerWidgetState();

}

class SoundPlayerWidgetState extends State<SoundPlayerWidget>{

  String get source => widget.source;
  String? get name => widget.name;
  bool get isWeb => widget.isWebAsset;

  late AudioPlayer audioPlayer;
  late Duration totalDuration;

  void _initAudioTrack() async {
    if(isWeb)
      totalDuration = (await audioPlayer.setUrl(source))??Duration.zero;
    else
      totalDuration = (await audioPlayer.setAsset(source))??Duration.zero;

    setState(() {});
  }
  
  @override
  void initState() {

    audioPlayer = AudioPlayer();
    _initAudioTrack();

    audioPlayer.playerStateStream.listen((state) {
      if (state == ProcessingState.completed && mounted) setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Stack(
            children: [

              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final PositionData? positionData = snapshot.data;
                  if(positionData == null)
                    return Container();
                  
                  return Container(
                    color: backgroundIcon_(context),
                    height: Dimen.iconFootprint,
                    width: (positionData.position.inMicroseconds/totalDuration.inMilliseconds)*constraints.maxWidth,
                  );
                },
              ),

              Row(
                children: [

                  AppButton(
                    icon: Icon(
                        audioPlayer.playing?
                        MdiIcons.pause:
                        MdiIcons.play
                    ),
                    onTap: () async {
                      if(isWeb && !await isNetworkAvailable() && !audioPlayer.playing) {
                        showAppToast(context, text: noInternetMessage);
                        return;
                      }

                      await audioPlayer.playing?audioPlayer.pause():audioPlayer.play();
                      if(mounted) setState((){});
                    },
                  ),

                  Expanded(
                    child: AppText(name??'<i>Anonimowe nagranie</i>'),
                  ),

                  AppButton(
                    icon: Icon(MdiIcons.rewind),
                    onLongPress: audioPlayer.playing?
                    (){
                      audioPlayer.seek(Duration.zero);
                      if(mounted) showAppToast(context, text: 'Od początku!', duration: const Duration(seconds: 1));
                      if(mounted) setState((){});
                    }: null,
                    onTap: audioPlayer.playing?
                    () async {
                      await audioPlayer.seek(audioPlayer.position - const Duration(seconds: 2));
                      if(mounted) showAppToast(context, text: '-2 sekundy', duration: const Duration(seconds: 1));
                      if(mounted) setState((){});
                    }: null,
                  ),

                  AppButton(
                    icon: Icon(MdiIcons.fastForward),
                    onTap:
                    audioPlayer.playing?
                    () async {
                      await audioPlayer.seek(audioPlayer.position + const Duration(seconds: 2));
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