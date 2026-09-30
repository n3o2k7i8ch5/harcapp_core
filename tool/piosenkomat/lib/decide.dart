/// Polityka: cechy zgłoszenia (i porównanie z paczką) → decyzja. Jedna
/// tabela — [decide] — i reguły, na których stoi. Cechy zbiera `classify`,
/// tu nic nie czyta mejli ani plików.
library;

import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/song_raw.dart';
import 'package:harcapp_core/song_book/submission/submission_file.dart';

import 'model.dart';
import 'similarity.dart';

/// Cechy (i porównanie z paczką) → decyzja. Jedna tabela; `kind` jest
/// deklaracją autora i rozstrzyga pierwsza. Identyczna z apką **nigdy** nie
/// idzie do pliku.
Decision decide(Submission s, {BatchMatch? batch}) {
  final song = s.song;
  if (song == null) {
    // Zepsuty załącznik ma znany powód: odrzut, nie worek „nie umiem odczytać”.
    return switch (s.fileError) {
      null => const Decision(Destination.rejectUnparsable, haveALook: true),
      SubmissionFileErrorKind.unknownFormat =>
        Decision(Destination.rejectUnknownFormat, detail: s.fileErrorMessage, haveALook: true),
      _ => Decision(Destination.rejectCorruptedFile, detail: s.fileErrorMessage, haveALook: true),
    };
  }

  // Kilka piosenek w jednym mejlu: nie rozstrzygamy — ani pliku, ani odrzutu.
  // Jeden wątek to jedna piosenka, więc reszta nie miałaby gdzie wejść.
  if (s.hasMultipleSongs) {
    return Decision(Destination.multipleSongs,
        detail: 'w pliku ${s.submissionCount} zgłoszeń — ogarnij ręcznie', haveALook: true);
  }

  if (batch != null && !batch.isNewestInBatch) {
    return Decision(Destination.rejectDuplicate,
        detail: 'nowsza wersja w [${batch.threadId}]');
  }

  final app = s.appMatch;
  final appLevel = app?.level;

  if (appLevel == MatchLevel.identical) {
    // Identyczna to odrzut — nowa czy poprawka, z dopiskiem czy bez. Gdy autor
    // coś napisał, warto rzucić okiem (dopisek albo propozycja poprawki bywa
    // całą treścią zgłoszenia).
    return Decision(Destination.rejectAlreadyInApp, detail: app!.detail, haveALook: s.hasAuthorText);
  }

  final issues = <PiosenkomatIssue>[];
  void add(SongIssue issue, [String? detail]) =>
      issues.add(PiosenkomatIssue(issue, detail: detail));

  // Wspólne.
  if (s.contributorEmailGuessed) {
    add(SongIssue.guessedContributor, 'adres ${s.sender} doklejony do jedynej karty');
  }
  if (s.hasSeveralContributors) {
    add(SongIssue.severalContributors, 'przypisz wkład ręcznie');
  }
  if (s.acceptedRulesVersion == null) add(SongIssue.noConsent);
  if (s.sender == null) {
    add(SongIssue.noContributorEmail, 'nadawca: ${s.message.from ?? 'brak nagłówka'}');
  }
  if (s.hasUserMessage) add(SongIssue.userMessage, s.userMessage!.trim());

  if (s.isCorrection) {
    final declared = s.declaredCorrectionTarget;
    final resolved = pickCorrectionTarget(s);
    final target = resolved?.id;
    if (target == null) {
      add(SongIssue.noTargetInApp, switch (s.declaredTargetLookup) {
        _ when declared == null => app == null
            ? 'nic w apce nie pasuje tytułem ani tekstem'
            // Coś tam pasuje, ale za słabo, by na to podmieniać.
            : 'za mało podobne: ${app.detail}',
        IdLookup.ambiguous => 'apka wskazała „$declared”; bez wykonawcy pasuje kilka: '
            '${s.declaredTargetCandidates.join(', ')}',
        // Albo autor poprawiał własną piosenkę, albo id zdążyło się zmienić.
        _ => 'apka wskazała „$declared”, a nie ma go w śpiewniku',
      });
    } else if (resolved!.guessed) {
      // Domysł musi być widoczny: podmiana idzie po id, więc to Ty
      // decydujesz, czy narzędzie trafiło.
      add(SongIssue.guessedCorrectionTarget, declared == null
          ? app!.detail
          // Id sprzed zmiany wykonawcy w apce — ta sama piosenka, ale domysł.
          : 'apka wskazała „$declared”, w śpiewniku jest „$target” — inny wykonawca');
    }
    // Cel jest, ale treść to już nie ta sama piosenka — podmiana po id
    // wstawiłaby pod starym id coś innego. Drobne zmiany i dopisane zwrotki
    // to normalny kształt poprawki, bez uwag o apce.
    if (target != null && !_closeToTarget(app?.level)) {
      add(SongIssue.differsFromTarget, _targetDetail(app!));
    }
    if (batch != null) {
      // `batchMatch` bywa dopasowaniem po samym tekście (różne tytuły), a cele
      // obu poprawek mogą być różne — wtedy to nie „druga poprawka tej samej
      // piosenki”, tylko zwykły duplikat treści.
      if (target != null && batch.correctionTarget == target) {
        add(SongIssue.sameTargetInBatch, batch.detail);
      } else if (batch.sameMainTitle) {
        add(SongIssue.sameTitleInBatch, batch.detail);
      } else if (batch.level != null) {
        add(SongIssue.similarTextInBatch, batch.detail);
      }
    }
    return Decision(Destination.candidate, issues: issues, correctionTarget: resolved);
  }

  // Nowa piosenka.
  if (song.title.trim().isEmpty) add(SongIssue.missingTitle, s.message.subject);
  if (!song.hasChords) add(SongIssue.missingChords, _chordsDetail(song));
  if ((song.youtubeVideoId ?? '').trim().isEmpty) add(SongIssue.missingYoutube);

  // Pastylka mówi o najsilniejszym trafieniu, a kolejne dopisuje — dwie
  // piosenki z apki podobne do zgłoszenia to często dwie wersje tej samej.
  final appDetail = [
    if (app != null) app.detail,
    for (final m in s.alsoInApp)
      if (m.level?.byContent ?? false) 'też ${m.detail}',
  ].join('; ');
  switch (appLevel) {
    case MatchLevel.sameSong:
      // Te same wersy: różni się coś, co pokazuje pastylka. Chwyty tylko
      // w innej kolejności (przesunięty refren) to wciąż te same chwyty.
      add(sameChordsUpToOrder(app!.similarities) ? SongIssue.metadataDifferFromApp : SongIssue.chordsDifferFromApp,
          appDetail);
    case MatchLevel.longer:
      add(SongIssue.moreVersesThanApp, appDetail);
    case MatchLevel.shorter:
      add(SongIssue.fewerVersesThanApp, appDetail);
    case MatchLevel.variant:
      add(SongIssue.variantOfApp, appDetail);
    case MatchLevel.related:
      add(SongIssue.similarTextInApp, appDetail);
    case MatchLevel.sameTitleDifferentText:
      add(SongIssue.sameTitleInApp, appDetail);
    case MatchLevel.sameIdDifferentSong:
      // Samo id nic nie mówi o treści: to konflikt nazwy pliku, który
      // `assignUniqueIds` i tak rozwiąże sufiksem, nie duplikat.
    case MatchLevel.identical:
    case null:
      break;
  }
  // Identyczna z nowszą odpada wyżej, a te, które zostają, nie są sobie
  // identyczne — tu każde dopasowanie w paczce jest uwagą.
  if (batch != null && batch.level != null) {
    add(batch.sameMainTitle ? SongIssue.sameTitleInBatch : SongIssue.similarTextInBatch,
        batch.detail);
  }
  return Decision(Destination.candidate, issues: issues);
}

