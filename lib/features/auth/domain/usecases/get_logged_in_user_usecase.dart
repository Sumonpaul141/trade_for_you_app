import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';
import 'package:trade_for_you_app/features/auth/domain/repositories/auth_repository.dart';

class GetLoggedInUserUsecase {
  final AuthRepository _authRepository;
  const GetLoggedInUserUsecase(this._authRepository);

  UserModel? call() {
    return _authRepository.getLoggedInUser();
  }
}
