import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_classes/polish_inflection.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/app_text_field_hint.dart';
import 'package:harcapp_core/comm_widgets/hint_dropdown_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:harcapp_core/values/org.dart';
import 'package:harcapp_core/values/srodowiska/choragwie.dart';
import 'package:harcapp_core/values/srodowiska/hufce.dart';
import 'package:harcapp_core/values/srodowiska/models.dart';
import 'package:harcapp_core/values/srodowiska/okregi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Cascading picker dla [Srodowisko]: Hufiec → Chorągiew → Okręg → Organizacja.
///
/// Wybór dowolnego poziomu auto-uzupełnia i wyszarza poziomy *wyższe*
/// (derived). Poziom aktywny i poziomy *niższe* (głębsze) są edytowalne.
/// „×" na aktywnym poziomie czyści całą strukturalną kaskadę (zostaje tylko
/// `custom` jeśli był wpisany).
class SrodowiskoInputField extends StatefulWidget {
  final Srodowisko? value;
  final void Function(Srodowisko?) onChanged;
  final bool withCustom;

  const SrodowiskoInputField({
    required this.value,
    required this.onChanged,
    this.withCustom = true,
    super.key,
  });

  @override
  State<SrodowiskoInputField> createState() => _SrodowiskoInputFieldState();
}

enum _Level { none, org, okreg, choragiew, hufiec }

/// Organizacje pokazywane w dropdownie. Każda chorągiew w danych ostatecznie
/// wskazuje na okręg z dokładnie jedną z tych wartości jako `.org`.
const List<Org> _orgsToShow = [
  Org.zhp, Org.zhr, Org.fse, Org.sh, Org.zhpNL, Org.hrp,
];

/// Organizacje, które mają realne okręgi (nie pseudo). Dla pozostałych pole
/// okręgu jest ukrywane.
const Set<Org> _orgsWithOkregi = {Org.zhr};

class _SrodowiskoInputFieldState extends State<SrodowiskoInputField> {
  late final TextEditingController _hufiecSearchCtrl;
  late final TextEditingController _customCtrl;

  @override
  void initState() {
    super.initState();
    _hufiecSearchCtrl = TextEditingController();
    _customCtrl = TextEditingController(text: widget.value?.custom);
  }

  @override
  void didUpdateWidget(SrodowiskoInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newCustom = widget.value?.custom ?? '';
    if (newCustom != _customCtrl.text) _customCtrl.text = newCustom;
  }

  @override
  void dispose() {
    _hufiecSearchCtrl.dispose();
    _customCtrl.dispose();
    super.dispose();
  }

  // ---- bieżący stan ----
  Srodowisko? get _value => widget.value;
  Hufiec? get _hufiec => _value?.hufiec;
  Choragiew? get _choragiew => _value?.choragiew;
  Okreg? get _okreg => _value?.okreg;
  Org? get _org => _value?.org;
  String? get _custom => _value?.custom;

  /// Najgłębszy poziom kanonicznie zapisany w [Srodowisko].
  _Level get _activeLevel {
    if (_value?.hufiecSlug != null) return _Level.hufiec;
    if (_value?.choragiewSlug != null) return _Level.choragiew;
    if (_value?.okregSlug != null) return _Level.okreg;
    if (_value?.orgSlug != null) return _Level.org;
    return _Level.none;
  }

  // ---- mutacje ----
  /// Rekonstruuje `Srodowisko` z opcjonalnego strukturalnego [base] i bieżącego
  /// `custom`. Jeśli oba puste — `null`.
  Srodowisko? _rebase(Srodowisko? base, {String? customOverride}) {
    final c = customOverride ?? _custom;
    final hasCustom = c != null && c.isNotEmpty;
    if (base == null) return hasCustom ? Srodowisko.custom(c) : null;
    if (!hasCustom) return base;
    return Srodowisko(
      hufiecSlug: base.hufiecSlug,
      choragiewSlug: base.choragiewSlug,
      okregSlug: base.okregSlug,
      orgSlug: base.orgSlug,
      custom: c,
    );
  }

  void _emit(Srodowisko? newValue) => widget.onChanged(newValue);

  void _setHufiec(Hufiec h) => _emit(_rebase(Srodowisko.hufiec(h.slug)));
  void _setChoragiew(Choragiew c) => _emit(_rebase(Srodowisko.choragiew(c.slug)));
  void _setOkreg(Okreg o) => _emit(_rebase(Srodowisko.okreg(o.slug)));
  void _setOrg(Org o) => _emit(_rebase(Srodowisko.org(o.name)));

