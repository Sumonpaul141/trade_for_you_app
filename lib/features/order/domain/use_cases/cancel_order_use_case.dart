import 'package:trade_for_you_app/features/order/data/models/cancel_response_model.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/trade_repository.dart';

class CancelOrderUseCase {
  final TradeRepository tradeRepository;

  CancelOrderUseCase(this.tradeRepository);

  Future<List<CancelResponseModel>> call(pairId) {
    return tradeRepository.cancelOrder(pairId);
  }
}
