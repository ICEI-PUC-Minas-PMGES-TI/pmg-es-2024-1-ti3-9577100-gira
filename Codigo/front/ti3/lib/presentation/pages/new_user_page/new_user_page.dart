import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/new_user_page/controller/new_user_controller.dart';
import 'package:ti3/utils/gira_colors.dart';

class NewUserPage extends StatelessWidget {
  final NewUserController controller = Get.put(NewUserController());
  final type = Get.arguments['type'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: GiraColors.loginBoxColor,
        title: const Text('Cadastro de Novo Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Código',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.codeController,
                decoration: const InputDecoration(
                  label: Text(
                    'Informe o código...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Senha',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  label: Text(
                    'Cria uma senha...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 450),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    var userType = UserTypeEnum.admin;

                    if(type == 'teacher') {
                      userType = UserTypeEnum.teacher;
                    } else {
                      userType = UserTypeEnum.teacher;
                    }

                    controller.register(userType);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: GiraColors.loginBoxColor),
                    ),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(
                        color: GiraColors.loginBoxColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
