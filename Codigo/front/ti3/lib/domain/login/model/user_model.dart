import '../../../context/current_user.dart';

class UserModel {
  String? code;
  String? name;
  String? password;
  UserTypeEnum? type;

  UserModel({
    this.code,
    this.name, 
    this.password, 
    this.type,
  });

  UserModel.fromData(Map<String, dynamic> map) {
    code = map['code'];
    name = map['name'];
    password = map['password'];
    type = UserTypeEnum.values.firstWhere((element) => element.name == map['type']);
  }
}