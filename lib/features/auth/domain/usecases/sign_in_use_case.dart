import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';
import 'package:trade_for_you_app/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepository;
  const SignInUseCase(this._authRepository);

  Future<UserModel> call(String username, String password) {
    return _authRepository.login(username, password);
  }
}
