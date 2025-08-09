import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/features/order/data/models/cancel_response_model.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/cancel_order_use_case.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  final CancelOrderUseCase _cancelOrderUseCase;
  CancelOrderCubit(this._cancelOrderUseCase) : super(CancelOrderState());

  selectPairId(int pairId) {
    emit(state.copyWith(selectedPairId: pairId));
  }

  cancelOrder() async {
    emit(state.copyWith(cancelOrderEventCallResult: EventCallResult.loading));
    var pairId = state.selectedPairId ?? 0;
    if (pairId > 0) {
      var res = await _cancelOrderUseCase.call(pairId);
      emit(
        state.copyWith(
          cancelOrderEventCallResult: EventCallResult.success,
          cancelResponseModel: res,
        ),
      );
    } else {
      emit(
        state.copyWith(
          errorText: "Pair cannot be empty",
          cancelOrderEventCallResult: EventCallResult.error,
        ),
      );
    }
    emit(state.copyWith(cancelOrderEventCallResult: EventCallResult.initial));
  }
}
