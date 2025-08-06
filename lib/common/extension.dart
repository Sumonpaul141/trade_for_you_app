import 'enums.dart';

extension OrderSideX on OrderSide {
  String get name {
    return toString().split(".").last.toUpperCase();
  }

  String get ddValue {
    switch (this) {
      case OrderSide.long:
        return "BUY";
      case OrderSide.short:
        return "SELL";
    }
  }
}

extension UnitTypeX on UnitType {
  String get ddValue {
    switch (this) {
      case UnitType.usdt:
        return "USDT";
      case UnitType.btc:
        return "BTC";
    }
  }
}
