import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerStore with _$HomeController;

abstract class HomeControllerStore with Store {

  @observable
  TextEditingController descriptionController = TextEditingController();

  @observable
  String image = '';

  @action
  void reset() {
    descriptionController.clear();
  }

}