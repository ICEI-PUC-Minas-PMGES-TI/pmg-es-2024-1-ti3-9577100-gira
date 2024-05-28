import 'package:get/get.dart';
import 'package:ti3/domain/student/repository/student_repository.dart';
import 'package:ti3/domain/teatcher/repository/teacher_repository.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';

class ManageUsersController extends GetxController {
  final TeacherRepository _teacherRepository = TeacherRepository();
  final StudentRepository _studentRepository = StudentRepository();

  RxList<Teacher> teachers = <Teacher>[].obs;
  RxList<Student> students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeachers();
  }

  Future<void> deleteProfessor(String id) async {
    try {
      
    } catch (e) {
      print('Erro');
    }
  }

  Future<List<Teacher>> fetchTeachers() async {
    try {
      List<Teacher> fetchedTeachers = await _teacherRepository.getAllTeachers();
      teachers.assignAll(fetchedTeachers);
      return fetchedTeachers;
    } catch (error) {
      print('Erro ao obter professores: $error');
      return teachers;
    }
  }

  Future<List<Student>> fetchStudents() async {
    try {
      List<Student> fetchedStudents = await _studentRepository.getAllStudents();
      students.assignAll(fetchedStudents);
      return fetchedStudents;
    } catch (error) {
      print('Erro ao obter alunos: $error');
      return students;
    }
  }
}

