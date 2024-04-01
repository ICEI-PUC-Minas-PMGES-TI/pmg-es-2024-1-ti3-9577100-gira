import 'package:ti3/context/current_user.dart';

class UserDTO {
  String? id;
  String? code;
  String? password;
  UserTypeEnum? type;

  UserDTO({
    this.id,
    this.code,
    this.password,
    this.type,
  });
}