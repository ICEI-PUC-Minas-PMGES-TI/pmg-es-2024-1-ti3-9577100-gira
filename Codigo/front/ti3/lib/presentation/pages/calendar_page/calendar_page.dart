import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/presentation/pages/calendar_page/controller/calendar_controller.dart';
import 'package:ti3/presentation/pages/calendar_page/utils.dart';
import 'package:ti3/utils/gira_fonts.dart';

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

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<EventsModel> _getEventsForDay(DateTime day) {
    return allEvents.where((event) => isSameDay(event.date, day)).toList();
  }

  List<EventsModel> _getEventsForRange(DateTime start, DateTime end) {
    return allEvents.where((event) => event.date!.isAfter(start) && event.date!.isBefore(end)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                              const Icon(Icons.circle_outlined, color: Colors.blue, size: 13,),
                              const SizedBox(width: 5,),
                              Text('${event.date}', style: const TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 12),),
                              const Spacer(),
                              InkWell(
                                child: const Icon(Icons.more_horiz,),
                                onTap: () {},
                              )
                            ],
                          ),
                          Text('${event.name}', style: const TextStyle(fontFamily: GiraFonts.poorStory, fontSize: 18),),
                          Text('${event.description}', style: const TextStyle(color: Colors.grey, fontFamily: GiraFonts.poorStory),)
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
