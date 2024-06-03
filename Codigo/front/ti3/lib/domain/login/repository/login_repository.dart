import 'package:ti3/domain/login/model/user_model.dart';
import '../../utils/result.dart';

abstract class LoginRepository {
  Future<Result<UserModel, Exception>> login(String code, String password);
}
