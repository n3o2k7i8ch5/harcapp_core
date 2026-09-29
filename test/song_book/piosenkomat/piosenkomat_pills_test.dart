import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/song_book/piosenkomat/piosenkomat_data.dart';
import 'package:harcapp_core/song_book/piosenkomat/song_issue.dart';
import 'package:harcapp_core/song_book/song_editor/widgets/piosenkomat_pills.dart';

Widget _wrap(Widget child) => Builder(
      builder: (context) => MaterialApp(
        theme: const ColorPackSimple().themeData(context),
        home: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('poprawka znacząco różna od celu: ostrzeżenie widać obok badge POPRAWKA', (tester) async {
    const data = PiosenkomatData(
      kind: SubmissionKind.correction,
      correctionTarget: 'o!_plonie_ognisko',
      issues: [
        PiosenkomatIssue(SongIssue.differsFromTarget, detail: '„Płonie ognisko” w apce: treść niepodobna'),
      ],
    );
    await tester.pumpWidget(_wrap(const PiosenkomatPills(data, compact: true)));

    expect(find.text('POPRAWKA'), findsOneWidget);
    expect(find.text('differs-from-target'), findsOneWidget);
    final tooltip = tester.widget<Tooltip>(find.ancestor(
      of: find.text('differs-from-target'),
      matching: find.byType(Tooltip),
    ));
    expect(tooltip.message, contains('znacząco różna'));
    expect(tooltip.message, contains('treść niepodobna'));
  });
}
