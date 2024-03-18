import 'package:get/get.dart';
import 'package:ti3/presentation/pages/home_page/controller/home_controller.dart';

class HomeModule extends Bindings {
  HomeModule();

  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
