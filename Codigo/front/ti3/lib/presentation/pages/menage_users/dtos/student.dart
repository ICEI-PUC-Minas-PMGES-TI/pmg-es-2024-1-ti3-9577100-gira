import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/parent.dart';

class Student {
  int? id;
  String? name;
  int? registration;
  UserTypeEnum? type;
  ClassroomModel? schoolClass;
  Parent? parents;

  Student({
    this.id,
    this.name,
    this.registration,
    this.type,
    this.schoolClass,
    this.parents,
  });

  static Student fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int?,
      name: json['name'] as String?,
      registration: json['registration'] as int?,
      type: json['type'] != null
          ? UserTypeEnum.values.firstWhere(
              (e) => e.toString().split('.').last == json['type'])
          : null,
      schoolClass: json['schoolClass'] != null
          ? ClassroomModel.fromJson(json['schoolClass'] as Map<String, dynamic>)
          : null,
      parents: json['parents'] != null
          ? Parent.fromJson(json['parents'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registration': registration,
      'type': type?.toString().split('.').last,
      'schoolClass': schoolClass?.toJson(),
      'parents': parents?.toJson(),
    };
  }
}
