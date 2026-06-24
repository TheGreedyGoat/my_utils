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
            onPressed: () {
              print(i);
            },
            child: Text(i.toString()),
          ),

        UniButton(
          buttonPreset: widget.preset,
          onPressed: () {
            print('confirm');
          },
          child: Icon(Icons.send_sharp),
        ),
        UniButton(
          buttonPreset: widget.preset,
          onPressed: () {
            print('0');
          },
          child: Text(0.toString()),
        ),
        UniButton(
          buttonPreset: widget.preset,
          onPressed: () {
            print('delete');
          },
          child: Icon(Icons.backspace_sharp),
        ),
      ],
    );
  }
}
