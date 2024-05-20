import 'package:get/get.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/domain/student/repository/student_repository.dart';
import 'package:ti3/domain/teatcher/repository/teacher_repository.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';

class EditClassroomPageController extends GetxController {
  var isLoading = true.obs;
  var teachers = <Teacher>[].obs;
  var students = <Student>[].obs;

  final ClassroomModel classroom;
  final TeacherRepository teacherRepository = TeacherRepository();
  final StudentRepository studentRepository = StudentRepository();

  EditClassroomPageController(this.classroom);

  @override
  void onInit() {
    super.onInit();
    fetchTeachers();
    fetchStudents();
  }

  Future<List<Teacher>> fetchTeachers() async {
    try {
      isLoading(true);
      var fetchedTeachers = await teacherRepository.getAllTeachers();
      teachers.assignAll(fetchedTeachers);
      return teachers;
    } catch (e) {
      print("Error fetching teachers: $e");
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<List<Student>> fetchStudents() async {
    try {
      isLoading(true);
      var fetchedStudents = await studentRepository.getAllStudents();
      students.assignAll(fetchedStudents);
      return students;
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    } finally {
      isLoading(false);
    }
  }
}
