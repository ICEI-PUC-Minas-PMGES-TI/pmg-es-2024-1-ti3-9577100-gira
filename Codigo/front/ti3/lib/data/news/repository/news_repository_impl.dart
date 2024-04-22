import 'package:ti3/data/news/dto/news_dto.dart';
import 'package:ti3/data/utils/base_repository.dart';
import 'package:ti3/domain/news/model/news_model.dart';
import 'package:ti3/domain/news/repository/news_repository.dart';

import '../../../domain/utils/result.dart';
import '../datasource/news_datasource.dart';

class NewsRepositoryImpl extends BaseRepository implements NewsRepository {
  final NewsDatasource _datasource;

  NewsRepositoryImpl(this._datasource);

  @override
  Future<Result<NewsModel, Exception>> createNews(NewsModel newsModel) async {
    try {
      final response = await _datasource.createNews(newsModel.fromDomain());
      final result = NewsDto.fromJSON(response);
      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }

  @override
  Future<Result<List<NewsModel>, Exception>> getNews() async {
    try {
      final response = await _datasource.getNews();
      final result = NewsDto.fromListJSON(response);
      return Result.success(result);
    } catch (e) {
      return handleFailure(error: e);
    }
  }

  @override
  Future<Result<void, Exception>> deleteNews(int id) async {
    try {
      await _datasource.deleteNews(id);
      return Result.success(null);
    } catch (e) {
      return handleFailure(error: e);
    }
  }
}