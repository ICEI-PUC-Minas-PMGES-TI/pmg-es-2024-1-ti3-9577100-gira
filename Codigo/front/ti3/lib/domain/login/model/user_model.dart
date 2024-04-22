import '../../../context/current_user.dart';

class UserModel {
  String? name;
  String? password;
  UserTypeEnum? type;

  UserModel({this.name, this.password, this.type});


  UserModel.fromData(Map<String, dynamic> map) {
    name = map['name'];
    password = map['password'];
    type = UserTypeEnum.values
        .firstWhere((element) => element.name == map['type']);

  }
}