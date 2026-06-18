import 'package:flutter/material.dart';

class ProcessIndicatorDialogWidget extends StatelessWidget {
  const ProcessIndicatorDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      height: 50.0,
      child: const CircularProgressIndicator(),
    );
  }
}

const Dialog ProcessIndicatorDialog = Dialog(
  child: ProcessIndicatorDialogWidget(),
);

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
