import 'package:equatable/equatable.dart';

class PlaceOrderRequestEntity extends Equatable {
  final int? pairId;
  final String? side;
  final String? unitType;
  final int? leverage;
  final double? percent;
  final double? takeProfit;
  final double? stopLoss;
  final String? username;

  const PlaceOrderRequestEntity({
    this.pairId,
    this.side,
    this.unitType,
    this.leverage = 1,
    this.percent = 50,
    this.takeProfit,
    this.stopLoss,
    this.username,
  });

  PlaceOrderRequestEntity copyWith({
    int? pairId,
    String? side,
    String? unitType,
    int? leverage,
    double? percent,
    double? takeProfit,
    double? stopLoss,
    String? username,
  }) {
    return PlaceOrderRequestEntity(
      pairId: pairId ?? this.pairId,
      side: side ?? this.side,
      unitType: unitType ?? this.unitType,
      leverage: leverage ?? this.leverage,
      percent: percent ?? this.percent,
      takeProfit: takeProfit ?? this.takeProfit,
      stopLoss: stopLoss ?? this.stopLoss,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
    pairId,
    side,
    unitType,
    leverage,
    percent,
    takeProfit,
    stopLoss,
    username,
  ];
}
