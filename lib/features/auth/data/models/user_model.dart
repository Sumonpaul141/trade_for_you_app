class UserModel {
  final String token;
  final String name;
  final String email;
  final String username;
  final double totalEarnings;
  final double totalWithdraw;
  final double depositBalance;
  final double earningBalance;
  final String status;
  final String role;
  final DateTime joinedDate;

  UserModel({
    required this.token,
    required this.name,
    required this.email,
    required this.username,
    required this.totalEarnings,
    required this.totalWithdraw,
    required this.depositBalance,
    required this.earningBalance,
    required this.status,
    required this.role,
    required this.joinedDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      totalWithdraw: (json['totalWithdraw'] as num).toDouble(),
      depositBalance: (json['depositBalance'] as num).toDouble(),
      earningBalance: (json['earningBalance'] as num).toDouble(),
      status: json['status'],
      role: json['role'],
      joinedDate: DateTime.parse(json['joinedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'email': email,
      'username': username,
      'totalEarnings': totalEarnings,
      'totalWithdraw': totalWithdraw,
      'depositBalance': depositBalance,
      'earningBalance': earningBalance,
      'status': status,
      'role': role,
      'joinedDate': joinedDate.toIso8601String(),
    };
  }
}
