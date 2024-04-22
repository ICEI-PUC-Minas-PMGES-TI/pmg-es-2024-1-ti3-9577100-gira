import 'package:ti3/domain/notification/repository/notification_repository.dart';

import '../../utils/result.dart';

class DeleteNotification {
  final NotificationRepository _repository;

  DeleteNotification(this._repository);

  Future<Result<void, Exception>> call(int id) async =>
      await _repository.deleteNotification(id);
}
