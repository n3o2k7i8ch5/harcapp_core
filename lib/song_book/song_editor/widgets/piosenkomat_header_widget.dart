import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/dialog/alert_dialog.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:provider/provider.dart';

import '../providers.dart';
import 'piosenkomat_conversation_view.dart';
import 'piosenkomat_pills.dart';

/// Karta piosenkomatu nad przeglądaną piosenką — jedno pudełko na wszystko,
/// co przyniosło zgłoszenie: werdykt, badge POPRAWKA, pastylki z uwagami,
/// rozmowę z osobą dodającą i pole na odpowiedź.
///
/// Pastylki i rozmowa są tylko do czytania: to dla Ciebie, narzędzie ich po
/// przeglądzie nie sprawdza. Czyta natomiast werdykt i odpowiedź. Piosenki
/// nie trzeba już kasować z pliku — wystarczy zgasić przełącznik; kasowanie
/// dalej działa i dalej znaczy „odrzucona”.
///
/// Świadomie osobne od [SongTagsWidget] i od błędów edytora: to nie są tagi
/// piosenki (te widzi użytkownik apki) ani walidacja treści (tę edytor liczy
/// sam) — tylko ślad narzędzia, które zgłoszenie przyniosło.
class PiosenkomatHeaderWidget extends StatefulWidget{

  final EdgeInsets padding;
  /// Tytuł poprawianej piosenki po `correctionTarget` — strona zna piosenki
  /// z apki, rdzeń nie.
  final String? Function(String songId)? titleOfAppSong;

  const PiosenkomatHeaderWidget({
    this.padding = EdgeInsets.zero,
    this.titleOfAppSong,
    super.key,
  });

  @override
  State<PiosenkomatHeaderWidget> createState() => _PiosenkomatHeaderWidgetState();

}

class _PiosenkomatHeaderWidgetState extends State<PiosenkomatHeaderWidget>{

  TextEditingController? _controller;
  /// Do której piosenki należy kontroler. Po **obiekcie** piosenki, nie po id
  /// wątku: wątek bywa `null` (plik ręcznie edytowany, sprzed id), a dwie
  /// takie piosenki pod rząd dzieliłyby jedno pole i jeden tekst.
  SongRaw? _boundSong;

  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  /// Przeskok na inną piosenkę dostaje **nowy** kontroler, a nie podmieniony
  /// tekst w starym. Dwa powody: podmiana w środku `build` woła listenerów
  /// kontrolera, czyli „setState w trakcie budowania”, a pole z rdzenia liczy
  /// widoczność pływającej etykiety raz, w `initState` — ze starym kontrolerem
  /// etykieta zostałaby nad pustym polem. Klucz na piosence wymusza świeży stan.
  void _rebind(SongRaw song, PiosenkomatData data){
    if(_controller != null && identical(song, _boundSong)) return;
    _boundSong = song;
    final previous = _controller;
    _controller = TextEditingController(text: data.reviewNote ?? '');
    // Po klatce, bo stare pole trzyma go jeszcze przez to budowanie.
    if(previous != null){
      WidgetsBinding.instance.addPostFrameCallback((_) => previous.dispose());
    }
  }

  /// [notify] `false` tylko dla tekstu odpowiedzi: czyta go sama ta karta,
  /// a `notify` przy każdym znaku przebudowywało cały edytor (na stronie —
  /// z przeliczeniem podobieństw całego warsztatu).
  void _update(PiosenkomatData Function(PiosenkomatData) change, {bool notify = true}){
    final prov = CurrentItemProvider.of(context);
    final data = prov.song.piosenkomatData;
    if(data == null) return;
    prov.song.piosenkomatData = change(data);
    if(notify) prov.notify();
  }

