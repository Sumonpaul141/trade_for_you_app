import 'package:trade_for_you_app/features/order/data/data_source/order_remote_data_source.dart';
import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';

abstract class OrderRepository {
  Future<List<PairModel>> getPairs();
}

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;
  OrderRepositoryImpl(this._orderRemoteDataSource);

  @override
  Future<List<PairModel>> getPairs() {
    return _orderRemoteDataSource.getPairs();
  }
}
