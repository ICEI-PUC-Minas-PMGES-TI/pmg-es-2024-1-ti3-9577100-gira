import 'package:get/get.dart';
import 'package:ti3/domain/teatcher/repository/teacher_repository.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';

class ManageUsersController extends GetxController {
  final TeacherRepository _teacherRepository = TeacherRepository();

  RxList<Teacher> teachers = <Teacher>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeachers();
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
}

