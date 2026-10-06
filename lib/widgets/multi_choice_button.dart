import 'package:flutter/material.dart';
import 'package:my_utils/widgets/multi_choice_button_item.dart';

class MultiChoiceButton<T> extends StatefulWidget {
  const MultiChoiceButton({
    this.onChanged,
    required this.items,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.selectedForegroundColor,
    this.itemPadding,
    this.singleChoice = false,
    super.key,
  });

  final bool singleChoice;
  final List<MultiChoiceButtonItem<T>> items;
  final Color? unselectedBackgroundColor;
  final Color? selectedBackgroundColor;
  final Color? unselectedForegroundColor;
  final Color? selectedForegroundColor;
  final EdgeInsetsGeometry? itemPadding;

  final void Function(List<T> values)? onChanged;

  @override
  State<MultiChoiceButton> createState() => _MultiChoiceButtonState<T>();
}

class _MultiChoiceButtonState<T> extends State<MultiChoiceButton<T>> {
  List<MultiChoiceButtonItem> get items => widget.items;
  List<T> get values => items
      .map<T>(
        (item) => item.value,
      )
      .toList();
  late Set<T> selected;

  @override
  void initState() {
    super.initState();
    selected = items
        .where(
          (element) => element.initiallySelected,
        )
        .map<T>(
          (e) => e.value,
        )
        .toSet();
    assert(
      !widget.singleChoice || selected.length <= 1,
      'When setting single choice, only one item can be selected!',
    );
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        final isSelected = selected.contains(item.value);
        return OutlinedButton(
          onPressed: () {
            setState(() {
              toggleSelected(item.value);
              widget.onChanged?.call(selected.toList());
            });
          },
          style: OutlinedButton.styleFrom(
            padding: widget.itemPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.horizontal(
                start: items.first == item ? Radius.circular(100) : null,
                end: items.last == item ? Radius.circular(100) : null,
              ),
            ),
            backgroundColor: isSelected
                ? widget.selectedBackgroundColor ??
                      Theme.of(context).colorScheme.primary
                : widget.unselectedBackgroundColor ??
                      Theme.of(context).colorScheme.onPrimary,
            foregroundColor: isSelected
                ? widget.selectedForegroundColor ??
                      Theme.of(context).colorScheme.onSecondary
                : widget.selectedForegroundColor ??
                      Theme.of(context).colorScheme.secondary,
          ),
          child: item.child,
        );
      }).toList(),
    );
  }

  void toggleSelected(T value) {
    if (widget.singleChoice) {
      selected = {value};
    } else {
      selected.contains(value) ? selected.remove(value) : selected.add(value);
    }
  }
}
