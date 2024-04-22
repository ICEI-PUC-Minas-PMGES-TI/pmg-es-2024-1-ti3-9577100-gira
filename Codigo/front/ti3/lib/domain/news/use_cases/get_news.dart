import 'package:ti3/domain/news/model/news_model.dart';
import 'package:ti3/domain/news/repository/news_repository.dart';

import '../../utils/result.dart';

class GetNews {
  final NewsRepository _repository;

  GetNews(this._repository);

  Future<Result<List<NewsModel>, Exception>> call() async =>
      await _repository.getNews();
}