/// Którą piosenkę w apce poprawia [s] — i czy to domysł. Najpierw to, co
/// powiedziało zgłoszenie — o ile taka piosenka jest w śpiewniku; deklaracja
/// nieistniejącego id to brak celu, nie cel. Gdy zgłoszenie nie powiedziało
/// nic — najbliższa piosenka z apki, o ile jest naprawdę blisko
/// ([canGuessCorrectionTarget]). Zgłoszenie bez decyzji człowieka wchodzi
/// (przełącznik domyślnie zapalony), więc słaby domysł kasujemy do `null`,
/// a nie zostawiamy do wyłapania okiem.
///
/// Domysł nigdy nie udaje danych: `guessed` jedzie do śladu piosenki
/// i daje uwagę `guessed-correction-target`. Domysłem jest cel dobrany po
/// podobieństwie albo znaleziony dopiero bez `@wykonawca`.
({String id, bool guessed})? pickCorrectionTarget(Submission s) {
  if (!s.isCorrection) return null;
  if (s.declaredCorrectionTarget != null) {
    final id = s.isDeclaredTargetInApp ? s.appMatch?.songId : null;
    return id == null ? null : (id: id, guessed: s.declaredTargetLookup == IdLookup.withoutPerformer);
  }
  final guess = s.appMatch;
  return guess != null && canGuessCorrectionTarget(guess) ? (id: guess.songId, guessed: true) : null;
}

/// Reguła: czy na [m] wolno wskazać poprawkę, która **nie powiedziała**,
/// co poprawia. Podmiana idzie po id, więc sam zbieżny tytuł („Barka” to
/// nie zawsze ta sama „Barka”) nie wystarczy: wymagamy co najmniej połowy
/// wspólnych wersów w którąś stronę ([MatchLevel.variant] i mocniejsze) —
/// poprawka może właśnie zmieniać tytuł, a (prawie) ten sam tekst to ta
/// sama piosenka. Słabsze podobieństwo przechodzi tylko z tym samym tytułem.
bool canGuessCorrectionTarget(AppMatch m) {
  final l = m.level;
  if (l == null) return false;
  if (l.index <= MatchLevel.variant.index) return true;
  return l == MatchLevel.related && m.similarities.has<SameTitle>();
}

/// Poprawka na tyle bliska celowi, że podmiana nikogo nie zaskoczy: ta sama
/// piosenka z drobnymi zmianami albo z dopisanymi zwrotkami. Ucięte zwrotki
/// już nie — podmiana by je skasowała.
bool _closeToTarget(MatchLevel? level) => level == MatchLevel.sameSong || level == MatchLevel.longer;

/// `„Płonie ognisko” w apce: treść niepodobna` — jak bardzo poprawka odbiega
/// od celu i po czym to widać.
String _targetDetail(AppMatch app) {
  final evidence = similaritiesText(app.similarities);
  return '„${app.song.title}” w apce: ${app.level?.text ?? 'treść niepodobna'}'
      '${evidence.isEmpty ? '' : ' ($evidence)'}';
}

/// Ile linijek tekstu zostało bez chwytów — bez tego „brak chwytów” nie mówi,
/// czy brakuje wszystkiego, czy jednej zwrotki.
String _chordsDetail(SongRaw song) {
  final lines = song.text.split('\n').where((l) => l.trim().isNotEmpty).length;
  return 'linijek tekstu: $lines, chwytów: brak';
}
