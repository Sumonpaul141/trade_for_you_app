part of 'place_order_cubit.dart';

class PlaceOrderState extends Equatable {
  final EventCallResult placeOrderCallResult;
  final PlaceOrderRequestEntity placeOrderRequestEntity;
  final String error;

  const PlaceOrderState({
    this.placeOrderCallResult = EventCallResult.initial,
    this.error = "",
    this.placeOrderRequestEntity = const PlaceOrderRequestEntity(),
  });

  PlaceOrderState copyWith({
    EventCallResult? placeOrderCallResult,
    PlaceOrderRequestEntity? placeOrderRequestEntity,
    String? error,
  }) {
    return PlaceOrderState(
      placeOrderCallResult: placeOrderCallResult ?? this.placeOrderCallResult,
      placeOrderRequestEntity:
          placeOrderRequestEntity ?? this.placeOrderRequestEntity,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    placeOrderCallResult,
    placeOrderRequestEntity,
    error,
  ];
}
