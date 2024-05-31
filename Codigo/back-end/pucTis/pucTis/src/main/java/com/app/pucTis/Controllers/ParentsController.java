package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Services.ParentsService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin("*")
@RequestMapping("/parents")
public class ParentsController {
    @Autowired
    private ParentsService parentsService;

    @Autowired
    private StudentRepository studentRepository;

    @PostMapping
    public ResponseEntity<Parents> registerParents(@RequestBody @Valid ParentsRecord newParents) {

        Parents parents = parentsService.createParents(newParents);
        return new ResponseEntity<>(parents, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Parents>> getAllActiveParents() {
        List<Parents> activeParents = parentsService.getAllActiveParents();
        return new ResponseEntity<>(activeParents, HttpStatus.OK);
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<Object> getParentsById(@PathVariable Long id) {
        Optional<Parents> parentsOptional = parentsService.getParentsById(id);
        if (parentsOptional.isPresent()) {
            return new ResponseEntity<>(parentsOptional.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>("Parents not found or is inactive.", HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deactivateParents(@PathVariable Long id) {
        String message = parentsService.deactivateParents(id);
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateParents(@PathVariable Long id) {
        String message = parentsService.activateParents(id);
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateParents(@PathVariable Long id, @RequestBody Parents dataParents) {
        String message = parentsService.updateParents(id, dataParents);
        return ResponseEntity.ok().body(message);
    }

    @PostMapping("parentId/{parentId}/addStudent/{studentId}")
    public ResponseEntity<String> addStudentToParents(@PathVariable Long parentId, @PathVariable Long studentId) {
        Optional<Student> optionalStudent = studentRepository.findById(studentId);
        if (optionalStudent.isPresent()) {
            return parentsService.addStudentToParents(parentId, studentId);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/parentId/{parentId}/removeStudent/{studentId}")
    public ResponseEntity<String> removeStudentFromParents(@PathVariable Long parentId, @PathVariable Long studentId) {
        Optional<Student> optionalStudent = studentRepository.findById(studentId);
        if (optionalStudent.isPresent()) {
            return parentsService.removeStudentFromParents(parentId, studentId);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{parentId}/students")
    public ResponseEntity<List<Student>> getAllStudentsByParentId(@PathVariable Long parentId) {
        try {
            List<Student> students = parentsService.getAllStudentsByParentId(parentId);
            return ResponseEntity.ok(students);
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }

}
