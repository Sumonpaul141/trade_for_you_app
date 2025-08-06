import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/enums.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit() : super(CancelOrderState());

  selectPairId(int pairId) {
    emit(state.copyWith(selectedPairId: pairId));
  }

  cancelOrder() async {
    emit(state.copyWith(cancelOrderEventCallResult: EventCallResult.loading));
    var pairId = state.selectedPairId ?? 0;
    if (pairId > 0) {
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(cancelOrderEventCallResult: EventCallResult.success));
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
