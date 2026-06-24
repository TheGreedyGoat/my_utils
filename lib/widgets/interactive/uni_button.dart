import 'package:flutter/material.dart';

class UniButton extends StatefulWidget {
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
  State<UniButton> createState() => _UniButtonState();
}

class _UniButtonState extends State<UniButton> {
  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() => switch (widget.buttonPreset) {
    ButtonPreset.elevated => ElevatedButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: widget.style,
      child: widget.child,
    ),
    ButtonPreset.outlined => OutlinedButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: widget.style,
      child: widget.child,
    ),
    ButtonPreset.text => TextButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: widget.style,
      child: widget.child,
    ),
    ButtonPreset.icon => IconButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      style: widget.style,
      icon: widget.child,
    ),
  };
}

enum ButtonPreset { elevated, outlined, text, icon }
