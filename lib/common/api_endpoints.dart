class ApiEndpoints {
  static const String baseUrl = "https://api.trade4you.dev";
  // static const String baseUrl = "http://192.168.10.233:5000";

  static const String login = "$baseUrl/api/auth/login";
  static const String getPairs = "$baseUrl/api/setup/pair";
  static const String placeOrder = "$baseUrl/api/trade/place-future-order";
  static const String cancelOrder =
      "$baseUrl/api/trade/cancel-all-future-order";
}
