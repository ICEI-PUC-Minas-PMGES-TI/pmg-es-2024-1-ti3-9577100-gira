import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/shared/statics/endpoints.dart';

class ClassroomRepository {
  final String baseUrl = '${Endpoints.baseUrl}classroom';

  Future<List<ClassroomModel>> fetchClassrooms() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ClassroomModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classrooms');
    }
  }
}
