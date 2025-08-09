import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/features/order/data/models/order_response_model.dart';
import 'package:trade_for_you_app/features/order/domain/entities/place_order_request_entity.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/place_order_use_case.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final PlaceOrderUseCase _placeOrderUseCase;
  PlaceOrderCubit(this._placeOrderUseCase) : super(PlaceOrderState());

  clearAll() {
    emit(state.copyWith(placeOrderRequestEntity: PlaceOrderRequestEntity()));
  }

  Future<void> selectPairId(int pairId) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          pairId: pairId,
        ),
      ),
    );
  }

  Future<void> selectSide(String side) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          side: side,
        ),
      ),
    );
  }

  Future<void> selectUnitType(String unitType) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          unitType: unitType,
        ),
      ),
    );
  }

  Future<void> setLeverage(String leverage) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          leverage: int.tryParse(leverage) ?? 1,
        ),
      ),
    );
  }

  Future<void> selectPercent(String percent) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          percent: double.tryParse(percent),
        ),
      ),
    );
  }

  Future<void> setTakeProfit(String takeProfit) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          takeProfit: double.tryParse(takeProfit),
        ),
      ),
    );
  }

  Future<void> setStopLoss(String stopLoss) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          stopLoss: double.tryParse(stopLoss),
        ),
      ),
    );
  }

  Future<void> setUsername(String username) async {
    emit(
      state.copyWith(
        placeOrderRequestEntity: state.placeOrderRequestEntity.copyWith(
          username: username,
        ),
      ),
    );
  }

  placeOrder() async {
    emit(state.copyWith(placeOrderCallResult: EventCallResult.loading));
    try {
      var res = await _placeOrderUseCase.call(
        state.placeOrderRequestEntity.toMap(),
      );
      emit(
        state.copyWith(
          placeOrderResponse: res,
          placeOrderCallResult: EventCallResult.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          placeOrderResponse: [],
          placeOrderCallResult: EventCallResult.error,
          error: e.toString(),
        ),
      );
    }
    emit(state.copyWith(placeOrderCallResult: EventCallResult.initial));
  }
}
