import 'package:flutter/material.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/home_page/home_page.dart';
import 'package:ti3/presentation/pages/menage_users/menage_users_page.dart';
import 'package:ti3/shared/widgets/rounded_image_widget.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  CurrentUserManager.currentUser.name ?? 'ERRO',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 18, 87, 143),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Diretora',
                    style: TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenageUsersPage(
                                  type: UserTypeEnum.teacher,
                                )),
                      );
                    },
                    child: const Text(
                      'Gerenciar professores',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenageUsersPage(
                                  type: UserTypeEnum.student,
                                )),
                      );
                    },
                    child: const Text(
                      'Gerenciar alunos',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenageUsersPage(
                                  type: UserTypeEnum.parent,
                                )),
                      );
                    },
                    child: const Text(
                      'Gerenciar responsáveis',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenageUsersPage(
                                  type: UserTypeEnum.clasroom,
                                )),
                      );
                    },
                    child: const Text(
                      'Gerenciar turmas',
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
