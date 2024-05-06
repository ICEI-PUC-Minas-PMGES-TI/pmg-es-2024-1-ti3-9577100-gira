import 'package:get/get.dart';
import 'package:ti3/di/home_module.dart';
import 'package:ti3/di/publication_module.dart';
import 'package:ti3/presentation/pages/album_page/all_pictures_page.dart';
import 'package:ti3/presentation/pages/calendar_page/calendar_page.dart';
import 'package:ti3/presentation/pages/calendar_page/widgets/create_event_page.dart';
import 'package:ti3/presentation/pages/home_page/home_page.dart';
import 'package:ti3/presentation/pages/menage_users/menage_users_page.dart';
import 'package:ti3/presentation/pages/new_class_page/new_class_page.dart';
import 'package:ti3/presentation/pages/new_user_page/new_user_page.dart';
import 'package:ti3/presentation/pages/publication_page/publication_page.dart';
import 'package:ti3/shared/widgets/paths.dart';

import '../di/login_module.dart';
import '../presentation/pages/feed_page/feed_page.dart';
import '../presentation/pages/login_page/login_page.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(name: Paths.loginPage, page: () => const LoginPage(), binding: LoginModule()),
    GetPage(name: Paths.homePage, page: () => const HomePage(), binding: HomeModule()),
    GetPage(name: Paths.manageTeachersPage, page: () => const MenageUsersPage(), binding: LoginModule()),
    GetPage(name: Paths.newUserPage, page: () => NewUserPage(), binding: LoginModule()),
    GetPage(name: Paths.newClassPage, page: () => NewClassPage(), binding: LoginModule()),
    GetPage(name: Paths.publicationPage, page: () => const PublicationPage(), binding: PublicationModule()),
    GetPage(name: Paths.homePage, page: () => const HomePage(), binding: HomeModule()),
    GetPage(name: Paths.feedPage, page: () => const FeedPage(), binding: HomeModule()),
    GetPage(name: Paths.calendarPage, page: () => const CalendarPage(), binding: HomeModule()),
    GetPage(name: Paths.eventPage, page: () => CreateEventPage(), binding: HomeModule()),
    GetPage(name: Paths.allImagesPage, page: () => AllPicturesPage(), binding: HomeModule()),
  ];
}
