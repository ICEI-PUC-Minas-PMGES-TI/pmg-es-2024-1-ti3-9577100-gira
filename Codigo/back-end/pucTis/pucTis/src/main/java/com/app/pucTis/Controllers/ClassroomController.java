package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.ClassroomRecord;
import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Services.ClassroomService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
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

    @GetMapping
    public ResponseEntity<List<Classroom>> getAllClassrooms() {
        List<Classroom> classrooms = classroomService.getAllClassrooms();

        if (!classrooms.isEmpty()) {
            return ResponseEntity.status(HttpStatus.OK).body(classrooms);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
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

    @PostMapping("/{classroomId}/student/{studentId}")
    public ResponseEntity<String> addStudentToClassroom(@PathVariable Long classroomId, @PathVariable Long studentId) {
        boolean added = classroomService.addStudentToClassroom(classroomId, studentId);

        if (added) {
            return ResponseEntity.status(HttpStatus.CREATED).body("Student added to classroom successfully");
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Error adding student to classroom");
        }
    }
}
