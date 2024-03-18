import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/shared/paths.dart';
import 'package:ti3/shared/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GetMaterialApp(
    initialRoute: Paths.loginPage,
    getPages: Routes.pages,
    debugShowCheckedModeBanner: false,
  ));
}
