package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.EventRecord;
import com.app.pucTis.Dtos.EventRecordWithClassrooms;
import com.app.pucTis.Entities.Event;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Services.AuthenticationService;
import com.app.pucTis.Services.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/event")
public class EventController {
    @Autowired
    private EventService eventService;
    private AuthenticationService authenticationService;

    @PostMapping
    public ResponseEntity<Event> createEvent(
            @RequestBody EventRecord eventRecord) {
        System.out.println("EventRecord recebido: " + eventRecord);

        Event event = eventService.create(eventRecord);
        return ResponseEntity.status(HttpStatus.CREATED).body(event);
    }

    @PostMapping("/various")
    public ResponseEntity<List<Event>> createEvents(@RequestBody EventRecordWithClassrooms eventRecordWithClassrooms) {
        List<Event> createdEvents = eventService.createEventsForClassrooms(eventRecordWithClassrooms);
        return new ResponseEntity<>(createdEvents, HttpStatus.CREATED);
    }

    @GetMapping("/events_classroom/{classroomId}")
    public ResponseEntity<List<Event>> getEventsByClassroom(@PathVariable Long classroomId) {
        List<Event> events = eventService.getEventsByClassroom(classroomId);
        return ResponseEntity.ok(events);
    }
/**
   // @GetMapping("/parent")
    public ResponseEntity<List<Event>> getEventsForParent() {
        Object authenticatedUser = authenticationService.getAuthenticatedUser();

        if (!(authenticatedUser instanceof Parents)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body(null);
        }

        Parents parents = (Parents) authenticatedUser;
        Long parentId = parents.getId();

        List<Event> events = eventService.getEventsForParent(parentId);
        return ResponseEntity.ok(events);
    }**/


    @GetMapping("/{id}")
    public ResponseEntity<Event> getEventById(@PathVariable Long id) {
        Event event = eventService.getEventById(id);
        return ResponseEntity.ok(event);
    }

    @GetMapping
    public ResponseEntity<List<Event>> getAllEvents() {
        List<Event> events = eventService.getAllEvents();
        return ResponseEntity.ok(events);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Event> updateEvent(@PathVariable Long id, @RequestBody Event updatedEvent) {
        Event event = eventService.updateEvent(id, updatedEvent);
        return ResponseEntity.ok(event);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }





}
