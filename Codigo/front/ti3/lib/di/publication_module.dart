import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ti3/domain/news/use_cases/create_news.dart';
import 'package:ti3/presentation/pages/publication_page/controller/publication_controller.dart';

class PublicationModule extends Bindings {
  PublicationModule();

  @override
  void dependencies() {
    Get.lazyPut(() =>PublicationController(CreateNews(GetIt.I())));
  }
}
