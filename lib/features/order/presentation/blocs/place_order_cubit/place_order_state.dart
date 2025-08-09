part of 'place_order_cubit.dart';

class PlaceOrderState extends Equatable {
  final EventCallResult placeOrderCallResult;
  final PlaceOrderRequestEntity placeOrderRequestEntity;
  final List<OrderResponseModel> placeOrderResponse;
  final String error;

  const PlaceOrderState({
    this.placeOrderCallResult = EventCallResult.initial,
    this.error = "",
    this.placeOrderRequestEntity = const PlaceOrderRequestEntity(),
    this.placeOrderResponse = const [],
  });

  PlaceOrderState copyWith({
    EventCallResult? placeOrderCallResult,
    PlaceOrderRequestEntity? placeOrderRequestEntity,
    List<OrderResponseModel>? placeOrderResponse,
    String? error,
  }) {
    return PlaceOrderState(
      placeOrderCallResult: placeOrderCallResult ?? this.placeOrderCallResult,
      placeOrderRequestEntity:
          placeOrderRequestEntity ?? this.placeOrderRequestEntity,
      placeOrderResponse: placeOrderResponse ?? this.placeOrderResponse,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
    placeOrderCallResult,
    placeOrderRequestEntity,
    placeOrderResponse,
    error,
  ];
}
