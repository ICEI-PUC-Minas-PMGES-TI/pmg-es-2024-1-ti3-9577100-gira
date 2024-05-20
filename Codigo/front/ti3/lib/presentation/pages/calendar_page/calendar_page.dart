import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/presentation/pages/calendar_page/controller/calendar_controller.dart';
import 'package:ti3/presentation/pages/calendar_page/utils.dart';
import 'package:ti3/presentation/pages/calendar_page/widgets/event_item.dart';
import 'package:ti3/shared/widgets/paths.dart';
import 'package:ti3/utils/gira_colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<EventsModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final controller = CalendarController();
  List<EventsModel> allEvents = [];

  @override
  void initState() {
    super.initState();
    _getAllEvents();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _getAllEvents() async {
    allEvents = await controller.getEvents();
  }

  void _createEvent() async {}

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<EventsModel> _getEventsForDay(DateTime day) {
    return allEvents.where((event) => isSameDay(event.date, day)).toList();
  }

  List<EventsModel> _getEventsForRange(DateTime start, DateTime end) {
    return allEvents.where( (event) => event.date!.isAfter(start) && event.date!.isBefore(end)).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void _deleteEvent(int eventId) async {
    try {
      final success = await controller.deleteEvent(eventId);
      if (success) {
        _getAllEvents();
      } else {
        Get.snackbar(
          'Erro',
          'Falha ao excluir o evento.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Erro ao excluir o evento: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              TableCalendar<EventsModel>(
                availableCalendarFormats: const {
                  CalendarFormat.month: 'mês',
                  CalendarFormat.week: 'semana',
                  CalendarFormat.twoWeeks: '2 semanas',
                },
                locale: Localizations.localeOf(context).languageCode,
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<EventsModel>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final event = value[index];
                        return EventItem(event: event, onDeleteEvent: _deleteEvent);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          CurrentUserManager.currentUser.type != UserTypeEnum.parents ?
          Positioned(
            top: 590,
            left: 320,
            child: InkWell(
              onTap: () {
                Get.toNamed(Paths.eventPage, arguments: {'isUpdate': false});
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: GiraColors.loginBoxColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
