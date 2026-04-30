import 'package:harcapp_core/song_book/contributor_identity.dart';

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

}

class ApelEwan{

  final String dirName;
  final String siglum;
  final String text;
  /// Each ApelEwan can be presented under different variants (e.g. 'ogolne',
  /// 'dekalog'). The variants share the gospel [text] but differ by [title],
  /// [shortTitle], [questions] and [comment].
  final Map<String, ApelEwanVariant> variants;
  final Set<String> folders;
  /// Who added this apel ewangeliczne to the app. At least one of
  /// [ContributorIdentity.name] / [ContributorIdentity.emailRef] /
  /// [ContributorIdentity.userKeyRef] must be set.
  final ContributorIdentity addedBy;

  const ApelEwan({
    required this.dirName,
    required this.siglum,
    required this.text,
    required this.addedBy,
    this.variants = const {},
    this.folders = const {},
  });

  @override
  bool operator ==(Object other) => other is ApelEwan && other.dirName == dirName;

  @override
  int get hashCode => dirName.hashCode;

}
