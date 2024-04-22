import 'package:ti3/domain/login/model/user_model.dart';

import '../../../context/current_user.dart';

extension UserDto on UserModel {
  static UserModel fromJSON(Map<String, dynamic> json) {
    final user = json['user'];
    final name = user['name'];
    final password = user['password'];
    final type = UserTypeEnum.values.firstWhere(
      (element) => element.name.toUpperCase() == json['userType'].toUpperCase(),
      orElse: () => UserTypeEnum.undefined,
    );

    return UserModel(
      name: name,
      password: password,
      type: type,
    );
  }
}