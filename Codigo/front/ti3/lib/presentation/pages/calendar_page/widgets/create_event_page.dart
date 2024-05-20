import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/presentation/pages/calendar_page/controller/calendar_controller.dart';
import 'package:ti3/utils/gira_colors.dart';

class CreateEventPage extends StatefulWidget {
  @override
  CreateEventPageState createState() => CreateEventPageState();
}

class CreateEventPageState extends State<CreateEventPage> {
  final isUpdate = Get.arguments != null ? Get.arguments['isUpdate'] : false;
  final eventToUpdate =
      Get.arguments != null ? Get.arguments['eventToUpdate'] : null;

  final CalendarController calendarController = CalendarController();
  TextEditingController textController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (calendarController.eventToUpdate.name != null) {
      calendarController.eventToUpdate = eventToUpdate;
      calendarController.titleController.text = eventToUpdate.name ?? '';
      calendarController.descriptionController.text = eventToUpdate.description ?? '';
      calendarController.selectedDate = eventToUpdate.date ?? DateTime.now();
    }
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: calendarController.selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          pickedDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          calendarController.selectedDate = pickedDate;
        });
      }
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data do Evento:',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () => _selectDateAndTime(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: GiraColors.fields,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    isUpdate ? _updateEvent() : _createEvent();
                    Navigator.pop(context);
                  },
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
    updateEvent.date = calendarController.selectedDate;
    calendarController.updateEvent(updateEvent);
  }

  void _createEvent() async {
    EventCreateModel newEvent = EventCreateModel(
        name: calendarController.titleController.text,
        description: calendarController.descriptionController.text,
        date: calendarController.selectedDate,
        author: CurrentUserManager.currentUser.name,
        classroom: 1);
    calendarController.createEvent(newEvent);
  }
}
