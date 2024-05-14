import 'package:ti3/domain/classroom/classroom_model.dart';

extension ClassroomDTO on ClassroomModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['name'] = name;
    map['students'] = [];
    map['teachers'] = [];

    return map;
  }

  static List<ClassroomModel> fromListJSON(List<dynamic> json) {
    return json.map((e) => fromJSON(e)).toList();
  }

  static ClassroomModel fromJSON(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final students = json['students'];
    final teachers = json['teachers'];

    return ClassroomModel(
      id: id,
      name: name,
      students: students,
      teachers: teachers,
    );
  }
}