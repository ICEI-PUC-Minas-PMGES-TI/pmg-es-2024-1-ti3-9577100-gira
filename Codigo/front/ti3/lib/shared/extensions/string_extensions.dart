import 'package:mime/mime.dart';

extension CustomExtension on String {
  String? get toFileExtension {
    final mimeType = lookupMimeType(this);
    if (mimeType == null) return null;
    return mimeType.split("/").last;
  }
}
