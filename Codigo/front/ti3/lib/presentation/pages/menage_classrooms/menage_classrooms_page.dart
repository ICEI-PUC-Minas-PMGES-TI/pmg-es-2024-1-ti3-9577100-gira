import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/presentation/pages/menage_classrooms/controller/menage_classrooms_controller.dart';
import 'package:ti3/presentation/pages/menage_classrooms/widgets/classroom_card_item.dart';
import 'package:ti3/shared/widgets/drawer_widget.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

import '../../../shared/widgets/paths.dart';

class MenageClassroomsPage extends StatefulWidget {
  @override
  _MenageClassroomsPageState createState() => _MenageClassroomsPageState();
}

class _MenageClassroomsPageState extends State<MenageClassroomsPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  MenageClassroomsController controller = MenageClassroomsController();

  List<ClassroomModel> allClassrooms = [];

  @override
  void initState() {
    super.initState();
    getClassrooms();
  }

  Future<void> getClassrooms() async {
    var fetchedClassrooms = await controller.fetchClassrooms();
    setState(() {
      allClassrooms = fetchedClassrooms;
    });
  }

  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Salas de Aula",
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
          Expanded(
            child: Container(
              height: 500,
              width: 350,
              child: ListView.builder(
                itemCount: allClassrooms.length,
                itemBuilder: (context, index) {
                  return ClassroomCardItem(classroom: allClassrooms[index]);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Paths.newClassPage);
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
