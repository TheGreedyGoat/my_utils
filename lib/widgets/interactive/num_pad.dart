import 'package:flutter/material.dart';
import 'package:my_utils/widgets/interactive/uni_button.dart';

class NumPad extends StatefulWidget {
  const NumPad({this.preset = ButtonPreset.elevated, super.key});
  final ButtonPreset preset;
  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          width: double.infinity,
          child: Container(child: Text(value)),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              for (int i = 1; i <= 9; i++)
                UniButton(
                  buttonPreset: widget.preset,
                  onPressed: () {
                    setState(() {
                      value += i.toString();
                    });
                  },
                  child: Text(i.toString()),
                ),

              UniButton(
                buttonPreset: widget.preset,
                onPressed: () {
                  setState(() {
                    print('confirm');
                  });
                },
                child: Icon(Icons.send_sharp),
              ),
              UniButton(
                buttonPreset: widget.preset,
                onPressed: () {
                  setState(() {
                    print('0');
                  });
                },
                child: Text(0.toString()),
              ),
              UniButton(
                buttonPreset: widget.preset,
                onPressed: () {
                  setState(() {
                    if (value.isNotEmpty) {
                      value = value.substring(0, value.length - 1);
                    }
                  });
                },
                child: Icon(Icons.backspace_sharp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
