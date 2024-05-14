import 'package:ti3/domain/login/model/user_model.dart';
import 'package:ti3/domain/login/repository/login_repository.dart';

import '../../utils/result.dart';

class DoLogin {
  final LoginRepository _repository;

  DoLogin(this._repository);

  Future<Result<UserModel, Exception>> call(String username, String password) async {
    var resp = await _repository.login(username, password);
    return resp;
  }   
}
