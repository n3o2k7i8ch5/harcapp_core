import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_navigator.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/dialog/alert_dialog.dart';
import 'package:harcapp_core/comm_widgets/dialog/app_dialog.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/song_book/contrib_reply.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:provider/provider.dart';

import '../providers.dart';

/// Kolor uwagi po wadze: blokada na czerwono, decyzja na pomarańczowo.
/// Ten sam kolor niesie ikonę, tekst i półprzezroczyste tło pastylki.
Color piosenkomatIssueColor(SongIssue issue) => switch(issue.severity){
  SongIssueSeverity.blocking => Colors.red,
  SongIssueSeverity.decision => Colors.orange,
};

IconData piosenkomatIssueIcon(SongIssue issue) => switch(issue.severity){
  SongIssueSeverity.blocking => MdiIcons.alertOctagonOutline,
  SongIssueSeverity.decision => MdiIcons.helpCircleOutline,
};

/// Karta piosenkomatu nad przeglądaną piosenką — jedno pudełko na wszystko,
/// co przyniosło zgłoszenie: werdykt, badge POPRAWKA, dopiski osoby dodającej,
/// pastylki z uwagami i pole na odpowiedź.
///
/// Pastylki i dopiski są tylko do czytania: to dla Ciebie, narzędzie ich po
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
  /// etykieta zostałaby nad pustym polem. Klucz na wątku wymusza świeży stan.
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

  void _update(PiosenkomatData Function(PiosenkomatData) change){
    final prov = CurrentItemProvider.of(context);
    final data = prov.song.piosenkomatData;
    if(data == null) return;
    prov.song.piosenkomatData = change(data);
    prov.notify();
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

      final goesIn = data.goesIn;
      final color = goesIn? Colors.green: Colors.red;
      final correction = data.correctionMessage ?? '';
      final frame = contribReplyFrame(oldApp: data.isOldApp);

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
              Row(
                children: [
                  Icon(
                    goesIn
                        ? MdiIcons.checkCircleOutline
                        : MdiIcons.closeCircleOutline,
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
                  Switch(
                    value: goesIn,
                    // `false` zapisujemy jawnie, `true` kasuje flagę do `null`:
                    // plik zwrotny ma nieść tylko odstępstwa od domyślnego
                    // „wchodzi”.
                    onChanged: (value) => _update((d) =>
                        d.copyWith(accepted: () => value? null: false)),
                  ),
                ],
              ),

              // Adres nadawcy — jedyne miejsce, gdy nie doklejono go do karty
              // osoby dodającej.
              if(data.sender case final sender?) ...[
                const SizedBox(height: Dimen.defMarg),
                Row(
                  children: [
                    Icon(
                      MdiIcons.emailOutline,
                      size: Dimen.textSizeNormal,
                      color: hintEnab_(context),
                    ),
                    const SizedBox(width: Dimen.defMarg),
                    Expanded(
                      child: Text(
                        data.senderIsContributor
                            ? sender
                            : '$sender (wysyła w czyimś imieniu)',
                        style: AppTextStyle(
                          fontSize: Dimen.textSizeNormal,
                          color: hintEnab_(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if(data.isCorrection || data.issues.isNotEmpty) ...[
                const SizedBox(height: Dimen.defMarg),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: Dimen.defMarg,
                  runSpacing: Dimen.defMarg,
                  children: [
                    if(data.isCorrection)
                      _CorrectionBadge(data, titleOfAppSong: widget.titleOfAppSong),
                    for(final issue in data.issues) PiosenkomatIssuePill(issue),
                  ],
                ),
              ],

              // Rozmowa: co przyszło od osoby dodającej i co jej odpiszesz.
              // Propozycja poprawki idzie pierwsza i osobno — to pole
              // formularza, nie wiadomość z wątku.
              if(correction.isNotEmpty)
                _Bubble(title: 'Propozycja poprawki', text: correction),

              // Każda wiadomość z wątku we własnym dymku, po swojej stronie:
              // autor z lewej, Twoje odpowiedzi z prawej. Zlepek wszystkiego
              // w jednym dymku nie mówił ani kto co powiedział, ani kiedy.
              for(final message in data.conversation)
                _Bubble(
                  mine: message.isOurs,
                  title: _messageTitle(message),
                  text: message.text,
                ),

              // Bez własnego tytułu: etykietę niesie samo pole — na pustym
              // jest podpowiedzią w środku, a gdy zaczniesz pisać, wjeżdża
              // nad tekst. Taka sama zawsze, niezależnie od werdyktu.
              // Gwiazdka — jak przy AI, ale bez modelu: skleja uwagę
              // z pastylek `missing-*`. Widać ją tylko, gdy jest co
              // zaproponować; klik nie wysyła mejla, tylko wypełnia pole.
              // Szara ramka nad polem i pod nim to reszta mejla, którą dokłada
              // `reply` — ta sama funkcja, więc podgląd nie rozjedzie się z tym,
              // co wyjdzie. Twoje jest tylko pole: ramki nie da się zapomnieć
              // ani zepsuć.
              _Bubble(
                mine: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ReplyFrameText(frame.before),
                    const SizedBox(height: Dimen.defMarg),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextFieldHint(
                            key: ObjectKey(_boundSong),
                            hint: 'Odpowiedz…',
                            // Po wstawieniu z gwiazdki kontroler ma już tekst,
                            // a pływająca etykieta liczy się w `initState` —
                            // bez tego „Odpowiedz…” siada na propozycji.
                            alwaysShowTopHint: _controller?.text.isNotEmpty ?? false,
                            controller: _controller,
                            maxLines: null,
                            showUnderline: false,
                            contentPadding: EdgeInsets.zero,
                            style: AppTextStyle(
                              fontSize: Dimen.textSizeNormal,
                              color: textEnab_(context),
                            ),
                            hintStyle: AppTextStyle(
                              fontSize: Dimen.textSizeNormal,
                              color: hintEnab_(context),
                            ),
                            onChanged: (_, text) => _update((d) => d.copyWith(
                                reviewNote: () =>
                                    text.trim().isEmpty? null: text)),
                          ),
                        ),
                        if(proposeContribReplyNote(data.issues.map((i) => i.issue))
                            case final note?)
                          AppButton(
                            icon: Icon(MdiIcons.starFourPoints),
                            color: accent_(context),
                            tooltip: 'Zaproponuj odpowiedź',
                            onTap: () => _proposeReply(note),
                          ),
                      ],
                    ),
                    const SizedBox(height: Dimen.defMarg),
                    _ReplyFrameText(frame.after),
                  ],
                ),
              ),

            ],
          ),
        ),
      );

    },
  );

}

