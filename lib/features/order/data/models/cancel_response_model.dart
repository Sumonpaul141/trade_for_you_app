class CancelResponseModel {
  final String username;
  final int userId;
  final bool openOrderCancelStatus;
  final bool positionCancelStatus;
  final List<String> errors;

  CancelResponseModel({
    required this.username,
    required this.userId,
    required this.openOrderCancelStatus,
    required this.positionCancelStatus,
    required this.errors,
  });

  factory CancelResponseModel.fromJson(Map<String, dynamic> json) {
    return CancelResponseModel(
      username: json['username'],
      userId: json['userId'],
      openOrderCancelStatus: json['openOrderCancelStatus'],
      positionCancelStatus: json['positionCancelStatus'],
      errors: List<String>.from(json['errors'] ?? []),
    );
  }
}
