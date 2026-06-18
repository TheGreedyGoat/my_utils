import 'package:flutter/material.dart';

class ProcessIndicatorDialogWidget extends StatelessWidget {
  const ProcessIndicatorDialogWidget({required this.size, super.key});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: const AspectRatio(
        aspectRatio: 1.0,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Dialog ProcessIndicatorDialog(double size) =>
    Dialog(child: ProcessIndicatorDialogWidget(size: size));

Future<void> showProcessIndicatorDialaog(
  double size,
  BuildContext context,
  Future<void> close,
) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => ProcessIndicatorDialog(size),
  );

  await close;
  Navigator.pop(context);
}
