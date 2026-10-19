import 'package:riverpod/riverpod.dart';

/// An extension of riverpod's [Notifier] with some precooked functions
abstract class ExtendedNotifier<StateT> extends Notifier<StateT> {
  /// A general way to update the state.
  ///
  /// standard Usage:
  ///
  /// - use [getValue] to get the original value from the current state.
  /// - use [processValue] to specify how to calc the new value
  /// - use [updateState] to specify how to update the state based on the new value
  ///
  /// Example with the state representing some counter to be incremented:
  ///
  /// ```dart
  /// void incrementCounter(){
  ///   ref.read(refCounter.notifier).updateStateValue<int>(
  ///     getValue: (state) => state.counterValue,
  ///     processValue: (oldValue) => oldValue + 1,
  ///     updateState: (newValue, oldState) =>
  ///         state.copyWith(counterValue: newValue),
  ///   );
  /// }
  /// ```
  ///
  ///
  void updateStateValue<ValueT>({
    required ValueT Function(StateT state) getValue,
    required ValueT Function(ValueT oldValue) processValue,
    required StateT Function(ValueT newValue, StateT oldState) updateState,
  }) {
    final oldValue = getValue(state);
    final newValue = processValue(oldValue);
    state = updateState(newValue, state);
  }

  /// Sets the state to a new value
  void set(StateT newState) => state = newState;
}
