import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerStore with _$CalendarController;

abstract class CalendarControllerStore extends DisposableInterface with Store {
  @observable
  List<String> feedItems = [];
}