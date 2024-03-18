import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/shared/paths.dart';
import 'package:ti3/shared/rounded_image_widget.dart';
import 'package:ti3/shared/routes.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
              child: Column(
                children: [
                  RoundedImageWidget(
                    name: 'Elias Regina',
                    size: 90,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Elis Regina de Souza Lima',
                    style: TextStyle(
                        color: Color.fromARGB(255, 18, 87, 143), fontSize: 18),
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
                        Get.toNamed(Paths.manageTeatchersPage);
                      },
                      child: const Text(
                        'Gerenciar professores',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Gerenciar professores',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GiraColors.loginBoxColor,
        unselectedItemColor: Colors.pink,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Avisos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_back),
            label: "Fotos",
          ),
        ],
      ),
      appBar: AppBar(
          title: const Text(
            "GIRA",
            style: TextStyle(
              fontFamily: GiraFonts.poorStory,
              fontSize: 42,
              color: GiraColors.loginBoxColor,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: GiraColors.loginBoxColor,
              size: 32,
            ),
          )),
      body: Container(
        child: Text('teste'),
      ),
    );
  }
}
