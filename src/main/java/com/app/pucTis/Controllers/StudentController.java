package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Services.StudentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/student")
public class StudentController {
    @Autowired
    private StudentService studentService;
    @Autowired
    private StudentRepository studentRepository;

    @PostMapping
    ResponseEntity<Student> registerStudent(@RequestBody @Valid StudentRecord newStudent) {
        Student student = studentService.createStudent(newStudent);
        return new ResponseEntity<>(student, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Student>> getAllStudents() {
        List<Student> students = studentRepository.findAll();
        return ResponseEntity.status(HttpStatus.OK).body(students);
    }

}
