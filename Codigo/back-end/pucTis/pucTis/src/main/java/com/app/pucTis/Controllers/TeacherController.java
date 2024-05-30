package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Services.TeacherService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/teacher")
public class TeacherController {
    @Autowired
    private TeacherService teacherService;

    @PostMapping
    public ResponseEntity<Teacher> registerTeacher(@RequestBody @Valid TeacherRecord newTeacher) {
        Teacher teacher = teacherService.createTeacher(newTeacher);
        return new ResponseEntity<>(teacher, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Teacher>> getAllTeachers() {
        List<Teacher> teachers = teacherService.getAllActiveTeachers();
        return new ResponseEntity<>(teachers, HttpStatus.OK);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteTeacher(@PathVariable Long id) {
        String message = teacherService.deactivateTeacher(id);
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateTeacher(@PathVariable Long id) {
        String message = teacherService.activateTeacher(id);
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<Object> getTeacherById(@PathVariable Long id) {
        Teacher teacher = teacherService.getTeacherById(id);
        if (teacher != null) {
            return new ResponseEntity<>(teacher, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Teacher not found or is inactive.", HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateTeacher(@PathVariable Long id, @RequestBody @Valid Teacher updatedTeacher) {
        String message = teacherService.updateTeacher(id, updatedTeacher);
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

}
