
import 'package:ti3/data/login/datasource/login_datasource.dart';
import 'package:ti3/data/login/dto/user_dto.dart';
import 'package:ti3/data/utils/base_repository.dart';
import 'package:ti3/domain/login/model/user_model.dart';
import 'package:ti3/domain/login/repository/login_repository.dart';

import '../../../domain/utils/result.dart';

class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImpl(this._datasource);

  @override
  Future<Result<UserModel, Exception>> login(String username, String password) async {
    Map<String, dynamic> map = {};

    map['username'] = username;
    map['password'] = password;

    try {
      final response = await _datasource.login(map);
      final result = UserDto.fromJSON(response);
      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }
}