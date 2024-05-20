import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/presentation/pages/edit_classroom/edit_classroom_page.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class ClassroomCardItem extends StatelessWidget {
  final ClassroomModel classroom;

  const ClassroomCardItem({Key? key, required this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: GiraColors.loginBoxColor),
              onSelected: (String value) {
                if (value == 'Edit') {
                  Get.to(EditClassroomPage(classroom: classroom,));
                } else if (value == 'Attach') {
                  // mudar
                }
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Edit',
                    child: Text('Editar turma'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Attach',
                    child: Text('Atrelar avisos'),
                  ),
                ];
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classroom.name ?? 'Nome da Turma',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GiraFonts.poorStory,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'Professores: ${classroom.teachers?.length ?? 0}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: GiraFonts.poorStory,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Alunos: ${classroom.students?.length ?? 0}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: GiraFonts.poorStory,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
