import 'package:trade_for_you_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _authRepository;
  const LogoutUseCase(this._authRepository);

  Future<void> call() {
    return _authRepository.logout();
  }
}
