import 'package:get/get.dart';
import 'package:ti3/presentation/pages/home_page/home_page.dart';
import 'package:ti3/presentation/pages/manage_teatchers/manage_teatchers_page.dart';
import 'package:ti3/shared/paths.dart';

import '../di/login_module.dart';
import '../presentation/pages/login_page/login_page.dart';

class Routes {
  static List<GetPage> pages = [
    GetPage(name: Paths.loginPage, page: () => const LoginPage(), binding: LoginModule()),
    GetPage(name: Paths.homePage, page: () => const HomePage(), binding: LoginModule()),
    GetPage(name: Paths.manageTeatchersPage, page: () => ManageTeatchersPage(), binding: LoginModule()),
  ];
}
