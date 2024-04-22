import '../../utils/result.dart';
import '../model/notification_model.dart';

abstract class NotificationRepository {
  Future<Result<NotificationModel, Exception>> createNotification(
      String message);
  Future<Result<List<NotificationModel>, Exception>> getNotifications();
  Future<Result<void, Exception>> deleteNotification(int id);
}