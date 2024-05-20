import 'package:flutter/material.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class StudentCardItem extends StatelessWidget {
  final Student student;

  const StudentCardItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: GiraColors.fields,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/placeholder_photo.png'),
            radius: 25,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name ?? 'Nome',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: GiraFonts.poorStory,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  student.schoolClass?.name ?? 'Turma', 
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: GiraFonts.poorStory,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
            color: GiraColors.loginBoxColor,
          ),
        ],
      ),
    );
  }
}
