import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/shared/widgets/paths.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerStore with _$LoginController;

abstract class LoginControllerStore with Store {
  final String door = '192.168.0.186:8080';
  final List<String> endpoints = [
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
    var name = emailController.text;
    var password = passwordController.text;
    var isUserFound = false;

    List<String> endpoints = [
      'http://192.168.0.186:8080/administrator/login',
      'http://192.168.0.186:8080/teacher/login',
      'http://192.168.0.186:8080/parent/login',
    ];

    try {
      for (var endpoint in endpoints) {
        final response = await http.post(
          Uri.parse(endpoint),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({"name": name, "password": password}),
        );
        if (response.statusCode == 200) {
          CurrentUser current = CurrentUser();
          current.name = name;
          current.password = password;
          isUserFound = true;
          break; 
        }
      }

      if (isUserFound) {
        Get.toNamed(Paths.homePage);
      } else {
        Get.snackbar('Erro', 'Usuário não encontrado');
      }
    } catch (e) {
      print('Erro: $e');
      Get.snackbar('Error', '$e');
    }
  }

  @action
  void togglePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
  }
}
