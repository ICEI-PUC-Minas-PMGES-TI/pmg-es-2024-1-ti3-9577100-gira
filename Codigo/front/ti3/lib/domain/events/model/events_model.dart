import 'package:ti3/domain/login/model/user_model.dart';

class EventsModel {
  int id;
  String title;
  String description;
  DateTime dateTime;
  UserModel author;
  String classroom; // mudar

  EventsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.author,
    required this.classroom,
  });
}