import 'package:flutter/material.dart';

class MultiChoiceButtonItem<T> {
  MultiChoiceButtonItem({
    this.initiallySelected = false,
    this.child,
    required this.value,
  });
  final bool initiallySelected;
  final T value;
  final Widget? child;
}
