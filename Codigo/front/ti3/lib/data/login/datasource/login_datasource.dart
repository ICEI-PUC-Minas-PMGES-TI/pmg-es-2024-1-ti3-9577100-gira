import 'dart:convert';

import 'package:ti3/data/api/api.dart';
import 'package:ti3/domain/api/api_handler.dart';

class LoginDatasource {
  final ApiHandler _client;

  LoginDatasource(this._client);

  Future<Map<String, dynamic>> login(dynamic body) async {
    final response = await _client.post(
      path: ApiRoutes().login,
      body: jsonEncode(body),
    );

    return response;
  }
}