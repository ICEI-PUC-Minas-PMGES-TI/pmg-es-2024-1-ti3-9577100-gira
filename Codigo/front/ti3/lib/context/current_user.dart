import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CurrentUser {
  String? name;
  String? password;
  UserTypeEnum? type;

  static final CurrentUser _instance = CurrentUser._internal();

  factory CurrentUser() {
    return _instance;
  }

  CurrentUser._internal();
}

class CurrentUserManager {
  static CurrentUser? _currentUserInstance;

  static CurrentUser get currentUser {
    if (_currentUserInstance == null) {
      _currentUserInstance = CurrentUser();
    }
    return _currentUserInstance!;
  }

  static void updateCurrentUser(String name, String password) {
    _currentUserInstance ??= CurrentUser();
    _currentUserInstance!.name = name;
    _currentUserInstance!.password = password;
  }
}

enum UserTypeEnum {
  @JsonValue('ADMIN')
  admin,
  @JsonValue('TEACHER')
  teacher,
  @JsonValue('STUDENT')
  student,
  @JsonValue('PARENTS')
  parents,
  @JsonValue('CLASSROOM')
  clasroom,
  @JsonValue('UNDEFINED')
  undefined,
  }
