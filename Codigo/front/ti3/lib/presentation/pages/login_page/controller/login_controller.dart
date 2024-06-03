import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/login/use_cases/do_login.dart';
import 'package:ti3/shared/widgets/paths.dart';

import '../../../../domain/login/model/user_model.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerStore with _$LoginController;

abstract class LoginControllerStore with Store {

  final DoLogin doLogin;

  LoginControllerStore({required this.doLogin});

  @observable
  TextEditingController codeController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  bool passwordIsVisible = false;

  @action
  void reset() {
    codeController.clear();
    passwordController.clear();
  }

  @action
  Future<void> login() async {
    final code = codeController.text;
    final password = passwordController.text;

    final result = await doLogin(code, password);

    result.processResult(
      onSuccess: (UserModel user) {
        CurrentUser().name = user.name;
        CurrentUser().password = password;
        CurrentUser().type = user.type;
        Get.toNamed(Paths.homePage);
      },
      onFailure: (Exception e) {
        Get.snackbar('Error', '$e');
      },
    );
  }

  @action
  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
  }
}
