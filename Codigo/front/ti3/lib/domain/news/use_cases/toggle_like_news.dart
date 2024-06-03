import 'package:ti3/domain/news/repository/news_repository.dart';

import '../../utils/result.dart';

class ToggleLikeNews {
  final NewsRepository _repository;

  ToggleLikeNews(this._repository);

  Future<Result<void, Exception>> call(int id) async =>
      await _repository.toggleLikeNews(id);
}
