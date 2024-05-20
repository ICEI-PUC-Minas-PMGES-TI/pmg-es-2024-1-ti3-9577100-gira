import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/utils/gira_fonts.dart';

class EventItem extends StatelessWidget {
  final EventsModel event;
  final void Function(int id) onDeleteEvent;

  const EventItem({super.key, required this.event, required this.onDeleteEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.circle_outlined,
                color: Colors.blue,
                size: 13,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${formatDate(event.date!)} - ${event.author}',
                style: const TextStyle(
                    fontFamily: GiraFonts.poorStory, fontSize: 12),
              ),
              const Spacer(),
              CurrentUserManager.currentUser.type == UserTypeEnum.parents 
              ? Container() :
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Update',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Excluir'),
                    ),
                  ];
                },
                onSelected: (String value) {
                  if (value == 'Update') {
                    try {
                      Get.toNamed(Paths.eventPage, arguments: {
                        'isUpdate': true,
                        'eventToUpdate': event
                      });
                    } catch (E) {
                      print(E);
                    }
                  } else if (value == 'Delete') {
                    _showDeleteConfirmationDialog(event, context);
                  }
                },
              ),
            ],
          ),
          Text(
            '${event.name}',
            style:
                const TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 18),
          ),
          Text(
            '${event.description}',
            style: const TextStyle(
                color: Colors.grey, fontFamily: GiraFonts.poorStory),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(EventsModel event, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção!'),
          content: Text(
              'Tem certeza de que deseja excluir o evento ${event.name} permanentemente?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                onDeleteEvent(event.id!);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  String formatDate(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  String month = date.month.toString().padLeft(2, '0');
  String year = date.year.toString();
  
  return '$day/$month/$year';
}
}
