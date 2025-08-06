part of 'pair_cubit.dart';

class PairState extends Equatable {
  final List<PairModel> pairs;

  const PairState({required this.pairs});

  PairState copyWith({List<PairModel>? pairs}) {
    return PairState(pairs: pairs ?? this.pairs);
  }

  @override
  List<Object> get props => [pairs];
}