  /// Gdy w polu już coś jest, pyta — inaczej chybione kliknięcie gwiazdki
  /// kasuje napisaną odpowiedź bez cofnięcia.
  Future<void> _proposeReply(String note) async {
    if(_controller!.text.trim().isNotEmpty){
      bool overwrite = false;
      await showAlertDialog(
        context: context,
        title: 'Podmienić odpowiedź?',
        content: 'W polu odpowiedzi jest już tekst. '
            'Propozycja go <b>zastąpi</b> — tego nie da się cofnąć.',
        buttons: [
          AppDialogButton(
            text: 'Zostaw mój tekst',
            onTap: () => popPage(context),
          ),
          AppDialogButton(
            text: 'Podmień',
            onTap: (){
              overwrite = true;
              popPage(context);
            },
            textColor: hintEnab_(context),
          ),
        ],
      );
      if(!overwrite) return;
      if(!mounted) return;
    }

    // Przez `value`: samo `text` zostawia zaznaczenie w pozycji -1.
    _controller!.value = TextEditingValue(
      text: note,
      selection: TextSelection.collapsed(offset: note.length),
    );
    _update((d) => d.copyWith(reviewNote: () => note));
  }

  @override
  Widget build(BuildContext context) => Consumer<CurrentItemProvider>(
    builder: (context, prov, child){

      final PiosenkomatData? data = prov.song.piosenkomatData;
      // Karta jest też miejscem na werdykt, więc pokazuje się przy każdej
      // piosence z przeglądu — także przy takiej bez zarzutu.
      if(data == null) return const SizedBox.shrink();
      _rebind(prov.song, data);

      return Padding(
        padding: widget.padding,
        child: AppCard(
          radius: AppCard.bigRadius,
          padding: const EdgeInsets.all(Dimen.defMarg*2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [

              // Werdykt: nagłówek karty. Drugie klikalne miejsce to gwiazdka
              // przy polu odpowiedzi, gdy pastylki dają się skleić w uwagę.
              // Do pliku zwrotnego trafia tylko odrzucenie — domyślnie
              // piosenka wchodzi.
              _VerdictRow(
                goesIn: !data.rejected,
                onChanged: (value) => _update((d) => d.copyWith(rejected: !value)),
              ),

              // Adres nadawcy — jedyne miejsce, gdy nie doklejono go do karty
              // osoby dodającej.
              if(data.sender case final sender?) ...[
                const SizedBox(height: Dimen.defMarg),
                _SenderRow(sender: sender, senderIsContributor: data.senderIsContributor),
              ],

              PiosenkomatPills(
                data,
                titleOfAppSong: widget.titleOfAppSong,
                padding: const EdgeInsets.only(top: Dimen.defMarg),
              ),

              PiosenkomatConversationView(
                data: data,
                fieldKey: ObjectKey(_boundSong),
                controller: _controller!,
                onChanged: (text) => _update(
                    (d) => d.copyWith(reviewNote: () => text.trim().isEmpty? null: text),
                    notify: false),
                onPropose: _proposeReply,
              ),

            ],
          ),
        ),
      );

    },
  );

}

/// Nagłówek karty: werdykt i przełącznik.
class _VerdictRow extends StatelessWidget{

  final bool goesIn;
  final ValueChanged<bool> onChanged;

  const _VerdictRow({required this.goesIn, required this.onChanged});

  @override
  Widget build(BuildContext context){
    final color = goesIn? Colors.green: Colors.red;
    return Row(
      children: [
        Icon(
          goesIn? MdiIcons.checkCircleOutline: MdiIcons.closeCircleOutline,
          size: Dimen.textSizeBig + 2,
          color: color,
        ),
        const SizedBox(width: Dimen.defMarg),
        Expanded(
          child: Text(
            goesIn? 'Do zatwierdzenia': 'Do odrzucenia',
            style: AppTextStyle(
              fontSize: Dimen.textSizeBig,
              fontWeight: weightHalfBold,
              color: color,
            ),
          ),
        ),
        Switch(value: goesIn, onChanged: onChanged),
      ],
    );
  }

}

class _SenderRow extends StatelessWidget{

  final String sender;
  final bool senderIsContributor;

  const _SenderRow({required this.sender, required this.senderIsContributor});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(MdiIcons.emailOutline, size: Dimen.textSizeNormal, color: hintEnab_(context)),
      const SizedBox(width: Dimen.defMarg),
      Expanded(
        child: Text(
          senderIsContributor? sender: '$sender (wysyła w czyimś imieniu)',
          style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: hintEnab_(context)),
        ),
      ),
    ],
  );

}
