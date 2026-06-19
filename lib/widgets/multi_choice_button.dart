import 'package:flutter/material.dart';

class MultiChoiceButton extends StatefulWidget {
  const MultiChoiceButton({
    this.onChanged,
    required this.items,
    this.initialValue = 0,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.selectedForegroundColor,
    super.key,
  });

  final int initialValue;
  final List<MultiChoiceButtonItem> items;
  final Color? unselectedBackgroundColor;
  final Color? selectedBackgroundColor;
  final Color? unselectedForegroundColor;
  final Color? selectedForegroundColor;

  final void Function(int value)? onChanged;

  @override
  State<MultiChoiceButton> createState() => _MultiChoiceButtonState();
}

class _MultiChoiceButtonState extends State<MultiChoiceButton> {
  List<MultiChoiceButtonItem> get items => widget.items;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialValue >= items.length
        ? 0
        : widget.initialValue;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    widget.onChanged?.call(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items
          .map(
            (item) => OutlinedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = items.indexOf(item);
                  item.onSelected?.call();
                });
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.horizontal(
                    start: items.first == item ? Radius.circular(100) : null,
                    end: items.last == item ? Radius.circular(100) : null,
                  ),
                ),
                backgroundColor: items.indexOf(item) == selectedIndex
                    ? widget.selectedBackgroundColor ??
                          Theme.of(context).colorScheme.primary
                    : widget.unselectedBackgroundColor ??
                          Theme.of(context).colorScheme.onPrimary,
                foregroundColor: items.indexOf(item) == selectedIndex
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
}

class MultiChoiceButtonItem {
  MultiChoiceButtonItem({this.child, this.onSelected});
  final Widget? child;
  final void Function()? onSelected;
}
