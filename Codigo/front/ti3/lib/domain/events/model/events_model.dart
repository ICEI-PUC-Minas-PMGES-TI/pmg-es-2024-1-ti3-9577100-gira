
class EventsModel {
  int id;
  String name;
  String description;
  DateTime date;
  String author;
  String classroom; // mudar

  EventsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.author,
    required this.classroom,
  });
}