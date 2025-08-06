part of 'login_cubit.dart';

class LoginState {
  final EventCallResult status;
  final String? error;
  final UserModel? user;

  LoginState({this.status = EventCallResult.initial, this.error, this.user});

  LoginState copyWith({
    EventCallResult? status,
    String? error,
    UserModel? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error,
      user: user ?? this.user,
    );
  }
}
