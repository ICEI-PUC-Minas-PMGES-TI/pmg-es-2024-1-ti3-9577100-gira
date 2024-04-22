import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/domain/notification/use_cases/delete_notification.dart';
import 'package:ti3/domain/notification/use_cases/get_notifications.dart';

import '../../../../domain/notification/model/notification_model.dart';
import '../../../../domain/notification/use_cases/create_notification.dart';

part 'notification_controller.g.dart';

class NotificationController = NotificationControllerStore with _$NotificationController;

abstract class NotificationControllerStore extends DisposableInterface with Store {
  final GetNotifications _getNotifications;
  final DeleteNotification _deleteNotification;
  final CreateNotification _createNotification;

  NotificationControllerStore({
    required GetNotifications getNotifications,
    required DeleteNotification deleteNotification,
    required CreateNotification createNotification
  }) : _getNotifications = getNotifications,
        _deleteNotification = deleteNotification,
        _createNotification = createNotification;

  final _atom = Atom();

  @observable
  TextEditingController messageController = TextEditingController();

  @observable
  List<NotificationModel> notificationItems = [];

  @override
  void onInit() async {
    await getNotifications();
    super.onInit();
  }

  Future<void> createNotification() async {
    await _createNotification(messageController.text);
    await getNotifications();
    messageController.clear();
  }

  Future<void> getNotifications() async {
    final result = await _getNotifications();

    result.processResult(
        onSuccess: (List<NotificationModel> result) {
          result.sort((a, b) => b.date.compareTo(a.date));
          notificationItems = result;
        },
        onFailure: (Exception e) {
          notificationItems = [];
        }
    );

    _atom.reportChanged();
  }

  Future<void> deleteNews(int id) async {
    await _deleteNotification(id);
    await getNotifications();
  }

  @action
  void reset() {
    messageController.clear();
  }

  @action
  void reload() {
    getNotifications();
  }
}