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
    _currentUserInstance ??= CurrentUser();
    return _currentUserInstance!;
  }

  static void updateCurrentUser(String name, String password) {
    _currentUserInstance ??= CurrentUser();
    _currentUserInstance!.name = name;
    _currentUserInstance!.password = password;
  }
}

enum UserTypeEnum {
  @JsonValue('administrator')
  administrator,
  @JsonValue('teacher')
  teacher,
  @JsonValue('parents')
  parents,
  @JsonValue('student')
  student,
  @JsonValue('classroom')
  classroom,
  @JsonValue('undefined')
  undefined,
}
