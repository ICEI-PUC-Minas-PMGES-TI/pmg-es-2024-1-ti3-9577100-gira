class NewsModel {
  int id;
  String description;
  String image;
  String author;
  DateTime date;
  int likes;

  NewsModel({
    required this.id,
    required this.description,
    required this.image,
    required this.author,
    required this.date,
    required this.likes,
  });

  String getTime() {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 0) {
      return '${difference.inDays} dias';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos';
    } else {
      return '${difference.inSeconds} segundos';
    }
  }
}