  /// Poziom „derived" — auto-uzupełniony powyżej aktywnego, można go ukryć.
  /// W enumie kierunek jest odwrócony: hufiec ma najwyższy index (najgłębszy),
  /// więc derived = mniejszy index niż aktywny.
  bool _isDerived(_Level l) =>
      _activeLevel != _Level.none && l != _Level.none && l.index < _activeLevel.index;

  bool _isVisible(_Level l) => switch (l) {
        _Level.hufiec => _value?.showHufiec ?? true,
        _Level.choragiew => _value?.showChoragiew ?? true,
        _Level.okreg => _value?.showOkreg ?? true,
        _Level.org => _value?.showOrg ?? true,
        _Level.none => false,
      };

  void _toggleVisibility(_Level l) {
    final v = _value;
    if (v == null) return;
    _emit(Srodowisko(
      hufiecSlug: v.hufiecSlug,
      choragiewSlug: v.choragiewSlug,
      okregSlug: v.okregSlug,
      orgSlug: v.orgSlug,
      custom: v.custom,
      showHufiec: l == _Level.hufiec ? !v.showHufiec : v.showHufiec,
      showChoragiew: l == _Level.choragiew ? !v.showChoragiew : v.showChoragiew,
      showOkreg: l == _Level.okreg ? !v.showOkreg : v.showOkreg,
      showOrg: l == _Level.org ? !v.showOrg : v.showOrg,
    ));
  }

  /// Czyści całą strukturalną kaskadę (zostaje tylko `custom`).
  void _clearStructured() => _emit(_rebase(null));

  void _setCustom(String text) {
    final t = text.trim();
    final base = switch (_activeLevel) {
      _Level.hufiec => Srodowisko(hufiecSlug: _value!.hufiecSlug),
      _Level.choragiew => Srodowisko(choragiewSlug: _value!.choragiewSlug),
      _Level.okreg => Srodowisko(okregSlug: _value!.okregSlug),
      _Level.org => Srodowisko(orgSlug: _value!.orgSlug),
      _Level.none => null,
    };
    _emit(_rebase(base, customOverride: t));
  }

  // ---- filtry dla list ----
  // Pomijamy pseudo-okręgi (ZHP root) — chorągwie ZHP pasują tylko po Org.
  List<Choragiew> get _choragwieFiltered {
    final o = _org;
    final ok = _okreg;
    return choragwie.where((c) {
      if (ok != null) return c.okreg.slug == ok.slug;
      if (o != null) return c.org == o;
      return true;
    }).toList();
  }

  List<Hufiec> get _hufceFiltered {
    final c = _choragiew;
    if (c != null) return hufce.where((h) => h.choragiew.slug == c.slug).toList();
    final ok = _okreg;
    if (ok != null) return hufce.where((h) => h.choragiew.okreg.slug == ok.slug).toList();
    final o = _org;
    if (o != null) return hufce.where((h) => h.choragiew.org == o).toList();
    return hufce;
  }

