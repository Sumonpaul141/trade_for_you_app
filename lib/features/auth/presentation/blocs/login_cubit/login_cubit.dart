import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/core/error/app_exception.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase _signInUseCase;
  final AuthCubit _authCubit;
  LoginCubit(this._signInUseCase, this._authCubit) : super(LoginState());

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: EventCallResult.loading));
    try {
      final user = await _signInUseCase.call(username, password);
      _authCubit.setAuthenticated(user);
      emit(state.copyWith(status: EventCallResult.success, user: user));
    } catch (e) {
      var msg = "";
      if (e is AppException) {
        msg = e.message;
      } else {
        msg = e.toString();
      }
      emit(state.copyWith(status: EventCallResult.error, error: msg));
    }
    emit(state.copyWith(status: EventCallResult.initial, error: ""));
  }
}
