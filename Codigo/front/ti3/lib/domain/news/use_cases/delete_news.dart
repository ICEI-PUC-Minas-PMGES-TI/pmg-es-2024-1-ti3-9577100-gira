import 'package:ti3/domain/news/repository/news_repository.dart';

import '../../utils/result.dart';

class DeleteNews {
  final NewsRepository _repository;

  DeleteNews(this._repository);

  Future<Result<void, Exception>> call(int id) async =>
      await _repository.deleteNews(id);
}
