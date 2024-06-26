package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.ClassroomRecord;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Event;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Services.ClassroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/classroom")
public class ClassroomController {
    @Autowired
    private ClassroomService classroomService;

    @PostMapping
    public ResponseEntity<String> createClassroom(@RequestBody ClassroomRecord classroomRecord) {
        boolean created = classroomService.createClassroom(classroomRecord);

        if (created) {
            return ResponseEntity.status(HttpStatus.CREATED).body("Classroom created successfully");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error creating classroom");
        }
    }

    @GetMapping("/find/{classroomId}")
    public ResponseEntity<List<Student>> getClassroomStudents(@PathVariable Long classroomId) {
        List<Student> students = classroomService.getClassroomStudents(classroomId);

        if (!students.isEmpty()) {
            return ResponseEntity.status(HttpStatus.OK).body(students);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

    @PostMapping("/{teacherId}/classroomId/{classroomId}")
    public ResponseEntity<String> addTeacherToClassroom(@PathVariable Long teacherId, @PathVariable Long classroomId) {
        boolean added = classroomService.addTeacherToClassroom(teacherId, classroomId);

        if (added) {
            return ResponseEntity.status(HttpStatus.CREATED).body("Teacher added to classroom successfully");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error adding teacher to classroom");
        }
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateClassroom(@PathVariable Long id) {
        classroomService.activateClassroom(id);
        return ResponseEntity.ok("Classroom activated successfully");
    }

    @GetMapping
    public ResponseEntity<List<Classroom>> getActiveClassrooms() {
        List<Classroom> activeClassrooms = classroomService.getActiveClassrooms();
        return ResponseEntity.ok(activeClassrooms);
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<Classroom> getActiveClassroomById(@PathVariable Long id) {
        Optional<Classroom> classroomOptional = classroomService.getActiveClassroomById(id);
        return classroomOptional.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deactivateClassroom(@PathVariable Long id) {
        classroomService.deactivateClassroom(id);
        return ResponseEntity.ok("Classroom deactivated successfully");
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateClassroom(@PathVariable Long id, @RequestBody Classroom classroomRecord) {
        classroomService.updateClassroom(id, classroomRecord);
        return ResponseEntity.ok("Classroom updated successfully");
    }

    @PostMapping("/{classroomId}/addStudent/{studentId}")
    public ResponseEntity<String> addStudentToClassroom(@PathVariable Long classroomId, @PathVariable Long studentId) {
        boolean added = classroomService.addStudentToClassroom(classroomId, studentId);
        if (added) {
            return ResponseEntity.status(HttpStatus.OK).body("Student added to classroom successfully");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to add student to classroom");
        }
    }

    @PostMapping("/{classroomId}/events")
    public ResponseEntity<String> addEventIdsToClassroom(
            @PathVariable Long classroomId,
            @RequestBody List<Long> eventIds) {
        try {
            classroomService.addEventIdsToClassroom(classroomId, eventIds);
            return ResponseEntity.ok("Events added successfully.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{classroomId}/events")
    public ResponseEntity<String> removeEventIdsFromClassroom(
            @PathVariable Long classroomId,
            @RequestBody List<Long> eventIds) {
        try {
            classroomService.removeEventIdsFromClassroom(classroomId, eventIds);
            return ResponseEntity.ok("Events removed successfully.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/events/{classroomId}")
    public ResponseEntity<List<Event>> getEventsByClassroomId(@PathVariable Long classroomId) {
        List<Event> events = classroomService.getEventsByClassroomId(classroomId);
        return ResponseEntity.ok().body(events);
    }

}