  /// Opis filtra na hufce — pokazywany jako nagłówek nad listą w dropdownie.
  String? get _hufceFilterLabel {
    if (_choragiew != null) return 'Hufce z chorągwi ${choragiewGenitive(_choragiew!.name)}';
    if (_okreg != null) return 'Hufce z ${okregGenitive(_okreg!.name)}';
    if (_org != null) return 'Hufce z ${_org!.shortName.$1}';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final org = _org;
    final activeLevel = _activeLevel;

    // Poziom jest edytowalny jeśli jest na/poniżej aktywnego. Poziomy wyżej
    // są wyliczane (derived) i wyszarzone.
    bool enabledAt(_Level l) =>
        activeLevel == _Level.none || l.index >= activeLevel.index;

    VoidCallback? clearIfActive(_Level l) =>
        activeLevel == l ? _clearStructured : null;

    final orgHasOkregi = org == null || _orgsWithOkregi.contains(org);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _slot(_hufiecDropdown(enabled: enabledAt(_Level.hufiec), clearIfActive: clearIfActive(_Level.hufiec))),
        const SizedBox(height: Dimen.sideMarg),
        _slot(_choragiewDropdown(enabled: enabledAt(_Level.choragiew), clearIfActive: clearIfActive(_Level.choragiew))),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: orgHasOkregi
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: Dimen.sideMarg),
                    _slot(_okregDropdown(enabled: enabledAt(_Level.okreg), clearIfActive: clearIfActive(_Level.okreg))),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: Dimen.sideMarg),
        _slot(_orgDropdown(enabled: enabledAt(_Level.org), clearIfActive: clearIfActive(_Level.org))),
        if (widget.withCustom) ...[
          const SizedBox(height: Dimen.sideMarg),
          _slot(_customField()),
        ],
      ],
    );
  }

  /// Ikona oka dla poziomów derived (auto-uzupełnionych). Tap przełącza
  /// widoczność danego poziomu w wynikowym [Srodowisko]. Zwraca `null` dla
  /// poziomu aktywnego (nie da się ukryć własnego wyboru).
  Widget? _visibilityToggle(_Level level) {
    if (!_isDerived(level)) return null;
    return AppButton(
      icon: Icon(
        _isVisible(level) ? MdiIcons.eyeOutline : MdiIcons.eyeOffOutline,
        color: iconEnab_(context),
      ),
      onTap: () => _toggleVisibility(level),
    );
  }

  // ---- buildery pól ----
  Widget _hufiecDropdown({required bool enabled, required VoidCallback? clearIfActive}) {
    final label = _hufceFilterLabel;
    return HintDropdownWidget<Hufiec?>(
      hint: 'Hufiec:',
      hintTop: 'Hufiec',
      leading: Icon(MdiIcons.accountGroupOutline, color: iconDisab_(context)),
      value: _hufiec,
      enabled: enabled,
      onChanged: (h) { if (h != null) _setHufiec(h); },
      onCleared: clearIfActive,
      trailing: _visibilityToggle(_Level.hufiec),
      dropdownMaxHeight: 320,
      items: [
        for (final h in _hufceFiltered) _item(h, h.name),
      ],
      searchController: _hufiecSearchCtrl,
      searchHint: 'Szukaj hufca...',
      searchHeader: label == null ? null : Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Text(
          label,
          style: AppTextStyle(
            fontSize: Dimen.textSizeSmall,
            fontWeight: weightHalfBold,
            color: hintEnab_(context),
          ),
        ),
      ),
      searchMatchFn: (item, search) {
        final h = item.value;
        return h != null && h.name.toLowerCase().contains(search.toLowerCase());
      },
    );
  }

  Widget _choragiewDropdown({required bool enabled, required VoidCallback? clearIfActive}) =>
      HintDropdownWidget<Choragiew?>(
        hint: 'Chorągiew:',
        hintTop: 'Chorągiew',
        leading: Icon(MdiIcons.flagOutline, color: iconDisab_(context)),
        value: _choragiew,
        enabled: enabled,
        onChanged: (c) { if (c != null) _setChoragiew(c); },
        onCleared: clearIfActive,
        trailing: _visibilityToggle(_Level.choragiew),
        items: [
          for (final c in _choragwieFiltered) _item(c, c.name),
        ],
      );

  Widget _okregDropdown({required bool enabled, required VoidCallback? clearIfActive}) =>
      HintDropdownWidget<Okreg?>(
        hint: 'Okręg:',
        hintTop: 'Okręg',
        leading: Icon(MdiIcons.mapMarkerOutline, color: iconDisab_(context)),
        value: _okreg,
        enabled: enabled,
        onChanged: (o) { if (o != null) _setOkreg(o); },
        onCleared: clearIfActive,
        trailing: _visibilityToggle(_Level.okreg),
        items: [
          for (final o in okregi) _item(o, o.name),
        ],
      );

  Widget _orgDropdown({required bool enabled, required VoidCallback? clearIfActive}) =>
      HintDropdownWidget<Org?>(
        hint: 'Organizacja:',
        hintTop: 'Organizacja',
        leading: Icon(MdiIcons.homeVariantOutline, color: iconDisab_(context)),
        value: _org,
        enabled: enabled,
        onChanged: (o) { if (o != null) _setOrg(o); },
        onCleared: clearIfActive,
        trailing: _visibilityToggle(_Level.org),
        items: [
          for (final o in _orgsToShow) _item(o, o.fullName),
        ],
      );

  Widget _customField() => AppTextFieldHint(
        hint: 'Środowisko (własne):',
        hintTop: 'Środowisko (własne)',
        style: AppTextStyle(fontSize: Dimen.textSizeBig),
        controller: _customCtrl,
        contentPadding: const EdgeInsets.only(left: 16),
        onChanged: (_, text) => _setCustom(text),
      );

  DropdownItem<T?> _item<T>(T value, String label) => DropdownItem<T?>(
        value: value,
        child: Text(
          label,
          style: AppTextStyle(color: textEnab_(context)),
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _slot(Widget child) => Theme(
        // Wyłączamy overlaye hover/focus/highlight — chcemy tylko splash z
        // tapnięcia, a dropdown nie powinien się „podświetlać" pod kursorem.
        data: Theme.of(context).copyWith(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Material(
          color: cardEnab_(context),
          borderRadius: BorderRadius.circular(AppCard.defRadius),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.all(Dimen.defMarg / 2),
            child: SizedBox(height: Dimen.iconFootprint, child: child),
          ),
        ),
      );
}
