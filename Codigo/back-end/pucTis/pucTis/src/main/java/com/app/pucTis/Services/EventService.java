package com.app.pucTis.Services;

import com.app.pucTis.Dtos.EventRecord;
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

    @Autowired
    public EventService(EventRepository eventRepository,
                        SchoolClassRepository classRepository,
                        AuthenticationService authenticationService) {
        this.eventRepository = eventRepository;
        this.classRepository = classRepository;
        this.authenticationService = authenticationService;
    }

    public Event create(EventRecord eventRecord) {
        Object authenticatedUser = authenticationService.getAuthenticatedUser();
        authenticationService.validateAuthorizedUser(authenticatedUser);

        Long classroomId = eventRecord.classroom().getId();
        Classroom classroom = classRepository.findById(classroomId)
                .orElseThrow(() -> new SaveNewsException("Classroom ID is invalid"));

        Event event = new Event(eventRecord);
        event.setClassrooms(classroom);
        event.setAuthor(getAuthorName(authenticatedUser));

        return saveEvent(event);
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

