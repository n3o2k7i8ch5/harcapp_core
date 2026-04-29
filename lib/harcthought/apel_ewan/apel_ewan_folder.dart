import 'package:harcapp_core/folder/folder.dart';

import 'apel_ewan.dart';

abstract class ApelEwanFolder extends Folder{

  final String id;
  final List<ApelEwan> apelEwans;

  const ApelEwanFolder({
    required this.id,
    required this.apelEwans,
  });

  @override
  int get count => apelEwans.length;

  bool get isEmpty;

  @override
  bool operator == (Object other) =>
      other is ApelEwanFolder && id == other.id;

  @override
  int get hashCode => id.hashCode;

}
