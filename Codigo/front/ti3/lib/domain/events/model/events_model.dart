import 'package:ti3/domain/classroom/classroom_model.dart';

class EventCreateModel {
  String? name;
  String? description;
  DateTime? date;
  int? classroom;
  String? author;

  EventCreateModel({
    this.name,
    this.description,
    this.date,
    this.classroom,
    this.author,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'date': date?.toIso8601String(),
      'classroom': classroom,
      'author': author,
    };
  }
}

class EventsModel {
  int? id;
  String? name;
  String? description;
  DateTime? date;
  String? author;
  ClassroomModel? classroom;

  EventsModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.author,
    this.classroom,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date?.toIso8601String(),
      'author': author,
      'classroom': classroom?.toJson(),
    };
  }
}

enum EventActionsEnum {
  createEvent,
  updateEvent,
  deleteEvent,
}
