import 'package:ti3/domain/login/model/user_model.dart';

class AlbumDTO {
  String? name;
  String? description;
  UserModel? author;
  DateTime? date;
  List<String>? photos;

  AlbumDTO({
    this.name,
    this.description,
    this.author,
    this.date,
    this.photos
  });
}