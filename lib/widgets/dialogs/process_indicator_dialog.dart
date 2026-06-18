import 'package:flutter/material.dart';

class ProcessIndicatorDialogWidget extends StatelessWidget {
  const ProcessIndicatorDialogWidget({
    required this.dialogSize,
    this.indicatorSizePercentage = 0.5,
    super.key,
  });
  final double dialogSize;
  final double indicatorSizePercentage;
  @override
  Widget build(BuildContext context) {
    assert(indicatorSizePercentage < 1, 'value hast to be from (0, 1)');
    return SizedBox(
      width: dialogSize,
      child: Padding(
        padding: EdgeInsets.all(dialogSize * indicatorSizePercentage),
        child: const AspectRatio(
          aspectRatio: 1.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Dialog processIndicatorDialog(double dialogSize) =>
    Dialog(child: ProcessIndicatorDialogWidget(dialogSize: dialogSize));

Future<void> showProcessIndicatorDialaog(
  double dialogSize,
  BuildContext context,
  Future<void> close,
) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => processIndicatorDialog(dialogSize),
  );

  await close;
  Navigator.pop(context);
}
