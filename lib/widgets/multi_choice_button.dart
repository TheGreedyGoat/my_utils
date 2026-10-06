import 'package:flutter/material.dart';
import 'package:my_utils/widgets/single_choice_button.dart';

class MultiChoiceButton extends StatefulWidget {
  const MultiChoiceButton({
    this.onChanged,
    required this.items,
    this.selected,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.selectedForegroundColor,
    this.itemPadding,
    super.key,
  });
  final List<MultiChoiceButtonItem> items;
  final Set<int>? selected;
  final Color? unselectedBackgroundColor;
  final Color? selectedBackgroundColor;
  final Color? unselectedForegroundColor;
  final Color? selectedForegroundColor;
  final EdgeInsetsGeometry? itemPadding;

  final void Function(List<int> values)? onChanged;

  @override
  State<MultiChoiceButton> createState() => _MultiChoiceButtonState();
}

class _MultiChoiceButtonState extends State<MultiChoiceButton> {
  List<MultiChoiceButtonItem> get items => widget.items;
  late Set<int> selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? {};
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .map(
            (item) => OutlinedButton(
              onPressed: () {
                setState(() {
                  final index = items.indexOf(item);
                  _isSelected(index)
                      ? selected.remove(index)
                      : selected.add(index);

                  item.onSelected?.call();
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
                backgroundColor: _isSelected((items.indexOf(item)))
                    ? widget.selectedBackgroundColor ??
                          Theme.of(context).colorScheme.primary
                    : widget.unselectedBackgroundColor ??
                          Theme.of(context).colorScheme.onPrimary,
                foregroundColor: _isSelected((items.indexOf(item)))
                    ? widget.selectedForegroundColor ??
                          Theme.of(context).colorScheme.onSecondary
                    : widget.selectedForegroundColor ??
                          Theme.of(context).colorScheme.secondary,
              ),
              child: item.child,
            ),
          )
          .toList(),
    );
  }

  bool _isSelected(int index) => selected.contains(index);
}