/// Podpis dymka: kto i kiedy. Bez daty, gdy mejl jej nie niósł — pusty
/// nawias mówiłby mniej niż sam podpis.
String _messageTitle(PiosenkomatMessage message){
  final who = message.isOurs? 'Ty': 'Osoba dodająca';
  final at = message.at;
  if(at == null) return who;
  final local = at.toLocal();
  return '$who · ${local.day}.${local.month}.${local.year}';
}

/// Dymek rozmowy: prostokątny, bez dziubka. Od osoby dodającej — z lewej,
/// na neutralnym tle; Twoja odpowiedź — z prawej, na tle akcentu.
/// Część mejla, którą dokłada narzędzie — na szaro i bez edycji.
class _ReplyFrameText extends StatelessWidget{

  final String text;

  const _ReplyFrameText(this.text);

  @override
  Widget build(BuildContext context) => SelectableText(
    text,
    style: AppTextStyle(fontSize: Dimen.textSizeNormal, color: hintEnab_(context)),
  );

}

class _Bubble extends StatelessWidget{

  final String? title;
  final String? text;
  final Widget? child;
  final bool mine;

  const _Bubble({this.title, this.text, this.child, this.mine = false});

  @override
  Widget build(BuildContext context){
    final accent = accent_(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimen.defMarg),
      child: Align(
        alignment: mine? Alignment.centerRight: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.85,
          ),
          child: Material(
            color: mine
                ? accent.withValues(alpha: 0.15)
                : backgroundIcon_(context),
            borderRadius: BorderRadius.circular(AppCard.defRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimen.defMarg*2,
                vertical: Dimen.defMarg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(title != null) ...[
                    Text(title!, style: AppTextStyle(
                      fontSize: Dimen.textSizeSmall,
                      fontWeight: weightHalfBold,
                      color: mine? accent: hintEnab_(context),
                    )),
                    const SizedBox(height: 2),
                  ],
                  child ?? SelectableText(text!, style: AppTextStyle(
                    fontSize: Dimen.textSizeNormal, color: textEnab_(context))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

/// Jedna pastylka w stylu [Tag] z apki: pełne zaokrąglenie, bez obramowania.
/// Na pastylce sam kod uwagi (`missing-youtube`) — krótki i jednoznaczny;
/// polski opis i szczegół w podpowiedzi. O wadze mówi **kolor pastylki**:
/// półprzezroczyste tło plus ikona i tekst w pełnym kolorze, tak samo jak
/// badge POPRAWKA.
class PiosenkomatIssuePill extends StatelessWidget{

  final PiosenkomatIssue issue;
  /// Mała wersja do listy: mniejsza czcionka, płasko.
  final bool compact;

  const PiosenkomatIssuePill(this.issue, {this.compact = false, super.key});

  @override
  Widget build(BuildContext context){
    final color = piosenkomatIssueColor(issue.issue);
    final fontSize = compact? Dimen.textSizeTiny: Dimen.textSizeSmall;
    final pad = compact? Dimen.defMarg/2: Dimen.iconMarg;

    final pill = SimpleButton(
      radius: 100,
      elevation: 0,
      color: color.withValues(alpha: 0.15),
      // Z lewej mniej niż z prawej: tam siedzi ikona, która ma własny odstęp.
      // Równy padding dookoła odsuwał ją od krawędzi bardziej niż od góry.
      padding: EdgeInsets.only(
        left: pad/2,
        right: pad,
        top: compact? 2: pad/2,
        bottom: compact? 2: pad/2,
      ),
      onTap: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(piosenkomatIssueIcon(issue.issue), size: fontSize + 2, color: color),
          SizedBox(width: pad/2),
          Text(
            issue.issue.id,
            style: AppTextStyle(
              fontSize: fontSize,
              fontWeight: weightHalfBold,
              color: color,
            ),
            maxLines: 1,
          ),
        ],
      ),
    );

    return Tooltip(
      // Przy „has-user-message” szczegółem jest sama wiadomość — a tę widać
      // wyżej w dymku. Powtarzanie jej w podpowiedzi to szum.
      message: [
        issue.issue.text,
        if(issue.detail != null && issue.issue != SongIssue.hasUserMessage)
          issue.detail!,
      ].join('\n'),
      child: pill,
    );
  }

}

/// Mały podgląd do listy piosenek — badge poprawki i pastylki, bez dopisków.
class PiosenkomatIssuesPreview extends StatelessWidget{

  final SongRaw song;

  const PiosenkomatIssuesPreview(this.song, {super.key});

  @override
  Widget build(BuildContext context){
    final data = song.piosenkomatData;
    if(data == null || (!data.isCorrection && data.issues.isEmpty))
      return const SizedBox.shrink();
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: Dimen.defMarg/2,
      runSpacing: Dimen.defMarg/2,
      children: [
        if(data.isCorrection) _CorrectionBadge(data, compact: true),
        for(final issue in data.issues) PiosenkomatIssuePill(issue, compact: true),
      ],
    );
  }

}

class _CorrectionBadge extends StatelessWidget{

  final PiosenkomatData data;
  final bool compact;
  final String? Function(String songId)? titleOfAppSong;

  const _CorrectionBadge(this.data, {this.compact = false, this.titleOfAppSong});

  @override
  Widget build(BuildContext context){
    final fontSize = compact? Dimen.textSizeTiny: Dimen.textSizeSmall;
    final pad = compact? Dimen.defMarg/2: Dimen.iconMarg;
    final accent = accent_(context);

    final target = data.correctionTarget;
    final targetTitle = target == null? null: titleOfAppSong?.call(target) ?? target;
    final when = data.sentAt == null? null: _day(data.sentAt!);

    final label = compact
        ? 'POPRAWKA'
        : [
            'POPRAWKA',
            if(targetTitle != null) '→ $targetTitle',
            if(when != null) '· $when',
          ].join(' ');

    return Tooltip(
      message: target == null
          ? 'Poprawka — nie wiadomo, której piosenki w apce (no-target-in-app)'
          : 'Poprawka piosenki $target',
      child: SimpleButton(
        radius: 100,
        elevation: 0,
        color: accent.withValues(alpha: 0.15),
        padding: EdgeInsets.only(
          left: pad/2,
          right: pad,
          top: compact? 2: pad/2,
          bottom: compact? 2: pad/2,
        ),
        onTap: null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(MdiIcons.pencilOutline, size: fontSize + 2, color: accent),
            SizedBox(width: pad/2),
            Text(
              label,
              style: AppTextStyle(fontSize: fontSize, fontWeight: weightHalfBold, color: accent),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  static String _day(DateTime d) => d.toLocal().toIso8601String().substring(0, 10);

}
