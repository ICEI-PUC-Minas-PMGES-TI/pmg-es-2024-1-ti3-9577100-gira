import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:ti3/data/api/dio_client.dart';
import 'package:ti3/data/events/events_dto.dart';
import 'package:ti3/domain/events/model/events_model.dart';
import 'package:ti3/shared/statics/endpoints.dart';

part 'calendar_controller.g.dart';

class CalendarController = CalendarControllerStore with _$CalendarController;

abstract class CalendarControllerStore extends DisposableInterface with Store {

  final DioClient client = DioClient();
  final String door = Endpoints.baseUrl;

  List<String> feedItems = [];

   @observable
  List<EventsModel> events = ObservableList<EventsModel>();

  @observable
  TextEditingController titleController = TextEditingController();
  @observable
  TextEditingController descriptionController = TextEditingController();

  @observable
  DateTime selectedDate = DateTime.now(); 

  EventsModel eventToUpdate = EventsModel();
  

  @action
  Future<List<EventsModel>> getEvents() async {
    try {
      final response = await client.dio.get('$door''event');
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        List<EventsModel> fetchedEvents = EventsDTO.fromListJSON(data);
        events.clear();
        events.addAll(fetchedEvents);
        events = fetchedEvents;
        return fetchedEvents;
      } else {
        throw Exception('Falha ao carregar eventos.');
      }
    } catch (e) {
      print('Erro ao carregar eventos: $e');
      rethrow;
    }
  }

  @action
  Future<bool> createEvent(EventCreateModel eventModel) async {
    try {
      final response = await client.dio.post(
        '$door''event',
        data: eventModel.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro ao criar evento: $e');
      rethrow;
    }
  }

  @action
  Future<bool> updateEvent(EventsModel updatedEvent) async {
    try {
      final response = await client.dio.put(
        '$door''event${updatedEvent.id}',
        data: updatedEvent.toJson(),
      );
      if (response.statusCode == 200) {
        int index = events.indexWhere((event) => event.id == updatedEvent.id);
        if (index != -1) {
          events[index] = updatedEvent;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro ao atualizar evento: $e');
      rethrow;
    }
  }

  @action
  Future<bool> deleteEvent(int eventId) async {
    try {
      final response = await client.dio.delete(
        '$door''event/''$eventId',
      );
      if (response.statusCode == 204) {
        events.removeWhere((event) => event.id == eventId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro ao excluir evento: $e');
      rethrow;
    }
  }

  @action
  void _updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }
}
