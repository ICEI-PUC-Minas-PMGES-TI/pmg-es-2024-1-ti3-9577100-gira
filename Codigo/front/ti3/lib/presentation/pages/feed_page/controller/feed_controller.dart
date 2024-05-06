import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/news/model/news_model.dart';
import '../../../../domain/news/use_cases/delete_news.dart';
import '../../../../domain/news/use_cases/get_news.dart';

part 'feed_controller.g.dart';

class FeedController = FeedControllerStore with _$FeedController;

abstract class FeedControllerStore extends DisposableInterface with Store {
  final GetNews _getNews;
  final DeleteNews _deleteNews;

  FeedControllerStore({
    required GetNews getNews,
    required DeleteNews deleteNews
  }) : _getNews = getNews,
        _deleteNews = deleteNews;

  final _atom = Atom();

  @observable
  TextEditingController descriptionController = TextEditingController();

  @observable
  String image = '';

  @observable
  List<NewsModel> feedItems = [];

  @override
  void onInit() async {
    await getNews();
    super.onInit();
  }

  Future<void> getNews() async {
    final result = await _getNews();

    result.processResult(
        onSuccess: (List<NewsModel> result) {
          result.sort((a, b) => b.date!.compareTo(a.date!));
          feedItems = result;
        },
        onFailure: (Exception e) {
          feedItems = [];
        }
    );

    _atom.reportChanged();
  }

  Future<void> deleteNews(int id) async {
    await _deleteNews(id);
    await getNews();
  }

  @action
  void reset() {
    descriptionController.clear();
  }

  @action
  void reload() {
    getNews();
  }
}