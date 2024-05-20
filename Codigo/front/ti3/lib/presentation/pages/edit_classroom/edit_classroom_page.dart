import 'package:flutter/material.dart';
import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/presentation/pages/edit_classroom/controller/edit_classroom_page_controller.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/student.dart';
import 'package:ti3/presentation/pages/menage_users/dtos/teacher.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';

class EditClassroomPage extends StatefulWidget {
  final ClassroomModel classroom;

  const EditClassroomPage({Key? key, required this.classroom})
      : super(key: key);

  @override
  _EditClassroomPageState createState() => _EditClassroomPageState();
}

class _EditClassroomPageState extends State<EditClassroomPage> {
  final _formKey = GlobalKey<FormState>();
  late EditClassroomPageController controller;
  late TextEditingController _nameController;
  late String _turn;
  List<Teacher> _allTeachers = [];
  List<Student> _allStudents = [];
  List<Teacher> _selectedTeachers = [];
  List<Student> _selectedStudents = [];

  @override
  void initState() {
    super.initState();
    controller = EditClassroomPageController(widget.classroom);
    _nameController = TextEditingController(text: widget.classroom.name);
    _turn = 'Matutino';
    _selectedTeachers = widget.classroom.teachers ?? [];
    _selectedStudents = widget.classroom.students ?? [];
    _fetchTeachersAndStudents();
  }

  Future<void> _fetchTeachersAndStudents() async {
    var t = await controller.fetchTeachers();
    var s = await controller.fetchStudents();
    setState(() {
      _allStudents = s;
      _allTeachers = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Editar Turma',
          style: TextStyle(
              color: GiraColors.loginBoxColor, fontFamily: GiraFonts.poorStory),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: GiraColors.loginBoxColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: GiraColors.fields,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _nameController,
                  style: TextStyle(fontFamily: GiraFonts.poorStory),
                  decoration: const InputDecoration(
                    labelText: 'Nome da Turma',
                    labelStyle: TextStyle(
                        color: Colors.grey, fontFamily: GiraFonts.poorStory),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome da turma';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: GiraColors.fields,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  value: _turn,
                  decoration: const InputDecoration(
                    labelText: 'Turno',
                    labelStyle: TextStyle(
                        color: Colors.grey, fontFamily: GiraFonts.poorStory),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Matutino',
                        child: Text(
                          'Matutino',
                          style: TextStyle(fontFamily: GiraFonts.poorStory),
                        )),
                    DropdownMenuItem(
                        value: 'Vespertino',
                        child: Text(
                          'Vespertino',
                          style: TextStyle(fontFamily: GiraFonts.poorStory),
                        )),
                    DropdownMenuItem(
                        value: 'Noturno',
                        child: Text(
                          'Noturno',
                          style: TextStyle(fontFamily: GiraFonts.poorStory),
                        )),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _turn = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () async {
                  final selectedTeachers = await _selectTeachers(context);
                  if (selectedTeachers != null) {
                    setState(() {
                      _selectedTeachers = selectedTeachers;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GiraColors.fields,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: const Text(
                    'Atrelar Professores',
                    style: TextStyle(fontFamily: GiraFonts.poorStory),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final selectedStudents = await _selectStudents(context);
                  if (selectedStudents != null) {
                    setState(() {
                      _selectedStudents = selectedStudents;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GiraColors.fields,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: const Text(
                    'Atrelar Alunos',
                    style: TextStyle(fontFamily: GiraFonts.poorStory),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  _showDeleteConfirmationDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    // border: Border.all(color: Colors.grey),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text('Excluir',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: GiraFonts.poorStory)),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                     Navigator.of(context).pop();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: GiraColors.loginBoxColor),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text('Salvar',
                      style: TextStyle(
                          color: GiraColors.loginBoxColor,
                          fontFamily: GiraFonts.poorStory)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Teacher>?> _selectTeachers(BuildContext context) async {
    return await showDialog<List<Teacher>>(
      context: context,
      builder: (context) {
        final selectedTeachers = List<Teacher>.from(_selectedTeachers);
        return AlertDialog(
          title: _allTeachers.isEmpty
              ? Text('Não há professores cadastrados',
                  style: TextStyle(fontFamily: GiraFonts.poorStory))
              : Text('Selecione Professores',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
          content: SingleChildScrollView(
            child: Column(
              children: _allTeachers.isEmpty
                  ? [Text('-', style: TextStyle(fontFamily: GiraFonts.poorStory))]
                  : _allTeachers.map((teacher) {
                      final isSelected = selectedTeachers.contains(teacher);
                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(teacher.name ?? 'Nome',
                            style: TextStyle(fontFamily: GiraFonts.poorStory)),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedTeachers.add(teacher);
                            } else {
                              selectedTeachers.remove(teacher);
                            }
                          });
                        },
                      );
                    }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancelar',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedTeachers);
              },
              child: const Text('Confirmar',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
            ),
          ],
        );
      },
    );
  }

  Future<List<Student>?> _selectStudents(BuildContext context) async {
    return await showDialog<List<Student>>(
      context: context,
      builder: (context) {
        final selectedStudents = List<Student>.from(_selectedStudents);
        return AlertDialog(
          title: _allStudents.isEmpty
              ? Text('Não há alunos cadastrados',
                  style: TextStyle(fontFamily: GiraFonts.poorStory))
              : Text('Selecione Alunos',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
          content: SingleChildScrollView(
            child: Column(
              children: _allStudents.isEmpty
                  ? [Text('-', style: TextStyle(fontFamily: GiraFonts.poorStory))]
                  : _allStudents.map((student) {
                      final isSelected = selectedStudents.contains(student);
                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(student.name ?? 'Aluno',
                            style: TextStyle(fontFamily: GiraFonts.poorStory)),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedStudents.add(student);
                            } else {
                              selectedStudents.remove(student);
                            }
                          });
                        },
                      );
                    }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text('Cancelar',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedStudents);
              },
              child: const Text('Confirmar',
                  style: TextStyle(fontFamily: GiraFonts.poorStory)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção!', style: TextStyle(fontFamily: GiraFonts.poorStory)),
          content: Text(
              'Tem certeza de que deseja excluir a turma ${widget.classroom.name} permanentemente?', style: TextStyle(fontFamily: GiraFonts.poorStory)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
