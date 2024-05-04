import 'package:ti3/domain/events/model/events_model.dart';

extension EventsDTO on EventsModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    final month = dateTime.month > 9 ? "${dateTime.month}" : "0${dateTime.month}";
    final day = dateTime.day > 9 ? "${dateTime.day}" : "0${dateTime.day}";
    final hour = dateTime.hour;
    final minutes = dateTime.minute;

    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['author'] = author;
    map['classroom'] = classroom;
    map['dateTime'] = "${dateTime.year}-$month-$day-$hour-$minutes";

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
      title: title,
      author: author,
      dateTime: dateTime,
      classroom: classroom,
    );
  }
}