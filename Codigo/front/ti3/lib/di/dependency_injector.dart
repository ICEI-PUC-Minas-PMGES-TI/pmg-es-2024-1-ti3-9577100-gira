import 'package:get_it/get_it.dart';
import 'package:ti3/data/login/datasource/login_datasource.dart';
import 'package:ti3/data/login/repository/login_repository_impl.dart';
import 'package:ti3/data/news/datasource/news_datasource.dart';
import 'package:ti3/data/notification/datasource/notification_datasource.dart';
import 'package:ti3/domain/login/repository/login_repository.dart';
import 'package:ti3/domain/login/use_cases/do_login.dart';
import 'package:ti3/domain/news/use_cases/delete_news.dart';
import 'package:ti3/domain/news/use_cases/get_news.dart';
import 'package:ti3/domain/notification/repository/notification_repository.dart';
import 'package:ti3/domain/notification/use_cases/create_notification.dart';

import '../data/api/api_handler_impl.dart';
import '../data/api/dio_client.dart';
import '../data/news/repository/news_repository_impl.dart';
import '../data/notification/repository/notification_repository_impl.dart';
import '../domain/api/api_handler.dart';
import '../domain/news/repository/news_repository.dart';
import '../domain/news/use_cases/create_news.dart';
import '../domain/notification/use_cases/delete_notification.dart';
import '../domain/notification/use_cases/get_notifications.dart';

class DependencyInjector {
  final _getIt = GetIt.I;

  void setup() {
    registerApiClient();
    registerDatasource();
    registerRepository();
    registerUseCase();
  }

  void registerApiClient() {
    _getIt.registerSingleton<DioClient>(DioClient());
    _getIt.registerFactory<ApiHandler>(() => ApiHandlerImpl(client: _getIt()));
  }

  void registerDatasource() {
    _getIt.registerFactory<LoginDatasource>(
          () => LoginDatasource(_getIt()),
    );
    _getIt.registerFactory<NewsDatasource>(
          () => NewsDatasource(_getIt()),
    );
    _getIt.registerFactory<NotificationDatasource>(
          () => NotificationDatasource(_getIt()),
    );
  }

  void registerRepository() {
    _getIt.registerFactory<LoginRepository>(
          () => LoginRepositoryImpl(_getIt()),
    );
    _getIt.registerFactory<NewsRepository>(
          () => NewsRepositoryImpl(_getIt()),
    );
    _getIt.registerFactory<NotificationRepository>(
          () => NotificationRepositoryImpl(_getIt()),
    );
  }

  void registerUseCase() {
    _getIt.registerFactory<DoLogin>(
          () => DoLogin(_getIt()),
    );
    _getIt.registerFactory<CreateNews>(
          () => CreateNews(_getIt()),
    );
    _getIt.registerFactory<GetNews>(
          () => GetNews(_getIt()),
    );
    _getIt.registerFactory<DeleteNews>(
          () => DeleteNews(_getIt()),
    );
    _getIt.registerFactory<GetNotifications>(
          () => GetNotifications(_getIt()),
    );
    _getIt.registerFactory<DeleteNotification>(
          () => DeleteNotification(_getIt()),
    );
    _getIt.registerFactory<CreateNotification>(
          () => CreateNotification(_getIt()),
    );
  }
}