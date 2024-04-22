import 'package:ti3/domain/notification/model/notification_model.dart';
import 'package:ti3/domain/notification/repository/notification_repository.dart';

import '../../utils/result.dart';

class CreateNotification {
  final NotificationRepository _repository;

  CreateNotification(this._repository);

  Future<Result<NotificationModel, Exception>> call(String message) async =>
      await _repository.createNotification(message);
}
