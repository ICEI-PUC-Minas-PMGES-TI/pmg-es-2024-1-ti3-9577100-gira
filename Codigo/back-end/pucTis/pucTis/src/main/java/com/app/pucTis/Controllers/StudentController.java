package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Services.StudentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentService studentService;

    @PostMapping
    ResponseEntity<Student> registerStudent(@RequestBody @Valid StudentRecord newStudent) {
        Student student = studentService.createStudent(newStudent);
        return new ResponseEntity<>(student, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Student>> getAllActiveStudents() {
        List<Student> students = studentService.getActiveStudents();
        return ResponseEntity.status(HttpStatus.OK).body(students);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteStudent(@PathVariable Long id) {
        try {
            studentService.deleteStudent(id);
            return ResponseEntity.status(HttpStatus.OK).body("Student successfully deactivated");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<?> getStudentById(@PathVariable Long id) {
        Optional<Student> studentOptional = studentService.getStudentById(id);
        if (studentOptional.isPresent()) {
            return ResponseEntity.status(HttpStatus.OK).body(studentOptional.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Student not found or inactive");
        }
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateStudent(@PathVariable Long id) {
        try {
            studentService.activateStudent(id);
            return ResponseEntity.status(HttpStatus.OK).body("Student successfully activated");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateStudent(@PathVariable Long id,
            @RequestBody @Valid StudentRecord updatedStudent) {
        try {
            studentService.updateStudent(id, updatedStudent);
            return ResponseEntity.status(HttpStatus.OK).body("Student successfully updated");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
}
