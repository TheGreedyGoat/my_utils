import 'package:flutter/material.dart';

class MultiChoiceButton extends StatefulWidget {
  const MultiChoiceButton({
    this.onChanged,
    required this.items,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedForegroundColor,
    this.selectedForegroundColor,
    super.key,
  });
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
                    ? widget.selectedBackgroundColor ?? Colors.black
                    : widget.unselectedBackgroundColor ?? Colors.white,
                foregroundColor: items.indexOf(item) == selectedIndex
                    ? widget.selectedForegroundColor ?? Colors.white
                    : widget.selectedForegroundColor ?? Colors.black,
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
