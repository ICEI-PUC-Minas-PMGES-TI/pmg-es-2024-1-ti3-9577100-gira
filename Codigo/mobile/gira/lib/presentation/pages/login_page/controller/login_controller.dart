import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerStore with _$LoginController;

abstract class LoginControllerStore with Store {

  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  bool passwordIsVisible = false;

  @action
  void reset() {
    emailController.clear();
    passwordController.clear();
  }

  @action
  Future<void> login() async {
    reset();
    Get.back();
  }

  @action
  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
  }

}