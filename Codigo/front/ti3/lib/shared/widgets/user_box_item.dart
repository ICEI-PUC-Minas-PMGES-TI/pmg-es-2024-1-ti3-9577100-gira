import 'package:flutter/material.dart';
import 'package:ti3/shared/widgets/rounded_image_widget.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class UserBoxItem extends StatelessWidget {
  final String? type;

  const UserBoxItem({super.key, this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        height: 80,
        decoration: BoxDecoration(
          color: GiraColors.fields,
          borderRadius: BorderRadius.circular(10),
        ),
        child: type == 'TEACHER'
            ? _buildTeatcherBody(context)
            : type == 'STUDENT'
                ? _buildStudentsBodt(context)
                : type == 'PARENTS'
                    ? _buildParentsBody(context)
                    : type == 'CLASS'
                        ? _buildClassesBody(context)
                        : Text('Tipo não identificado'));
  }

  Widget _buildTeatcherBody(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: RoundedImageWidget(
            name: 'Professor Silva',
            size: 50,
            textSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Text(
                'Professor da Silva Costa de Oliveira',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Turma E - 2 Período',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              )
            ],
          ),
        ),
        const Icon(
          Icons.delete_outline,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildParentsBody(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: RoundedImageWidget(
            name: 'RESPONSÁVEL Pereira Costa',
            size: 50,
            textSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Text(
                'RESPONSÁVEL Pereira Costa',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Turma A - 2 Período',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              )
            ],
          ),
        ),
        const Icon(
          Icons.delete_outline,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildStudentsBodt(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: RoundedImageWidget(
            name: 'ALUNO Júnior da Silva',
            size: 50,
            textSize: 20,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: const Column(
            children: [
              Text(
                'ALUNO Júnior da Silva',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Turma B - 1 Período',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 15),
              )
            ],
          ),
        ),
        const Icon(
          Icons.delete_outline,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildClassesBody(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Turma A - 2 Período',
                style: TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 20),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.only(right: 20),
          child: Icon(
            Icons.edit_outlined,
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
