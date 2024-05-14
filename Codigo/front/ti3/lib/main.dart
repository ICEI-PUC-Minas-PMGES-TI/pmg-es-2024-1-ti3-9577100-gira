import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/shared/routes.dart';

import 'di/dependency_injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final injector = DependencyInjector();
  injector.setup();

  runApp(GetMaterialApp(
    initialRoute: Paths.loginPage,
    getPages: Routes.pages,
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: const [
      Locale('pt', 'BR'),
    ],
  ));
}
