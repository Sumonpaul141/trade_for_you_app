import 'package:trade_for_you_app/common/api_endpoints.dart';
import 'package:trade_for_you_app/core/network/api_client.dart';
import 'package:trade_for_you_app/features/order/data/models/pair_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<PairModel>> getPairs();
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  final ApiClient _apiClient;
  OrderRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<PairModel>> getPairs() async {
    var response = await _apiClient.get(ApiEndpoints.getPairs);
    if (response.statusCode == 200 && response.data["data"] != null) {
      return List<PairModel>.from(
        response.data["data"].map((x) => PairModel.fromMap(x)),
      );
    }
    return [];
  }
}
