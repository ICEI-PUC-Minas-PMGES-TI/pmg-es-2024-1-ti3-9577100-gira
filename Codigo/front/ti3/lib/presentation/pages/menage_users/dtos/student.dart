import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';

class Student {
  final String name;
  final String image;
  final List<Teacher> teachers;

  Student({
    required this.name,
    required this.image,
    required this.teachers,
  });
}