import 'package:trade_for_you_app/features/order/data/models/order_response_model.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/trade_repository.dart';

class PlaceOrderUseCase {
  final TradeRepository tradeRepository;

  PlaceOrderUseCase(this.tradeRepository);

  Future<List<OrderResponseModel>> call(Map<String, dynamic> orderData) {
    return tradeRepository.placeOrder(orderData);
  }
}
