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
        Uri.parse('http://10.0.2.2:8000/administrator/login'),
        body: {
          "name": "Juliana",
          "password": "12345678"
        },

      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login realizado');
        reset();
        Get.back();
      } else {
        Get.snackbar('Error', 'Falha');
      }
    } catch (e) {
      print('Erro: $e');
      Get.snackbar('Error', '${e}');
    }
  }

  @action
  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
  }
}
