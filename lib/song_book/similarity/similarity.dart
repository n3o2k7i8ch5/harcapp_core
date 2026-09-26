/// Podobieństwo piosenek: jeden moduł dla piosenkomatu, edytora na stronie
/// i apki — inaczej każde z nich ma własną definicję „ta sama piosenka”
/// i ta sama para wychodzi duplikatem w jednym miejscu, a nie w drugim.
/// To jedyny import; środek (`src/`) jest szczegółem implementacji.
///
/// Jak to działa:
/// 1. [SongProfile] — odcisk piosenki: znormalizowane wersy (trigramy
///    znaków), słowa, pary akordów niezależne od tonacji, metrum, tytuły,
///    film YouTube, metadane.
/// 2. [compare] — dowody ([Similarity]) między dwiema piosenkami. Główny to
///    [SharedLines]: które wersy jednej mają odpowiednik w drugiej, w obie
///    strony. Literówki, kolejność zwrotek, powtórzenia refrenu i sklejone
///    wersy go nie ruszają; dopisane i ucięte zwrotki widać po asymetrii.
/// 3. [levelOf] — wniosek ([MatchLevel]) jako jedna tabela reguł nad
///    dowodami. Tekst rozstrzyga, tytuł tylko opisuje: ta sama treść pod
///    innym tytułem to ta sama piosenka, a ten sam tytuł nad inną treścią —
///    nie.
/// 4. [SongIndex] — tanio wybiera kandydatów, dokładnie porównuje tylko ich.
library;

export 'src/evidence.dart'
    show
        Similarity,
        SameId,
        SameTitle,
        SameText,
        SharedLines,
        SameChords,
        ChordsMatch,
        MeterMatch,
        SameRecording,
        MetadataDiff,
        SimilarityList,
        compare,
        similaritiesToShow,
        similaritiesText,
        kSameChordPairs;
export 'src/index.dart' show SongIndex, SongMatch, MatchSource, compareSongMatches, correctionTargetOf;
export 'src/level.dart' show MatchLevel, levelOf, similarityScore, kSameLines, kVariantLines, kMinLinesWeight;
export 'src/lines.dart' show kLineMatch;
export 'src/normalize.dart' show textWords, squash, pct;
export 'src/profile.dart' show SongProfile;
