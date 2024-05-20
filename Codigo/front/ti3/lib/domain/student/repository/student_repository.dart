import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/shared/statics/endpoints.dart';

class StudentRepository {
  Future<List<Student>> getAllStudents() async {
    try {
      final response = await http.get(Uri.parse('${Endpoints.baseUrl}student'));

      if (response.statusCode == 200) {
        final List<dynamic> studentsJson = json.decode(response.body);
        return studentsJson.map((json) => Student.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar estudantes.');
      }
    } catch (e) {
      print('Falha ao carregar estudantes: $e');
      throw e;
    }
  }

  Future<Student> registerStudent(Student student) async {
    try {
      final response = await http.post(
        Uri.parse('${Endpoints.baseUrl}student'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(student.toJson()),
      );

      if (response.statusCode == 201) {
        return Student.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao criar estudantes');
      }
    } catch (e) {
      print('Falha ao criar estudantes: $e');
      throw e;
    }
  }
}
