class PairModel {
  final int id;
  final String symbol;

  PairModel({required this.id, required this.symbol});

  Map<String, dynamic> toMap() {
    return {'id': id, 'symbol': symbol};
  }

  factory PairModel.fromMap(Map<String, dynamic> map) {
    return PairModel(id: map['id'] as int, symbol: map['symbol'] as String);
  }
}
