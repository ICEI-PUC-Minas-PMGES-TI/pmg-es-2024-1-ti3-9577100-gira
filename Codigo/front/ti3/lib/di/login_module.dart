import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ti3/presentation/pages/login_page/controller/login_controller.dart';

import '../domain/login/use_cases/do_login.dart';

class LoginModule extends Bindings {
  LoginModule();

  @override
  void dependencies() {
    Get.put(LoginController(doLogin: DoLogin(GetIt.I())));
  }
}
