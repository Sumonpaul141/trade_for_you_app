part of 'auth_cubit.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}
