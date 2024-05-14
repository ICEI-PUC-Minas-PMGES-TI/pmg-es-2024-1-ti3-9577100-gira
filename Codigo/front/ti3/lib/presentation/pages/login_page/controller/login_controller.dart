import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/login/use_cases/do_login.dart';
import 'package:ti3/shared/statics/endpoints.dart';
import 'package:ti3/shared/widgets/paths.dart';

import '../../../../domain/login/model/user_model.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerStore with _$LoginController;

abstract class LoginControllerStore with Store {

  final DoLogin doLogin;

  LoginControllerStore({required this.doLogin});

  final String door = Endpoints.baseUrl;
  
  final List<String> loginEndpoints = [
    'administrator/login',
    'parents/login',
    'teacher/login',
  ];

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
    final name = emailController.text;
    final password = passwordController.text;

    final result = await doLogin(name, password);

    result.processResult(
      onSuccess: (UserModel user) {
        CurrentUser().name = name;
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
