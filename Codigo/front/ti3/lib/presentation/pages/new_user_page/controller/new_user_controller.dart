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
  final String door = '192.168.0.186:8080';
  final List<String> endpoints = [
    'administrador',
    'parents',
    'teacher',
  ];

  @observable
  TextEditingController codeController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  UserTypeEnum userType = UserTypeEnum.undefined;

  @override
  Future<void> register() async {
    var code = codeController.text;
    var password = passwordController.text;
    var type = userType;

    try {
      final response = await http.post(
        Uri.parse('http://${door}/teacher}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            json.encode({"name": code, "password": password, type: 'teacher'}),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Salvo', 'Novo usuário registrado');
      } else {
        Get.snackbar('Erro', 'Erro ao registrar novo usuário');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Erro', 'Um erro inesperado ocorreu. Tente novamente mais tarde.');
    }
  }
}
