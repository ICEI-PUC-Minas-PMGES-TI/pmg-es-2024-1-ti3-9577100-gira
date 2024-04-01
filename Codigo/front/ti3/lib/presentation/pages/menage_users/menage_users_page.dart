import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/shared/search_field.dart';
import 'package:ti3/shared/widgets/drawer_widget.dart';
import 'package:ti3/shared/widgets/user_box_item.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

import '../../../shared/widgets/paths.dart';

class MenageUsersPage extends StatefulWidget {
  final UserTypeEnum? type;

  const MenageUsersPage({super.key, this.type});

  @override
  _MenageUsersPageState createState() => _MenageUsersPageState();
}

class _MenageUsersPageState extends State<MenageUsersPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  bool isMorningSelected = false;
  bool isAfternoonSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
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
        ),
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(width: 300, child: SearchBarWidget()),
          ),
          widget.type == UserTypeEnum.teacher || widget.type == UserTypeEnum.student
              ? _buildButtons(context)
              : Container(
                  height: 30,
                ),
          UserBoxItem(
            type: widget.type,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.type == UserTypeEnum.clasroom
              ? Get.toNamed(Paths.newClassPage)
              : Get.toNamed(Paths.newUserPage);
        },
        backgroundColor: GiraColors.loginBoxColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isMorningSelected = !isMorningSelected;
              isAfternoonSelected = false;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            width: 70,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: isMorningSelected ? Colors.blue : Colors.grey,
            ),
            child: const Text(
              'Manhã',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: GiraFonts.poorStory,
                fontSize: 16,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isAfternoonSelected = !isAfternoonSelected;
              isMorningSelected = false;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            width: 70,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: isAfternoonSelected ? Colors.blue : Colors.grey,
            ),
            child: const Text(
              'Tarde',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: GiraFonts.poorStory,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
