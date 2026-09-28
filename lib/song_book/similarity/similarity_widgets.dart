/// Jak pokazać podobieństwo: kolor poziomu i pastylki dowodów. Tu, a nie na
/// stronie, bo tę samą wizualizację ma dostać apka — inaczej „tekst 82%”
/// wyglądałoby w każdym miejscu inaczej.
library;

import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:harcapp_core/comm_widgets/pill.dart';
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

/// Napis na pastylkę: jak [Similarity.text], ale pola metadanych po polsku.
String similarityLabel(Similarity s) => switch (s) {
      MetadataDiff(fields: final f) => 'inne: ${f.map((e) => e.label).join(', ')}',
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
      LayoutDiff() => MdiIcons.formatLineSpacing,
      MetadataDiff() => MdiIcons.notEqualVariant,
    };

/// Jedna pastylka dowodu — ten sam [Pill], co uwagi piosenkomatu.
class SimilarityPill extends StatelessWidget {

  final Similarity similarity;
  final Color color;
  /// Mała wersja do listy: mniejsza czcionka, płasko.
  final bool compact;

  const SimilarityPill(this.similarity, {required this.color, this.compact = false, super.key});

  @override
  Widget build(BuildContext context) => Pill(
        color: color,
        icon: similarityIcon(similarity),
        label: similarityLabel(similarity),
        compact: compact,
      );

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
