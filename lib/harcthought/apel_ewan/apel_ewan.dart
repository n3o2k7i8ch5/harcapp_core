import 'package:harcapp_core/values/people/contributor_ref.dart';

class ApelEwanVariant{

  final String title;
  final String? shortTitle;
  final List<String> questions;
  final String? comment;

  const ApelEwanVariant({
    required this.title,
    this.shortTitle,
    this.questions = const [],
    this.comment,
  });

  /// Single-line label for tabs, PDF tytuły, etc. Prefers [shortTitle] (with
  /// hyphenated line breaks `-\n` collapsed to `''` and remaining `\n` to
  /// space) and falls back to [title] (newlines normalised to spaces).
  String get oneLineLabel =>
      (shortTitle?.replaceAll('-\n', '') ?? title).replaceAll('\n', ' ');

}

class ApelEwan{

  final String dirName;
  final String siglum;
  final String edition;
  final String text;
  /// Each ApelEwan can be presented under different variants (e.g. 'ogolne',
  /// 'dekalog'). The variants share the gospel [text] but differ by [title],
  /// [shortTitle], [questions] and [comment].
  final Map<String, ApelEwanVariant> variants;
  /// Who added this apel ewangeliczne to the app. At least one of
  /// [ContributorRef.name] / [ContributorRef.emailRef] /
  /// [ContributorRef.userKeyRef] must be set.
  final ContributorRef addedBy;

  const ApelEwan({
    required this.dirName,
    required this.siglum,
    required this.edition,
    required this.text,
    required this.addedBy,
    this.variants = const {},
  });

  /// Returns [variants]\[[variantId]] when it exists, otherwise the first
  /// registered variant. Assumes [variants] is non-empty (true for every apel
  /// produced by [loadAllApelEwans]).
  ApelEwanVariant variantOrFirst(String? variantId) =>
      variants[variantId] ?? variants.values.first;

  @override
  bool operator ==(Object other) => other is ApelEwan && other.dirName == dirName;

  @override
  int get hashCode => dirName.hashCode;

}
