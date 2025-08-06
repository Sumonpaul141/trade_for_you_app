import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/get_logged_in_user_usecase.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/logout_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetLoggedInUserUsecase _getLoggedInUserUsecase;
  final LogoutUseCase _logoutUseCase;
  AuthCubit(this._logoutUseCase, this._getLoggedInUserUsecase)
    : super(AuthInitial());

  void setAuthenticated(UserModel user) {
    emit(Authenticated(user));
  }

  Future<void> logout() async {
    await _logoutUseCase.call();
    emit(Unauthenticated());
  }

  Future<void> getLoggedInUser() async {
    await Future.delayed(Duration(milliseconds: 500));
    final user = _getLoggedInUserUsecase.call();
    if (user != null) {
      setAuthenticated(user);
    } else {
      emit(Unauthenticated());
    }
  }
}
