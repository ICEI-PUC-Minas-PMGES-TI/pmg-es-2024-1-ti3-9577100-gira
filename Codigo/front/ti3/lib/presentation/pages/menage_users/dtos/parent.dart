import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/news/model/news_model.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';

class Parent {
  int? id;
  String? name;
  UserTypeEnum? type;
  List<Student>? students;
  List<NewsModel>? likedNews;

  Parent({
    this.id,
    this.name,
    this.type,
    this.students,
    this.likedNews,
  });

  static Parent fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'] as int?,
      name: json['name'] as String?,
      type: json['type'] != null
          ? UserTypeEnum.values.firstWhere(
              (e) => e.toString().split('.').last == json['type'])
          : null,
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedNews: (json['likedNews'] as List<dynamic>?)
          ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type?.toString().split('.').last,
      'students': students?.map((student) => student.toJson()).toList(),
      'likedNews': likedNews?.map((news) => news.toJson()).toList(),
    };
  }
}
