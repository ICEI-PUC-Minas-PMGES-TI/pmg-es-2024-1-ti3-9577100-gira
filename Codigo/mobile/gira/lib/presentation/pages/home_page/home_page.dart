import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        )
      ),
      body: Container(),
    );
  }
}
