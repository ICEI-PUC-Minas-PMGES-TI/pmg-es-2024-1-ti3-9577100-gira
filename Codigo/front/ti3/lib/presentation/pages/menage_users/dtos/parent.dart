import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';

class Parent {
  final String name;
  final String image;
  final List<Student> students;

  Parent({
    required this.name,
    required this.image,
    required this.students,
  });
}