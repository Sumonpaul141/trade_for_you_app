import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/get_pairs_use_cases.dart';

part 'pair_state.dart';

class PairCubit extends Cubit<PairState> {
  final GetPairUseCases _getPairUseCases;

  PairCubit(this._getPairUseCases) : super(PairState(pairs: []));

  Future<void> getPairs() async {
    var pairs = await _getPairUseCases.call();
    emit(state.copyWith(pairs: pairs));
  }
}
