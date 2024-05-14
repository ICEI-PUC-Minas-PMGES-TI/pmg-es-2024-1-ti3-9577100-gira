import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/home_page/home_page.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/shared/widgets/rounded_image_widget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key});

  final List<Map<String, dynamic>> allMenuOptions = [
    {'text': 'Home', 'onPressed': const HomePage()},
    {'text': 'Gerenciar professores', 'type': UserTypeEnum.teacher},
    {'text': 'Gerenciar alunos', 'type': UserTypeEnum.student},
    {'text': 'Gerenciar responsáveis', 'type': UserTypeEnum.parents},
    {'text': 'Gerenciar turmas', 'type': UserTypeEnum.classroom},
    {'text': 'Sair', 'onPressed': () => Get.toNamed(Paths.loginPage)},
  ];

  final List<Map<String, dynamic>> parentsMenuOptions = [
    {'text': 'Home', 'onPressed': const HomePage()},
    {'text': 'Sair', 'onPressed': () => Get.toNamed(Paths.loginPage)},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuOptions =
        CurrentUserManager.currentUser.type == UserTypeEnum.parents
            ? parentsMenuOptions
            : allMenuOptions;
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
            child: Column(
              children: [
                RoundedImageWidget(
                  name: CurrentUserManager.currentUser.name ?? 'ERRO',
                  size: 90,
                ),
                const SizedBox(height: 20),
                Text(
                  CurrentUserManager.currentUser.name ?? 'ERRO',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 18, 87, 143),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  CurrentUserManager.currentUser.type.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuOptions.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        final onPressed = menuOptions[index]['onPressed'];
                        if (onPressed is Widget) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => onPressed),
                          );
                        } else if (onPressed is Function) {
                          onPressed();
                        }
                      },
                      child: Text(
                        menuOptions[index]['text'],
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
