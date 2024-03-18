import 'package:get/get.dart';
import 'package:ti3/presentation/pages/login_page/controller/login_controller.dart';

class LoginModule extends Bindings {
  LoginModule();

  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
