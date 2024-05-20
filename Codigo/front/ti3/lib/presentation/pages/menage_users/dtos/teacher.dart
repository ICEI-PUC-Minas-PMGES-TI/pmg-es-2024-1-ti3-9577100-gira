import 'dart:convert';
import 'package:ti3/domain/classroom/classroom_model.dart';

class Teacher {
  final int id;
  final String name;
  final String password;
  final String type;
  final List<ClassroomModel> schoolClasses; 
  final dynamic validPass;
  final List<dynamic> likedNews;

  Teacher({
    required this.id,
    required this.name,
    required this.password,
    required this.type,
    required this.schoolClasses,
    required this.validPass,
    required this.likedNews,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      type: json['type'],
      schoolClasses: (json['schoolClasses'] as List<dynamic>)
          .map((e) => ClassroomModel.fromJson(e as Map<String, dynamic>))
          .toList(), 
      validPass: json['validPass'],
      likedNews: json['likedNews'],
    );
  }

  factory Teacher.fromJsonString(String jsonString) {
    return Teacher.fromJson(json.decode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'type': type,
      'schoolClasses': schoolClasses.map((classroom) => classroom.toJson()).toList(),
      'validPass': validPass,
      'likedNews': likedNews,
    };
  }

  String toJsonString() {
    return json.encode(toJson());
  }
}
