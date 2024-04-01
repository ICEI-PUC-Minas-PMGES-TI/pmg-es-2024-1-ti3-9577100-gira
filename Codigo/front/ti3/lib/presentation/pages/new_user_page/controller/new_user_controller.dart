import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/context/current_user.dart';
import 'package:http/http.dart' as http;

part 'new_user_controller.g.dart';

class NewUserController = NewUserControllerStore with _$NewUserController;

abstract class NewUserControllerStore with Store {
  final String door = '192.168.0.20:8080';
  List<String> endpoints = [
    'http://192.168.0.20:8080/administrator',
    'http://192.168.0.20:8080/teacher',
    'http://192.168.0.20:8080/parent',
  ];

  @observable
  TextEditingController codeController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  UserTypeEnum userType = UserTypeEnum.undefined;

  @override
  Future<void> register(UserTypeEnum type) async {
    var code = codeController.text;
    var password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://${door}/teacher'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "name": code,
          "password": password,
          "type": 'TEACHER'
        }),
      );

      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Salvo', 'Novo usuário registrado');
      } else {
        Get.snackbar('Erro', 'Erro ao registrar novo usuário');
      }
    } catch (e) {
      print(e);
      Get.snackbar(
          'Erro', 'Um erro inesperado ocorreu. Tente novamente mais tarde.');
    }
  }
}
