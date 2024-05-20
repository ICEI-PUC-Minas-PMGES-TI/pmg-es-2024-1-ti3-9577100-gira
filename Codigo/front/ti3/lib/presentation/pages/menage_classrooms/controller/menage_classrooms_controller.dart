import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/domain/classroom/repository/menage_classrooms_repository.dart';

class MenageClassroomsController {
  final ClassroomRepository _classroomService = ClassroomRepository();

  Future<List<ClassroomModel>> fetchClassrooms() async {
    try {
      return await _classroomService.fetchClassrooms();
    } catch (e) {
      print('Error fetching classrooms: $e');
      return [];
    }
  }
}
