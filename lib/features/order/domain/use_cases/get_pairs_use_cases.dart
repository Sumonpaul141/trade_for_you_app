import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/order_repository.dart';

class GetPairUseCases {
  final OrderRepository orderRepository;

  GetPairUseCases(this.orderRepository);

  Future<List<PairModel>> call() {
    return orderRepository.getPairs();
  }
}
