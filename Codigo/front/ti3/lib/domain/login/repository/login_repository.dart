import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ti3/domain/login/model/user_model.dart';
import 'package:ti3/shared/statics/endpoints.dart';
import '../../utils/result.dart';

abstract class LoginRepository {
  final String baseUrl = Endpoints.baseUrl;
  final List<String> loginEndpoints = [
    'administrator/login',
    'parents/login',
    'teacher/login',
  ];

  Future<Result<UserModel, Exception>> login(String username, String password) async {
    try {
      for (String endpoint in loginEndpoints) {
        final result = await _checkCredentials(baseUrl + endpoint, username, password);
        if (result != null) {
          return Result.success(result);
        }
      }
      return Result.failure(Exception('O usuário não existe nas tabelas.'));
    } catch (e) {
      return Result.failure(Exception('Erro durante execução: $e'));
    }
  }

  Future<UserModel?> _checkCredentials(String url, String username, String password) async {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['username'] == username && data['password'] == password) {
        return UserModel.fromData(data);
      }
    }

    return null;
  }
}
