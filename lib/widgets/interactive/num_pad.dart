import 'package:flutter/material.dart';
import 'package:my_utils/widgets/interactive/uni_button.dart';

class NumPad extends StatefulWidget {
  const NumPad({this.preset = ButtonPreset.elevated, super.key});
  final ButtonPreset preset;
  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        for (int i = 1; i <= 9; i++)
          UniButton(
            buttonPreset: widget.preset,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              print(i);
            },
            child: Text(i.toString()),
          ),
      ],
    );
  }
}
