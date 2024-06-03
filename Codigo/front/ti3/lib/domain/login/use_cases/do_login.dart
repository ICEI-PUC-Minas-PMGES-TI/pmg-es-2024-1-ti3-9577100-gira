import 'package:ti3/domain/login/model/user_model.dart';
import 'package:ti3/domain/login/repository/login_repository.dart';

import '../../utils/result.dart';

class DoLogin {
  final LoginRepository _repository;

  DoLogin(this._repository);

  Future<Result<UserModel, Exception>> call(String code, String password) async => await _repository.login(code, password);
}
