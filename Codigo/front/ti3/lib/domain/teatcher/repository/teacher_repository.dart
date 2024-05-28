import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';
import 'package:ti3/shared/statics/endpoints.dart';

class TeacherRepository {
  final String baseUrl = '${Endpoints.baseUrl}teacher';

  Future<void> deleteTeatcher(String id) async {
    
  }

  Future<List<Teacher>> getAllTeachers() async {
    try {
      print(baseUrl);
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<Teacher> teachers = responseData.map((json) => Teacher.fromJson(json)).toList();
        return teachers;
      } else {
        throw Exception('Falha ao carregar Professores.');
      }
    } catch (error) {
      throw Exception('Falha ao carregar Professores: $error');
    }
  }
}
