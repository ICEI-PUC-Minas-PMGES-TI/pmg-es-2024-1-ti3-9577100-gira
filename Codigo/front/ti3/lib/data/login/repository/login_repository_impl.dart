import 'package:ti3/data/login/datasource/login_datasource.dart';
import 'package:ti3/data/login/dto/user_dto.dart';
import 'package:ti3/data/utils/base_repository.dart';
import 'package:ti3/domain/login/model/user_model.dart';
import 'package:ti3/domain/login/repository/login_repository.dart';
import 'package:ti3/shared/statics/endpoints.dart';

import '../../../domain/utils/result.dart';

class LoginRepositoryImpl extends BaseRepository implements LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImpl(this._datasource);
      
  @override
  Future<Result<UserModel, Exception>> login(String code, String password) async {
    try {
      Map<String, dynamic> map = {
        'code': code,
        'password': password,
      };

      final response = await _datasource.login(map);

      final result = UserDto.fromJSON(response);

      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }

  // try {
  //     for (String endpoint in loginEndpoints) {
  //       final result = await _checkCredentials(baseUrl + endpoint, username, password);
  //       if (result != null) {
  //         return Result.success(result);
  //       }
  //     }
  //     return Result.failure(Exception('O usuário não existe nas tabelas.'));
  //   } catch (e) {
  //     return Result.failure(Exception('Erro durante execução: $e'));
  //   }
}
