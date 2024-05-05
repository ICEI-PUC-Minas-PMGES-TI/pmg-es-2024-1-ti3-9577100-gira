import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/data/api/dio_client.dart';
import 'package:ti3/data/events/events_dto.dart';
import 'package:ti3/domain/events/model/events_model.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerStore with _$CalendarController;

abstract class CalendarControllerStore extends DisposableInterface with Store {
  @observable
  List<EventsModel> events = ObservableList<EventsModel>();
  final DioClient client = DioClient();
  List<String> feedItems = [];

  @action
  Future<List<EventsModel>> getEvents() async {
    try {
      final response = await client.dio.get('http://192.168.0.31:8080/event');
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        List<EventsModel> fetchedEvents = EventsDTO.fromListJSON(data);
        events.clear(); 
        events.addAll(fetchedEvents); 
        return fetchedEvents;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error fetching events: $e');
      rethrow;
    }
  }
}


