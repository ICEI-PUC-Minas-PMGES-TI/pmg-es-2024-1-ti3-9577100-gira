class NewsModel {
  int? id;
  String? description;
  DateTime? date;
  String? image;
  String? author;
  int? likes;

  NewsModel({
    this.id,
    this.description,
    this.image,
    this.author,
    this.date,
    this.likes,
  });

  String getTime() {
    final now = DateTime.now();
    if (date != null) {
      final difference = now.difference(date!);
      if (difference.inDays > 0) {
        return '${difference.inDays} dias';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} horas';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutos';
      } else {
        return '${difference.inSeconds} segundos';
      }
    } else {
      return '';
    }
  }

  static NewsModel fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int?,
      description: json['description'] as String?,
      date: DateTime.parse(json['date'] as String),
      image: json['image'] as String?,
      author: json['author'] as String?,
      likes: json['likes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'date': date?.toIso8601String(),
      'image': image,
      'author': author,
      'likes': likes,
    };
  }
}
