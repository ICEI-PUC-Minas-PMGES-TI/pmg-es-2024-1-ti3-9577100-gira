import 'dart:convert';

import 'package:ti3/data/api/api.dart';
import 'package:ti3/domain/api/api_handler.dart';

class NewsDatasource {
  final ApiHandler _client;

  NewsDatasource(this._client);

  Future<Map<String, dynamic>> createNews(dynamic body) async {
    final response = await _client.post(
      path: ApiRoutes().createNews,
      body: jsonEncode(body),
    );

    return response;
  }

  Future<List<dynamic>> getNews() async {
    final response = await _client.get(
      path: ApiRoutes().getNews,
    );

    return response;
  }

  Future<void> deleteNews(int id) async {
    final response = await _client.delete(
      path: ApiRoutes().deleteNews + id.toString(),
    );

    return response;

  }
}