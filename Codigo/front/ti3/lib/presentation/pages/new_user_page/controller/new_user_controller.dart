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
    'http://192.168.0.20:8080/parents',
  ];

  @observable
  TextEditingController codeController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  UserTypeEnum userType = UserTypeEnum.undefined;

  Future<void> register(UserTypeEnum type) async {
    var code = codeController.text;
    var password = passwordController.text;

    try {
      final selectedEndpoint = _getEndpointForType(type); 

      final response = await http.post(
        Uri.parse(selectedEndpoint),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "name": code,
          "password": password,
          "type": type.toString().split('.').last.toUpperCase() 
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

  String _getEndpointForType(UserTypeEnum type) {
    switch (type) {
      case UserTypeEnum.administrator:
        return endpoints[0];
      case UserTypeEnum.teacher:
        return endpoints[1];
      case UserTypeEnum.parents:
        return endpoints[2];
      default:
        throw Exception('Tipo de usuário não suportado');
    }
  }
}


