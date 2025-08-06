part of 'cancel_order_cubit.dart';

class CancelOrderState extends Equatable {
  final int? selectedPairId;
  final EventCallResult cancelOrderEventCallResult;
  final String errorText;

  const CancelOrderState({
    this.selectedPairId,
    this.cancelOrderEventCallResult = EventCallResult.initial,
    this.errorText = "",
  });

  CancelOrderState copyWith({
    int? selectedPairId,
    EventCallResult? cancelOrderEventCallResult,
    String? errorText,
  }) {
    return CancelOrderState(
      selectedPairId: selectedPairId ?? this.selectedPairId,
      cancelOrderEventCallResult:
          cancelOrderEventCallResult ?? this.cancelOrderEventCallResult,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
    selectedPairId,
    cancelOrderEventCallResult,
    errorText,
  ];
}
