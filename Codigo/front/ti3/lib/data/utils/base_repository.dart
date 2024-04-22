
import 'package:ti3/data/utils/exceptions/unknown_exception.dart';
import 'package:ti3/data/utils/extensions/exception_extension.dart';

import '../../domain/utils/result.dart';

abstract class BaseRepository {
  Result<T, Exception> handleFailure<T>({
    dynamic error,
    StackTrace? trace,
  }) {
    if (error is Exception) {
      error.debugPrint();
      return Result.failure(error);
    } else {
      var unknownException = UnknownException();
      unknownException.debugPrint();
      return Result.failure(unknownException);
    }
  }
}