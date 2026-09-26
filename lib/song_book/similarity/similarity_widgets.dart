/// Jak pokazać podobieństwo: kolor poziomu i pastylki dowodów. Tu, a nie na
/// stronie, bo tę samą wizualizację ma dostać apka — inaczej „tekst 82%”
/// wyglądałoby w każdym miejscu inaczej.
library;

import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_widgets/simple_button.dart';
import 'package:harcapp_core/values/dimen.dart';

import 'similarity.dart';

/// Czerwony, gdy to **ta sama piosenka** (także z dopisanymi albo uciętymi
/// zwrotkami); pomarańczowy, gdy tylko coś ją łączy i trzeba spojrzeć. Te
/// same dwa kolory, co pastylki uwag piosenkomatu: blokada i decyzja.
Color matchLevelColor(MatchLevel? level) => switch (level) {
      null => Colors.grey,
      final l when l.isSameSong => Colors.red,
      _ => Colors.orange,
    };

/// Polska nazwa pola z [MetadataDiff] — **tylko do pokazania**.
/// [Similarity.text] zostaje techniczne, bo jedzie do plików przeglądu
/// i raportów piosenkomatu, a tych nie wolno zmieniać pod UI.
String metadataFieldLabel(String field) => switch (field) {
      'title' => 'tytuł',
      'hid_titles' => 'tytuły ukryte',
      'authors' => 'autorzy',
      'composers' => 'kompozytorzy',
      'performers' => 'wykonawcy',
      'release_date' => 'data wydania',
      'yt_video_id' => 'YouTube',
      'tags' => 'tagi',
      _ => field,
    };

/// Napis na pastylkę: jak [Similarity.text], ale pola metadanych po polsku.
String similarityLabel(Similarity s) => switch (s) {
      MetadataDiff(fields: final f) => 'inne: ${f.map(metadataFieldLabel).join(', ')}',
      _ => s.text,
    };

IconData similarityIcon(Similarity s) => switch (s) {
      SameId() => MdiIcons.identifier,
      SameTitle() => MdiIcons.formTextbox,
      SameText() => MdiIcons.textBoxCheckOutline,
      SharedLines() => MdiIcons.textBoxSearchOutline,
      SameChords() => MdiIcons.musicNote,
      ChordsMatch() => MdiIcons.musicNoteOutline,
      MeterMatch() => MdiIcons.metronome,
      SameRecording() => MdiIcons.playBoxOutline,
      MetadataDiff() => MdiIcons.notEqualVariant,
    };

/// Jedna pastylka dowodu, w stylu pastylek uwag piosenkomatu: pełne
/// zaokrąglenie, półprzezroczyste tło, ikona i tekst w pełnym kolorze.
class SimilarityPill extends StatelessWidget {

  final Similarity similarity;
  final Color color;
  /// Mała wersja do listy: mniejsza czcionka, płasko.
  final bool compact;

  const SimilarityPill(this.similarity, {required this.color, this.compact = false, super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = compact ? Dimen.textSizeTiny : Dimen.textSizeSmall;
    final pad = compact ? Dimen.defMarg / 2 : Dimen.iconMarg;

    return SimpleButton(
      radius: 100,
      elevation: 0,
      color: color.withValues(alpha: 0.15),
      padding: EdgeInsets.only(
        left: pad / 2,
        right: pad,
        top: compact ? 2 : pad / 2,
        bottom: compact ? 2 : pad / 2,
      ),
      onTap: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(similarityIcon(similarity), size: fontSize + 2, color: color),
          SizedBox(width: pad / 2),
          Text(
            similarityLabel(similarity),
            style: AppTextStyle(fontSize: fontSize, fontWeight: weightHalfBold, color: color),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

}

/// Rząd pastylek dowodów — od lewej, zawijany. Kolor wspólny dla wszystkich,
/// bo mówi o **poziomie** trafienia, nie o pojedynczym dowodzie.
class SimilarityPills extends StatelessWidget {

  final List<Similarity> similarities;
  final Color color;
  final bool compact;

  const SimilarityPills(this.similarities, {required this.color, this.compact = false, super.key});

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.start,
        spacing: compact ? Dimen.defMarg / 2 : Dimen.defMarg,
        runSpacing: compact ? Dimen.defMarg / 2 : Dimen.defMarg,
        children: [
          for (final s in similaritiesToShow(similarities))
            SimilarityPill(s, color: color, compact: compact),
        ],
      );

}
