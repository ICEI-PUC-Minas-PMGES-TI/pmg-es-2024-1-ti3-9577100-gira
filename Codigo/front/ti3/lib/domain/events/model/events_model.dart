
import 'package:ti3/domain/classroom/classroom_model.dart';

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
}