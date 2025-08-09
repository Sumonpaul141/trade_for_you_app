class OrderResponseModel {
  final bool success;
  final int userId;
  final String username;
  final String status;
  final String message;
  final int orderId;

  OrderResponseModel({
    required this.success,
    required this.userId,
    required this.username,
    required this.status,
    required this.message,
    required this.orderId,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      success: json['success'] ?? false,
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      orderId: json['orderId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "userId": userId,
      "username": username,
      "status": status,
      "message": message,
      "orderId": orderId,
    };
  }
}

class PlaceOrderResponse {
  final bool success;
  final String message;
  final List<OrderResponseModel> data;

  PlaceOrderResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>? ?? [])
              .map((item) => OrderResponseModel.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
    };
  }
}
