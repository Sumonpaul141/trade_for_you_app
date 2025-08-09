import 'package:trade_for_you_app/common/api_endpoints.dart';
import 'package:trade_for_you_app/core/error/app_exception.dart';
import 'package:trade_for_you_app/core/network/api_client.dart';
import 'package:trade_for_you_app/features/order/data/models/cancel_response_model.dart';
import 'package:trade_for_you_app/features/order/data/models/order_response_model.dart';
import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';

abstract class TradeRemoteDataSource {
  Future<List<PairModel>> getPairs();
  Future<List<OrderResponseModel>> placeOrder(Map<String, dynamic> orderData);
  Future<List<CancelResponseModel>> cancelOrder(int pairId);
}

class TradeRemoteDataSourceImpl implements TradeRemoteDataSource {
  final ApiClient _apiClient;

  TradeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<PairModel>> getPairs() async {
    final response = await _apiClient.get<List<PairModel>>(
      ApiEndpoints.getPairs,
      fromJsonT:
          (data) => (data as List).map((e) => PairModel.fromMap(e)).toList(),
    );
    return response.data ?? [];
  }

  @override
  Future<List<OrderResponseModel>> placeOrder(
    Map<String, dynamic> orderData,
  ) async {
    final response = await _apiClient.post<List<OrderResponseModel>>(
      ApiEndpoints.placeOrder,
      data: orderData,
      fromJsonT: (val) {
        final list = val as List<dynamic>;
        return list.map((e) => OrderResponseModel.fromJson(e)).toList();
      },
    );

    if (response.data != null) {
      return response.data!;
    }

    throw AppException("Invalid response: No order results found");
  }

  @override
  Future<List<CancelResponseModel>> cancelOrder(int pairId) async {
    final response = await _apiClient.patch<List<CancelResponseModel>>(
      ApiEndpoints.cancelOrder,
      data: {'pairId': pairId},
      fromJsonT: (val) {
        if (val is List) {
          return val.map((e) => CancelResponseModel.fromJson(e)).toList();
        }
        return [];
      },
    );

    if (response.data != null) {
      return response.data!;
    }
    throw AppException("Invalid response: No order results found");
  }
}
