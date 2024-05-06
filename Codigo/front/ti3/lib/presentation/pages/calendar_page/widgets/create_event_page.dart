import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/presentation/pages/calendar_page/controller/calendar_controller.dart';
import 'package:ti3/utils/gira_colors.dart';

class CreateEventPage extends StatefulWidget {
  @override
  CreateEventPageState createState() => CreateEventPageState();
}

class CreateEventPageState extends State<CreateEventPage> {
  final isUpdate = Get.arguments != null ? Get.arguments['isUpdate'] : false;
  final eventToUpdate = Get.arguments != null ? Get.arguments['eventToUpdate'] : null;

  final CalendarController calendarController = CalendarController();
  TextEditingController textController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        pickedDate = picked;
        calendarController.dateController = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: GiraColors.loginBoxColor,
        title: isUpdate
            ? const Text('Editar Evento')
            : const Text('Cadastrar Novo Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Título',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: calendarController.titleController,
                decoration: const InputDecoration(
                  label: Text(
                    'Informe um título. . .',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descrição',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: GiraColors.fields,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: calendarController.descriptionController,
                decoration: const InputDecoration(
                  label: Text(
                    'Digite uma descrição...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data do Evento:',
                  style: TextStyle(color: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    // ignore: unnecessary_null_comparison
                    calendarController.selectedDate != null
                        ? '${calendarController.selectedDate.day}/${calendarController.selectedDate.month}/${calendarController.selectedDate.year}'
                        : 'Selecionar Data',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => isUpdate ? _updateEvent() : _createEvent(),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: GiraColors.loginBoxColor),
                    ),
                    minimumSize: const Size(300, 50),
                  ),
                  child: const Text(
                    'Concluir',
                    style: TextStyle(
                        color: GiraColors.loginBoxColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateEvent() async {
    var updateEvent = eventToUpdate;
    updateEvent.name = calendarController.titleController.text;
    updateEvent.description = calendarController.descriptionController.text;
    calendarController.updateEvent(updateEvent);
  }

  void _createEvent() async {
    EventCreateModel newEvent = EventCreateModel(
        name: calendarController.titleController.text,
        description: calendarController.descriptionController.text,
        date: calendarController.dateController ?? DateTime.now(),
        author: 'Jubiscreia',
        classroom: 1);
    calendarController.createEvent(newEvent);
  }
}
