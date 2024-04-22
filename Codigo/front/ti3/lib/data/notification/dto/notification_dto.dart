import 'dart:convert';
import 'dart:math';

import '../../../domain/notification/model/notification_model.dart';

extension NotificationDto on NotificationModel {
  static Map<String, dynamic> fromDomain(String message) {
    Map<String, dynamic> map = {};
    map['message'] = message;
    return map;
  }

  static List<NotificationModel> fromListJSON(List<dynamic> json) {
    return json.map((e) => fromJSON(e)).toList();
  }

  static NotificationModel fromJSON(Map<String, dynamic> json) {
    final id = json['id'];
    final jsonMessage = json['message'];
    final message = jsonDecode(jsonMessage)['message'];

    final date = DateTime(2023, Random().nextInt(12), Random().nextInt(28));
    final author = "Livia Lima";

    return NotificationModel(
      id: id,
      message: message,
      author: author,
      date: date,
      status: NotificationStatus.unread,
    );
  }
}