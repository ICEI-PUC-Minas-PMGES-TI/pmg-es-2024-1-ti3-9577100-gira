enum NotificationStatus { read, unread }

class NotificationModel {
  int id;
  String message;
  DateTime date;
  String author;
  NotificationStatus status;

  NotificationModel({
    required this.id,
    required this.message,
    required this.date,
    required this.author,
    required this.status,
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