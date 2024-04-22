import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/shared/widgets/drawer_widget.dart';
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
        title: Text(
          widget.type == UserTypeEnum.teacher ? "Professores" : widget.type == UserTypeEnum.student ? "Alunos" : "Responsáveis",
          style: const TextStyle(
            fontFamily: GiraFonts.poorStory,
            fontSize: 32,
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
          const SizedBox(height: 16,),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquise pelo nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
                suffixIconColor: GiraColors.loginBoxColor,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ListView.builder(
          //
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.type == UserTypeEnum.classroom
              ? Get.toNamed(Paths.newClassPage,)
              : Get.toNamed(Paths.newUserPage, arguments: {'type': '${widget.type}'});
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
}
