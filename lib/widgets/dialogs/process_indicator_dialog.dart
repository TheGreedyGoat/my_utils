import 'package:flutter/material.dart';

class ProcessIndicatorDialogWidget extends StatelessWidget {
  const ProcessIndicatorDialogWidget({required this.dialogSize, super.key});
  final double dialogSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dialogSize,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Future<void> showProcessIndicatorDialaog(
  BuildContext context,
  double dialogSize,
  Future<void> close,
) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) =>
        Dialog(child: ProcessIndicatorDialogWidget(dialogSize: dialogSize)),
  );

  await close;
  Navigator.pop(context);
}
