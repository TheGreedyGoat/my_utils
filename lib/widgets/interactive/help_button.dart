import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  final double size;
  final Widget? child;
  const HelpButton({super.key, this.child, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              enabled: false,
              child: child,
            ),
          ];
        },
        child: const Icon(Icons.help),
      ),
    );
  }
}
