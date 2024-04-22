import 'package:ti3/domain/news/model/news_model.dart';

import '../../utils/result.dart';

abstract class NewsRepository {
  Future<Result<NewsModel, Exception>> createNews(NewsModel newsModel);
  Future<Result<List<NewsModel>, Exception>> getNews();
  Future<Result<void, Exception>> deleteNews(int id);
}