import 'package:ti3/domain/classroom/classroom_model.dart';
import 'package:ti3/domain/events/model/events_model.dart';

extension EventsDTO on EventsModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    final month = date!.month > 9 ? "${date!.month}" : "0${date!.month}";
    final day = date!.day > 9 ? "${date!.day}" : "0${date!.day}";
    final hour = date!.hour;
    final minutes = date!.minute;

    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['author'] = author;
    map['classroom'] = classroom;
    map['dateTime'] = "${date!.year}-$month-$day-$hour-$minutes";

    return map;
  }

  static List<EventsModel> fromListJSON(List<dynamic> json) {
    return json.map((e) => fromJSON(e)).toList();
  }

 static EventsModel fromJSON(Map<String, dynamic> json) {
  return EventsModel(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    date: DateTime.parse(json['date'] as String),
    author: json['author'] as String,
    classroom: ClassroomModel.fromJson(json['classroom'] as Map<String, dynamic>),
  );
}

}
