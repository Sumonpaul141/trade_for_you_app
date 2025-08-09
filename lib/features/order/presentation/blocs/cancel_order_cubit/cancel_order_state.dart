part of 'cancel_order_cubit.dart';

class CancelOrderState extends Equatable {
  final int? selectedPairId;
  final EventCallResult cancelOrderEventCallResult;
  final List<CancelResponseModel> cancelResponseModel;
  final String errorText;

  const CancelOrderState({
    this.selectedPairId,
    this.cancelOrderEventCallResult = EventCallResult.initial,
    this.errorText = "",
    this.cancelResponseModel = const [],
  });

  CancelOrderState copyWith({
    int? selectedPairId,
    EventCallResult? cancelOrderEventCallResult,
    List<CancelResponseModel>? cancelResponseModel,
    String? errorText,
  }) {
    return CancelOrderState(
      selectedPairId: selectedPairId ?? this.selectedPairId,
      cancelOrderEventCallResult:
          cancelOrderEventCallResult ?? this.cancelOrderEventCallResult,
      cancelResponseModel: cancelResponseModel ?? this.cancelResponseModel,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
    selectedPairId,
    cancelOrderEventCallResult,
    cancelResponseModel,
    errorText,
  ];
}
