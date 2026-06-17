import 'package:flutter/material.dart';

/// Works like a Switch Widget, but supports tristate (left => false, center => null, right => true)
class TristateSwitch extends StatefulWidget {
  /// Works like a Switch Widget, but supports tristate (left => false, center => null, right => true)
  const TristateSwitch({
    this.iconLeft,
    this.iconCenter,
    this.iconRight,
    this.onChanged,
    this.initialValue = false,
    super.key,
  });

  /// Callback for whenn the switches' value changed
  final void Function(bool? value)? onChanged;

  /// An optional icon to display on the widget's left side aswell as on the handle, if the corresponding option is set
  final Icon? iconLeft;

  /// An optional icon to display on the widget's center aswell as on the handle, if the corresponding option is set
  final Icon? iconCenter;

  /// An optional icon to display on the widget's center aswell as on the handle, if the corresponding option is set
  final Icon? iconRight;

  /// The value the Switch has when the widget is loaded
  final bool initialValue;
  @override
  State<TristateSwitch> createState() => _TristateSwitchState();
}

class _TristateSwitchState extends State<TristateSwitch> {
  bool? value;
  bool isHovered = false;

  static const _long = 85.0;
  static const _short = 35.0;
  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  List<Widget> iconsBackground(BuildContext context) => [
    for (final icon in [widget.iconLeft, widget.iconCenter, widget.iconRight])
      if (icon != null) Icon(size: 15, icon.icon, color: Colors.grey),
  ];

  Widget _handle() => SizedBox(
    width: _short,
    height: _short,
    child: Container(
      padding: EdgeInsets.all(5.0),
      decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: isHovered
            ? const Color.fromARGB(103, 104, 104, 104)
            : Colors.transparent,
      ),
      child: SizedBox.expand(
        child: Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: (switch (value) {
            null => widget.iconCenter,
            true => widget.iconRight,
            false => widget.iconLeft,
          }),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: _long,
          height: _short,
          child: GestureDetector(
            onTap: () {
              setState(() {
                value = value == null
                    ? false
                    : value!
                    ? null
                    : true;
              });
              widget.onChanged?.call(value);
            },
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                SizedBox(
                  width: _long - 5,
                  height: _short - 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1000)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: iconsBackground(context),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: value == null
                      ? MainAxisAlignment.center
                      : (value!
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start),
                  children: [
                    FocusableActionDetector(
                      onShowHoverHighlight: (value) {
                        setState(() {
                          isHovered = value;
                        });
                      },
                      child: _handle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
