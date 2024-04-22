import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ti3/domain/news/use_cases/delete_news.dart';
import 'package:ti3/domain/news/use_cases/get_news.dart';
import 'package:ti3/domain/notification/use_cases/get_notifications.dart';
import 'package:ti3/presentation/pages/calendar_page/controller/calendar_controller.dart';
import 'package:ti3/presentation/pages/home_page/controller/home_controller.dart';
import 'package:ti3/presentation/pages/notification_page/controller/notification_controller.dart';

import '../domain/notification/use_cases/create_notification.dart';
import '../domain/notification/use_cases/delete_notification.dart';
import '../presentation/pages/feed_page/controller/feed_controller.dart';

class HomeModule extends Bindings {
  HomeModule();

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FeedController(
        getNews: GetNews(GetIt.I()),
        deleteNews: DeleteNews(GetIt.I()),
    ));
    Get.lazyPut(() => NotificationController(
        getNotifications: GetNotifications(GetIt.I()),
        deleteNotification: DeleteNotification(GetIt.I()),
        createNotification: CreateNotification(GetIt.I()),
    ));
    Get.lazyPut(() => CalendarController());
  }
}
