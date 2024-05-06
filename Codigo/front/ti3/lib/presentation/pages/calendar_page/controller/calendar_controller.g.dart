// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarController on CalendarControllerStore, Store {
  late final _$eventsAtom =
      Atom(name: 'CalendarControllerStore.events', context: context);

  @override
  List<EventsModel> get events {
    _$eventsAtom.reportRead();
    return super.events;
  }

  @override
  set events(List<EventsModel> value) {
    _$eventsAtom.reportWrite(value, super.events, () {
      super.events = value;
    });
  }

  late final _$titleControllerAtom =
      Atom(name: 'CalendarControllerStore.titleController', context: context);

  @override
  TextEditingController get titleController {
    _$titleControllerAtom.reportRead();
    return super.titleController;
  }

  @override
  set titleController(TextEditingController value) {
    _$titleControllerAtom.reportWrite(value, super.titleController, () {
      super.titleController = value;
    });
  }

  late final _$descriptionControllerAtom = Atom(
      name: 'CalendarControllerStore.descriptionController', context: context);

  @override
  TextEditingController get descriptionController {
    _$descriptionControllerAtom.reportRead();
    return super.descriptionController;
  }

  @override
  set descriptionController(TextEditingController value) {
    _$descriptionControllerAtom.reportWrite(value, super.descriptionController,
        () {
      super.descriptionController = value;
    });
  }

  late final _$selectedDateAtom =
      Atom(name: 'CalendarControllerStore.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$dateControllerAtom =
      Atom(name: 'CalendarControllerStore.dateController', context: context);

  @override
  DateTime get dateController {
    _$dateControllerAtom.reportRead();
    return super.dateController;
  }

  @override
  set dateController(DateTime value) {
    _$dateControllerAtom.reportWrite(value, super.dateController, () {
      super.dateController = value;
    });
  }

  late final _$getEventsAsyncAction =
      AsyncAction('CalendarControllerStore.getEvents', context: context);

  @override
  Future<List<EventsModel>> getEvents() {
    return _$getEventsAsyncAction.run(() => super.getEvents());
  }

  late final _$createEventAsyncAction =
      AsyncAction('CalendarControllerStore.createEvent', context: context);

  @override
  Future<bool> createEvent(EventCreateModel eventModel) {
    return _$createEventAsyncAction.run(() => super.createEvent(eventModel));
  }

  @override
  String toString() {
    return '''
events: ${events},
titleController: ${titleController},
descriptionController: ${descriptionController},
selectedDate: ${selectedDate},
dateController: ${dateController}
    ''';
  }
}
