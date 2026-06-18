import 'package:flutter/material.dart';

class ProcessIndicatorDialogWidget extends StatelessWidget {
  const ProcessIndicatorDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red, child: const LinearProgressIndicator());
  }
}

Dialog ProcessIndicatorDialog = Dialog(child: ProcessIndicatorDialogWidget());

Future<void> showProcessIndicatorDialaog(
  BuildContext context,
  Future<void> close,
) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => ProcessIndicatorDialog,
  );

  await close;
  Navigator.pop(context);
}
