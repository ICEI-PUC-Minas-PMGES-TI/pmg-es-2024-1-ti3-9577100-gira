import 'package:ti3/domain/notification/model/notification_model.dart';
import 'package:ti3/domain/notification/repository/notification_repository.dart';

import '../../utils/result.dart';

class GetNotifications {
  final NotificationRepository _repository;

  GetNotifications(this._repository);

  Future<Result<List<NotificationModel>, Exception>> call() async =>
      await _repository.getNotifications();
}
