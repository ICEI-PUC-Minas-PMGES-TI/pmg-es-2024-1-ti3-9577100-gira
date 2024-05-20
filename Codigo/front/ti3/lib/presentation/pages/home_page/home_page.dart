import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/presentation/pages/album_page/album_page.dart';
import 'package:ti3/presentation/pages/calendar_page/calendar_page.dart';
import 'package:ti3/presentation/pages/notification_page/notification_page.dart';
import 'package:ti3/shared/widgets/drawer_widget.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

import '../feed_page/feed_page.dart';
import 'controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;
  String imagePath = '';
  Image image = Image.asset(
    'assets/images/user.png',
  );

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
      drawer: DrawerWidget(),
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
      body: IndexedStack(
        index: selectedIndex,
        children: [
          FeedPage(),
          CalendarPage(),
          NotificationPage(),
          const Center(
            child: Text('Álbum')
          ),
        ],
      ),
    );
  }
}

class GiraFloatingActionButton extends StatelessWidget {
  final CurrentUser currentUser = CurrentUser();
  final VoidCallback onPressed;
  final String heroTag;

  GiraFloatingActionButton({
    required this.onPressed,
    required this.heroTag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      shape: const StadiumBorder(),
      backgroundColor: GiraColors.loginBoxColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
