import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:harcapp_core/comm_classes/app_text_style.dart';
import 'package:harcapp_core/comm_classes/color_pack.dart';
import 'package:harcapp_core/comm_widgets/app_button.dart';
import 'package:harcapp_core/comm_widgets/app_card.dart';
import 'package:harcapp_core/comm_widgets/search_field.dart';
import 'package:harcapp_core/values/dimen.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HintDropdownWidget<T> extends StatefulWidget {
  final String hint;
  final String? hintTop;
  final Widget? leading;
  final T value;
  final void Function(T) onChanged;
  final void Function()? onCleared;
  /// Dodatkowy widget po prawej stronie dropdownu (obok ewentualnego „×").
  final Widget? trailing;
  final bool enabled;
  final double dropdownMaxHeight;
  final List<DropdownItem<T>> items;

  /// Jeśli != null, dropdown ma pasek wyszukiwania na górze rozwijanego menu.
  final TextEditingController? searchController;
  final String? searchHint;

  /// Opcjonalny nagłówek nad paskiem wyszukiwania (np. „Hufce z chorągwi X").
  final Widget? searchHeader;
  final double searchHeaderHeight;

  /// Funkcja dopasowująca item do wpisanego tekstu wyszukiwania.
  final bool Function(DropdownItem<T>, String)? searchMatchFn;

  const HintDropdownWidget({
    required this.hint,
    required this.hintTop,
    this.leading,
    required this.value,
    required this.onChanged,
    this.onCleared,
    this.trailing,
    this.enabled = true,
    this.dropdownMaxHeight = 240,
    required this.items,
    this.searchController,
    this.searchHint,
    this.searchHeader,
    this.searchHeaderHeight = 28,
    this.searchMatchFn,
    super.key,
  });

  @override
  State<HintDropdownWidget<T>> createState() => _HintDropdownWidgetState<T>();
}

class _HintDropdownWidgetState<T> extends State<HintDropdownWidget<T>> {
  late final ValueNotifier<T> _valueNotifier;

  bool get _searchable => widget.searchController != null;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(widget.value);
  }

  @override
  void didUpdateWidget(HintDropdownWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) _valueNotifier.value = widget.value;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  DropdownSearchData<T>? _buildSearchData() {
    if (!_searchable) return null;
    final ctrl = widget.searchController!;
    final header = widget.searchHeader;
    return DropdownSearchData<T>(
      searchController: ctrl,
      searchBarWidgetHeight:
          SearchField.height + (header == null ? 0 : widget.searchHeaderHeight),
      searchBarWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) header,
          SearchField(controller: ctrl, hint: widget.searchHint),
        ],
      ),
      searchMatchFn: widget.searchMatchFn,
    );
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          if (widget.leading != null) const SizedBox(width: Dimen.iconMarg),
          if (widget.leading != null) widget.leading!,
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: IgnorePointer(
                        ignoring: !widget.enabled,
                        child: Opacity(
                          opacity: widget.enabled ? 1.0 : 0.5,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                            ),
                            child: DropdownButtonHideUnderline(
                            child: DropdownButton2<T>(
                            isExpanded: true,
                            iconStyleData: const IconStyleData(iconSize: 0),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: widget.dropdownMaxHeight,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppCard.bigRadius),
                              ),
                            ),
                            buttonStyleData: ButtonStyleData(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppCard.defRadius),
                              ),
                            ),
                            style: AppTextStyle(
                              fontSize: Dimen.textSizeBig,
                              color: widget.enabled
                                  ? iconEnab_(context)
                                  : hintEnab_(context),
                            ),
                            hint: Text(widget.hint,
                                style:
                                    AppTextStyle(color: hintEnab_(context))),
                            items: widget.items,
                            valueListenable: _valueNotifier,
                            dropdownSearchData: _buildSearchData(),
                            onMenuStateChange: _searchable
                                ? (open) {
                                    if (!open) {
                                      widget.searchController!.clear();
                                    }
                                  }
                                : null,
                            onChanged: (value) {
                              _valueNotifier.value = value as T;
                              widget.onChanged(value);
                            },
                          ),
                          ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.onCleared != null &&
                        widget.value != null &&
                        widget.enabled)
                      AppButton(
                          icon: Icon(MdiIcons.close), onTap: widget.onCleared),
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
                Positioned(
                  top: 0,
                  left: Dimen.TEXT_FIELD_PADD,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: widget.value == null ? 0 : 1,
                    child: Text(
                      widget.hintTop ?? widget.hint,
                      style: AppTextStyle(
                          fontSize: Dimen.textSizeSmall,
                          fontWeight: weightHalfBold,
                          color: hintEnab_(context)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
}
