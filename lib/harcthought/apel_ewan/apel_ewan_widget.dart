import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text.dart';
import 'package:harcapp_core/comm_widgets/person_card.dart';
import 'package:harcapp_core/comm_widgets/tab_bar.dart';
import 'package:harcapp_core/song_book/contributor_identity.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/people/person.dart';
import 'package:harcapp_core/values/people/utils.dart';

import 'apel_ewan.dart';
import 'apel_ewan_loader.dart';

const Map<String, String> _gospelAuthorMap = {
  'Mt': 'Mateusza',
  'Mk': 'Marka',
  'Łk': 'Łukasza',
  'J': 'Jana',
};

const TextStyle _sectionTitleStyle = AppTextStyle(
  fontSize: Dimen.textSizeBig,
  fontWeight: weightHalfBold,
);

String _addedByLabel(ContributorIdentity identity) {
  if (identity.name != null && identity.name!.trim().isNotEmpty) return identity.name!.trim();
  if (identity.emailRef != null && identity.emailRef!.trim().isNotEmpty) return identity.emailRef!.trim();
  return identity.userKeyRef!.trim();
}

Person? _personFor(ContributorIdentity identity) {
  final email = identity.emailRef?.trim();
  if (email == null || email.isEmpty) return null;
  return allPeopleByEmailMap[email];
}

class ApelEwanWidget extends StatefulWidget{

  final ApelEwan apelEwan;
  final String? initVariantId;
  /// Fires whenever the user changes the variant via the in-widget dropdown.
  /// The selected id is one of [apelEwan]'s variant keys (never null). Hosts
  /// can use it to persist the choice (e.g. reflect it in the page URL).
  final ValueChanged<String>? onVariantChanged;

  const ApelEwanWidget(this.apelEwan, {this.initVariantId, this.onVariantChanged, super.key});

  @override
  State<StatefulWidget> createState() => ApelEwanWidgetState();

}

class ApelEwanWidgetState extends State<ApelEwanWidget> with SingleTickerProviderStateMixin{

  ApelEwan get apelEwan => widget.apelEwan;

  late String selVariantId;
  late List<String> allVariantId;
  TabController? _tabController;

  String? author;

  ApelEwanVariant? get selVariant => apelEwan.variants[selVariantId];

  @override
  void initState() {
    selVariantId = _resolveVariantId(widget.initVariantId);
    allVariantId = apelEwan.variants.keys.toList();
    if (allVariantId.length > 1) {
      _tabController = TabController(
        length: allVariantId.length,
        vsync: this,
        initialIndex: allVariantId.indexOf(selVariantId),
      )..addListener(_onTabChanged);
    }
    author = _gospelAuthorMap[apelEwan.siglum.split(' ')[0]];
    super.initState();
  }

  void _onTabChanged() {
    final controller = _tabController!;
    if (controller.indexIsChanging) return;
    final newId = allVariantId[controller.index];
    if (newId == selVariantId) return;
    setState(() => selVariantId = newId);
    widget.onVariantChanged?.call(newId);
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ApelEwanWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the local selection in sync with externally-driven [initVariantId]
    // changes (e.g. host reading a query param after browser back/forward).
    if (widget.initVariantId != oldWidget.initVariantId) {
      final resolved = _resolveVariantId(widget.initVariantId);
      if (resolved != selVariantId) {
        setState(() => selVariantId = resolved);
        final idx = allVariantId.indexOf(resolved);
        if (_tabController != null && idx != -1 && _tabController!.index != idx)
          _tabController!.index = idx;
      }
    }
  }

  String _resolveVariantId(String? requested) =>
      (requested != null && apelEwan.variants.containsKey(requested))
          ? requested
          : apelEwan.variants.keys.first;

