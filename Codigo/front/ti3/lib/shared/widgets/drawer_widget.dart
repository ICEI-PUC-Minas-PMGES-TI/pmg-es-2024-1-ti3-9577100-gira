import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/home_page/home_page.dart';
import 'package:ti3/presentation/pages/menage_classrooms/menage_classrooms_page.dart';
import 'package:ti3/presentation/pages/menage_users/menage_users_page.dart';
import 'package:ti3/presentation/pages/new_user_page/new_user_page.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/shared/widgets/rounded_image_widget.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key});

  void _navigateToNewUserPage(UserTypeEnum userType) {
    Get.to(() => NewUserPage(type: userType));
  }

  void _navigateToMenageUsers(UserTypeEnum userType) {
    Get.to(() => MenageUsersPage(type: userType));
  }

  void _navigateToClassroomsPage() {
    Get.to(() => MenageClassroomsPage());
  }

  @override
  Widget build(BuildContext context) {
    final bool isParent = CurrentUserManager.currentUser.type == UserTypeEnum.parents;

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
                  getType(CurrentUserManager.currentUser.type ?? UserTypeEnum.undefined),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey),
                if (!isParent)
                  TextButton(
                    onPressed: () => Get.to(() => HomePage()),
                    child: Text(
                      'Home',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                if (!isParent)
                  TextButton(
                    onPressed: () => _navigateToMenageUsers(UserTypeEnum.teacher),
                    child: Text(
                      'Gerenciar professores',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                if (!isParent)
                  TextButton(
                    onPressed: () => _navigateToMenageUsers(UserTypeEnum.student),
                    child: Text(
                      'Gerenciar alunos',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                if (!isParent)
                  TextButton(
                    onPressed: () => _navigateToNewUserPage(UserTypeEnum.parents),
                    child: Text(
                      'Gerenciar responsáveis',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                if (!isParent)
                  TextButton(
                    onPressed: () => _navigateToClassroomsPage(),
                    child: Text(
                      'Gerenciar turmas',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                TextButton(
                  onPressed: () => Get.toNamed(Paths.loginPage),
                  child: Text(
                    'Sair',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getType(UserTypeEnum type) {
    switch (type) {
      case UserTypeEnum.administrator:
        return 'Admin';
      case UserTypeEnum.teacher:
        return 'Professor(a)';
      default:
        return 'Responsável';
    }
  }
}

