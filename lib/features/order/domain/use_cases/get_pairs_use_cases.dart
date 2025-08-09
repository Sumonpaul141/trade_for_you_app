import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/trade_repository.dart';

class GetPairUseCases {
  final TradeRepository tradeRepository;

  GetPairUseCases(this.tradeRepository);

  Future<List<PairModel>> call() {
    return tradeRepository.getPairs();
  }
}
