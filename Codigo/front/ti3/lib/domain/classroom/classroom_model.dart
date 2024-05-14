import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';

class ClassroomModel {
  int? id;
  String? name;
  List<Student>? students;
  List<Teacher>? teachers;

  ClassroomModel({
    this.id,
    this.name,
    this.students,
    this.teachers,
  });

  static ClassroomModel fromJson(Map<String, dynamic> json) {
    return ClassroomModel(
      id: json['id'] as int,
      name: json['name'] as String,
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'students': students?.map((student) => student.toJson()).toList(),
      'teachers': teachers?.map((teacher) => teacher.toJson()).toList(),
    };
  }
}
