import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerStore with _$LoginController;

abstract class LoginControllerStore with Store {
  final String apiUrl = 'http://localhost:8080';

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
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/administrator/login'),
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Authentication successful');
        reset();
        Get.back();
      } else {
        Get.snackbar('Error', 'Authentication failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection error');
    }
  }

  @action
  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
  }
}
