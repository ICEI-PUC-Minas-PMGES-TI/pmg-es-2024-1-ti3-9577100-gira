import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/new_user_page/controller/new_user_controller.dart';
import 'package:ti3/utils/gira_colors.dart';

class NewUserPage extends StatelessWidget {
  final NewUserController controller = Get.put(NewUserController());
  // final type = Get.arguments['type'];
  final UserTypeEnum? type;

  NewUserPage({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: GiraColors.loginBoxColor,
        title: Text(getTitle()),
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
                    var userType = UserTypeEnum.administrator;

                    if (type == UserTypeEnum.teacher) {
                      userType = UserTypeEnum.teacher;
                    } else if (type == UserTypeEnum.student) {
                      userType = UserTypeEnum.student;
                    } else if (type == UserTypeEnum.parents) {
                      userType = UserTypeEnum.parents;
                    } else if (type == UserTypeEnum.classroom) {
                      userType = UserTypeEnum.classroom;
                    } else if (type == UserTypeEnum.administrator) {
                      userType = UserTypeEnum.administrator;
                    } else {
                      userType = UserTypeEnum.parents;
                    }

                    controller.register(userType);
                    Navigator.pop(context);
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

  String getTitle() {
    switch (type) {
      case UserTypeEnum.teacher:
        return 'Cadastro de Professor';
      case UserTypeEnum.parents:
        return 'Cadastro de Responsável';
      case UserTypeEnum.administrator:
        return 'Cadastro de Admin';
      case UserTypeEnum.student:
        return 'Registro de Aluno';
      default:
        return 'Título';
    }
  }
}
