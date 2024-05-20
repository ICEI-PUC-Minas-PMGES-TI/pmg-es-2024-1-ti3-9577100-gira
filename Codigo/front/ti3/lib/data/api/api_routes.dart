class ApiRoutes {
  ApiRoutes();

  String get login => 'login';
  String get createNews => 'news';
  String get deleteNews => 'news/';
  String get getNews => 'news/all';
  String get createNotifications => 'notification/send';
  String get getNotifications => 'notification/all';
  String get deleteNotifications => 'notification/delete/';
}