import 'dart:convert';

import 'package:ti3/data/api/api.dart';
import 'package:ti3/domain/api/api_handler.dart';

class NotificationDatasource {
  final ApiHandler _client;

  NotificationDatasource(this._client);

  Future<Map<String, dynamic>> createNotification(dynamic body) async {
    final response = await _client.post(
      path: "${ApiRoutes().createNotifications}2",
      body: jsonEncode(body),
    );

    return response;
  }

  Future<List<dynamic>> getNotifications() async {
    final response = await _client.get(
      path: ApiRoutes().getNotifications,
    );

    return response;
  }

  Future<void> deleteNotification(int id) async {
    final response = await _client.delete(
      path: ApiRoutes().deleteNotifications + id.toString(),
    );

    return response;
  }
}