import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/context/current_user.dart';
import 'package:ti3/domain/news/use_cases/create_news.dart';
import 'package:ti3/presentation/pages/feed_page/controller/feed_controller.dart';

import '../../../../domain/news/model/news_model.dart';

part 'publication_controller.g.dart';

class PublicationController = PublicationControllerStore with _$PublicationController;

abstract class PublicationControllerStore with Store {

  final CreateNews _createNews;

  PublicationControllerStore(this._createNews);

  @observable
  TextEditingController descriptionController = TextEditingController();

  @observable
  String image = '';

  @action
  void reset() {
    descriptionController.clear();
  }

  void publish() async {
    final controller = Get.find<FeedController>();

    await _createNews(
      NewsModel(
        description: descriptionController.text,
        image: image,
        author: CurrentUser().name ?? "",
        date: DateTime.now(),
        id: 0,
        likes: 0,
      )
    );

    descriptionController.clear();
    image = '';

    controller.reload();
  }

}