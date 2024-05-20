import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/domain/classroom/repository/menage_classrooms_repository.dart';
import 'package:ti3/domain/student/repository/student_repository.dart';
import 'package:ti3/domain/teatcher/repository/teacher_repository.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';
import 'package:ti3/shared/statics/endpoints.dart';

part 'new_user_controller.g.dart';

class NewUserController = NewUserControllerStore with _$NewUserController;

abstract class NewUserControllerStore with Store {
  final String door = Endpoints.baseUrl;
  final TeacherRepository teacherRepository = TeacherRepository();
  final StudentRepository studentRepository = StudentRepository();
  final ClassroomRepository classroomRepository = ClassroomRepository();

  List<String> endpoints = [
    '${Endpoints.baseUrl}administrator',
    '${Endpoints.baseUrl}teacher',
    '${Endpoints.baseUrl}parents',
  ];

  @observable
  TextEditingController codeController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  UserTypeEnum userType = UserTypeEnum.undefined;
  
  @observable
  ObservableList<ClassroomModel> classrooms = ObservableList<ClassroomModel>();

  @action
  Future<void> init(UserTypeEnum type) async {
    userType = type;
    if (type == UserTypeEnum.student) {
      try {
        classrooms.clear();
        final classroomsResponse = await getAllClassrooms();
        classrooms.addAll(classroomsResponse);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<ClassroomModel>> getAllClassrooms() async {
    try {
      final response = await classroomRepository.fetchClassrooms();
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<List<Teacher>> getAllTeachers() async {
    try {
      final response = await teacherRepository.getAllTeachers();
      return response;
    } catch(e) {
      print(e);
      return [];
    }
  }

  Future<void> register(UserTypeEnum type) async {
    var code = codeController.text;
    var password = passwordController.text;

    try {
      final selectedEndpoint = _getEndpointForType(type); 
      print(selectedEndpoint);

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Sucesso', 'Novo usuário registrado com sucesso');
      } else {
        final errorMessage = json.decode(response.body)['message'] ?? 'Erro desconhecido';
        Get.snackbar('Erro', errorMessage);
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        'Erro', 
        'Um erro inesperado ocorreu. Tente novamente mais tarde.'
      );
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
