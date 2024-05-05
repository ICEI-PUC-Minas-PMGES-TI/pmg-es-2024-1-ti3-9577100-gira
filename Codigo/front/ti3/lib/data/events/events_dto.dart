import 'package:ti3/domain/events/model/events_model.dart';

extension EventsDTO on EventsModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    final month = date.month > 9 ? "${date.month}" : "0${date.month}";
    final day = date.day > 9 ? "${date.day}" : "0${date.day}";
    final hour = date.hour;
    final minutes = date.minute;

    map['id'] = id;
    map['title'] = name;
    map['description'] = description;
    map['author'] = author;
    map['classroom'] = classroom;
    map['dateTime'] = "${date.year}-$month-$day-$hour-$minutes";

    return map;
  }

  static List<EventsModel> fromListJSON(List<dynamic> json) {
    return json.map((e) => fromJSON(e)).toList();
  }

  static EventsModel fromJSON(Map<String, dynamic> json) {
    final id = json['id'];
    final description = json['description'];
    final title = json['title'];
    final author = json['author'];
    final dateTime = DateTime.parse(json['dateTime']);
    final classroom = json['classroom'];

    return EventsModel(
      id: id,
      description: description,
      name: title,
      author: author,
      date: dateTime,
      classroom: classroom,
    );
  }
}