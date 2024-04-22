import 'package:ti3/data/notification/datasource/notification_datasource.dart';
import 'package:ti3/data/notification/dto/notification_dto.dart';
import 'package:ti3/data/utils/base_repository.dart';
import 'package:ti3/domain/notification/model/notification_model.dart';

import '../../../domain/notification/repository/notification_repository.dart';
import '../../../domain/utils/result.dart';

class NotificationRepositoryImpl extends BaseRepository implements NotificationRepository {
  final NotificationDatasource _datasource;

  NotificationRepositoryImpl(this._datasource);

  @override
  Future<Result<NotificationModel, Exception>> createNotification(String message) async {
    try {
      final response = await _datasource.createNotification(NotificationDto.fromDomain(message));
      final result = NotificationDto.fromJSON(response);
      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }

  @override
  Future<Result<List<NotificationModel>, Exception>> getNotifications() async {
    try {
      final response = await _datasource.getNotifications();
      final result = NotificationDto.fromListJSON(response);
      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }

  @override
  Future<Result<void, Exception>> deleteNotification(int id) async {
    try {
      await _datasource.deleteNotification(id);
      return Result.success(null);
    } catch (e) {
      return handleFailure(error: e);
    }
  }
}