import 'package:trade_for_you_app/features/order/data/data_source/trade_remote_data_source.dart';
import 'package:trade_for_you_app/features/order/data/models/cancel_response_model.dart';
import 'package:trade_for_you_app/features/order/data/models/order_response_model.dart';
import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';

abstract class TradeRepository {
  Future<List<PairModel>> getPairs();
  Future<List<OrderResponseModel>> placeOrder(Map<String, dynamic> orderData);
  Future<List<CancelResponseModel>> cancelOrder(int pairId);
}

class TradeRepositoryImpl extends TradeRepository {
  final TradeRemoteDataSource _tradeRemoteDataSource;
  TradeRepositoryImpl(this._tradeRemoteDataSource);

  @override
  Future<List<PairModel>> getPairs() {
    return _tradeRemoteDataSource.getPairs();
  }

  @override
  Future<List<OrderResponseModel>> placeOrder(Map<String, dynamic> orderData) {
    return _tradeRemoteDataSource.placeOrder(orderData);
  }

  @override
  Future<List<CancelResponseModel>> cancelOrder(int pairId) {
    return _tradeRemoteDataSource.cancelOrder(pairId);
  }
}
