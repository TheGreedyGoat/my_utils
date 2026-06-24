import 'package:flutter/material.dart';

class UniButton extends StatelessWidget {
  const UniButton({
    required this.buttonPreset,
    required this.onPressed,
    required this.child,

    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  final ButtonPreset buttonPreset;
  final Widget child;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;

  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() => switch (buttonPreset) {
    ButtonPreset.elevated => ElevatedButton(
      onPressed: onPressed,
      child: child,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
    ),
    ButtonPreset.outlined => OutlinedButton(
      onPressed: onPressed,
      child: child,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
    ),
    ButtonPreset.text => TextButton(
      onPressed: onPressed,
      child: child,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
    ),
    ButtonPreset.icon => IconButton(
      onPressed: onPressed,
      icon: child,
      onLongPress: onLongPress,
      onHover: onHover,
    ),
  };
}

enum ButtonPreset { elevated, outlined, text, icon }
