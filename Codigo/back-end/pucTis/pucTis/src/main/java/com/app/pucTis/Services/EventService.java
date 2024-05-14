package com.app.pucTis.Services;

import com.app.pucTis.Dtos.EventRecord;
import com.app.pucTis.Dtos.EventRecordWithClassrooms;
import com.app.pucTis.Entities.*;
import com.app.pucTis.Exceptions.SaveNewsException;
import com.app.pucTis.Repositories.EventRepository;
import com.app.pucTis.Repositories.SchoolClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ExpressionException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class EventService {
    private final EventRepository eventRepository;
    private final SchoolClassRepository classRepository;
    private final AuthenticationService authenticationService;
    private final ParentsService parentsService;

    @Autowired
    public EventService(EventRepository eventRepository,
                        SchoolClassRepository classRepository,
                        AuthenticationService authenticationService,
                        ParentsService parentsService) {
        this.eventRepository = eventRepository;
        this.classRepository = classRepository;
        this.authenticationService = authenticationService;
        this.parentsService = parentsService;
    }

    public Event create(EventRecord eventRecord) {
//        Object authenticatedUser = authenticationService.getAuthenticatedUser();
//        authenticationService.validateAuthorizedUser(authenticatedUser);

        Long classroomId = eventRecord.classroom().getId();
        Classroom classroom = classRepository.findById(classroomId)
                .orElseThrow(() -> new SaveNewsException("Classroom ID is invalid"));

        Event event = new Event(eventRecord);
        event.setClassrooms(classroom);
        //event.setAuthor(getAuthorName(authenticatedUser));

        return saveEvent(event);
    }

    public List<Event> createEventsForClassrooms(EventRecordWithClassrooms eventRecordWithClassrooms) {
        List<Long> classroomIds = eventRecordWithClassrooms.classroomIds();
        List<Event> createdEvents = classroomIds.stream()
                .map(classroomId -> {
                    Classroom classroom = classRepository.findById(classroomId)
                            .orElseThrow(() -> new SaveNewsException("Classroom ID is invalid"));

                    EventRecord eventRecord = new EventRecord(
                            eventRecordWithClassrooms.id(),
                            eventRecordWithClassrooms.name(),
                            eventRecordWithClassrooms.description(),
                            eventRecordWithClassrooms.date(),
                            eventRecordWithClassrooms.author(),
                            classroom
                    );

                    return create(eventRecord);
                })
                .collect(Collectors.toList());

        return createdEvents;
    }

    private String getAuthorName(Object user) {
        if (user instanceof Administrator) {
            return ((Administrator) user).getName();
        } else if (user instanceof Teacher) {
            return ((Teacher) user).getName();
        } else if (user instanceof Parents) {
            return ((Parents) user).getName();
        }
        return null;
    }

    private Event saveEvent(Event event) {
        try {
            return eventRepository.save(event);
        } catch (Exception e) {
            throw new SaveNewsException("Failed to save event in the database", e);
        }
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id)
                .orElseThrow(() -> new ExpressionException("Event not found with id: " + id));
    }

    public List<Event> getAllEvents() {
        return eventRepository.findAll();
    }

    public List<Event> getEventsByClassroom(Long classroomId) {
        return eventRepository.findByClassroomId(classroomId);
    }

   // public List<Event> getEventsForParent(Long parentId) {
       // Long classroomId = parentsService.getClassroomIdByParent(parentId);
     //   return eventRepository.findByClassroomId(classroomId);
   // }

    public Event updateEvent(Long id, Event updatedEvent) {
        Event existingEvent = getEventById(id);
        existingEvent.setName(updatedEvent.getName());
        existingEvent.setDescription(updatedEvent.getDescription());
        existingEvent.setDate(updatedEvent.getDate());
        existingEvent.setAuthor(updatedEvent.getAuthor());
        existingEvent.setClassrooms(updatedEvent.getClassroom());
        return eventRepository.save(existingEvent);
    }

    public void deleteEvent(Long id) {
        Event existingEvent = getEventById(id);
        eventRepository.delete(existingEvent);
    }
}

