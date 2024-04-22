import 'package:ti3/domain/news/model/news_model.dart';
import 'package:ti3/domain/news/repository/news_repository.dart';

import '../../utils/result.dart';

class CreateNews {
  final NewsRepository _repository;

  CreateNews(this._repository);

  Future<Result<NewsModel, Exception>> call(NewsModel newsModel) async =>
      await _repository.createNews(newsModel);
}
