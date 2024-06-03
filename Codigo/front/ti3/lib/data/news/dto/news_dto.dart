import '../../../domain/news/model/news_model.dart';

extension NewsDto on NewsModel {
  Map<String, dynamic> fromDomain() {
    Map<String, dynamic> map = {};

    map['description'] = description;
    map['image'] = image;

    return map;
  }

  static List<NewsModel> fromListJSON(List<dynamic> json) {
    return json.map((e) => fromJSON(e)).toList();
  }

  static NewsModel fromJSON(Map<String, dynamic> json) {
    final id = json['id'];
    final description = json['description'];
    final image = json['image'];
    final author = json['author'];
    final date = DateTime.parse(json['date']);
    final likes = json['likes'];

    return NewsModel(
      id: id,
      description: description,
      image: image,
      author: author,
      date: date,
      likes: likes,
    );
  }
}