  @override
  Widget build(BuildContext context) {
    final variant = selVariant!;
    final hasComment = variant.comment != null;
    final hasQuestions = variant.questions.isNotEmpty;
    return SelectionArea(
      child: Column(
        children: [
          _buildGospelCard(variant),
          const SizedBox(height: Dimen.sideMarg),
          if (hasComment || hasQuestions) ...[
            _buildVariantContentCard(variant, hasComment: hasComment, hasQuestions: hasQuestions),
            const SizedBox(height: Dimen.sideMarg),
          ],
          _buildAddedByCard(),
          const SizedBox(height: Dimen.sideMarg),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) => Material(
    clipBehavior: Clip.hardEdge,
    color: cardEnab_(context),
    borderRadius: BorderRadius.circular(AppCard.bigRadius),
    child: child,
  );

  Widget _section(String title, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(title, style: _sectionTitleStyle, textAlign: TextAlign.justify),
      const SizedBox(height: Dimen.sideMarg),
      child,
    ],
  );

  Widget _buildGospelCard(ApelEwanVariant variant) => _card(
    child: Padding(
      padding: const EdgeInsets.all(Dimen.sideMarg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Text(
            variant.title,
            style: const AppTextStyle(
              fontSize: Dimen.textSizeAppBar,
              fontWeight: weightBold,
            ),
            textAlign: TextAlign.center,
          ),

          if (author != null) ...[
            const SizedBox(height: Dimen.sideMarg),
            Text(
              'Słowa Ewangelii według św. $author',
              style: AppTextStyle(
                fontSize: Dimen.textSizeBig,
                fontWeight: weightHalfBold,
                color: hintEnab_(context),
              ),
              textAlign: TextAlign.justify,
            ),
          ],

          const SizedBox(height: Dimen.sideMarg),

          AppText(
            apelEwan.text.replaceAll('\n\n', '\n').replaceAll('\n', '\n\n'),
            size: Dimen.textSizeBig,
            height: 1.2,
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: Dimen.sideMarg),

          const Text(
            'Oto Słowo Boże.',
            style: AppTextStyle(fontSize: Dimen.textSizeBig),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: Dimen.sideMarg),

          Text(
            apelEwan.edition,
            style: AppTextStyle(
              fontSize: Dimen.textSizeNormal,
              color: hintEnab_(context),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.right,
          ),

        ],
      ),
    ),
  );

  Widget _buildVariantContentCard(
    ApelEwanVariant variant, {
    required bool hasComment,
    required bool hasQuestions,
  }) => _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        if (allVariantId.length > 1)
          Material(
            color: backgroundIcon_(context),
            child: TabBarX(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                color: cardEnab_(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppCard.defRadius),
                  topRight: Radius.circular(AppCard.defRadius),
                ),
              ),
              tabs: allVariantId.map((variantId) => Tab(
                text: apelEwansVariantNameMap[variantId] ?? variantId,
              )).toList(),
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(Dimen.sideMarg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasComment) ...[
                _section(
                  'Garść komentarzy',
                  Text(
                    variant.comment!,
                    style: const AppTextStyle(fontSize: Dimen.textSizeBig),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 2 * Dimen.sideMarg),
              ],
              if (hasQuestions) _section('Pytania', _buildQuestionsList(variant)),
            ],
          ),
        ),

      ],
    ),
  );

  Widget _buildQuestionsList(ApelEwanVariant variant) => ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: variant.questions.length,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text('${index + 1}', style: _sectionTitleStyle),
          ),
          Expanded(
            child: AppText(variant.questions[index], size: Dimen.textSizeBig),
          ),
        ],
      ),
    ),
  );

  Widget _buildAddedByCard() {
    final person = _personFor(apelEwan.addedBy);
    return _card(
      child: Padding(
        padding: const EdgeInsets.all(Dimen.sideMarg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Text(
              'Osoba dodająca',
              style: AppTextStyle(
                fontSize: Dimen.textSizeBig,
                color: hintEnab_(context),
              ),
            ),

            const SizedBox(height: Dimen.defMarg),

            person != null
                ? PersonCard(person, selectable: true)
                : Text(
                    _addedByLabel(apelEwan.addedBy),
                    style: const AppTextStyle(
                      fontSize: Dimen.textSizeBig,
                      fontWeight: weightHalfBold,
                    ),
                  ),

          ],
        ),
      ),
    );
  }

}
