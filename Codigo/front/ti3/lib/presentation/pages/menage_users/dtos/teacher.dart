import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';

class Teacher {
  String? id;
  String? name;
  UserTypeEnum? type;
  List<ClassroomModel>? schoolClasses;

  Teacher({
    this.id,
    this.name,
    this.type,
    this.schoolClasses,
  });

  static Teacher fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] != null
          ? UserTypeEnum.values.firstWhere(
              (e) => e.toString().split('.').last == json['type'])
          : null,
      schoolClasses: (json['schoolClasses'] as List<dynamic>?)
          ?.map((e) => ClassroomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
