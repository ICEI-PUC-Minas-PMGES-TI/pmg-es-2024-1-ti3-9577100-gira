package com.app.pucTis.Services;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.StudentRepository;
import com.app.pucTis.Repositories.ParentsRepository; // Importe o repositório dos pais

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ParentsRepository parentsRepository; // Injeção do repositório dos pais

    private void saveStudent(Student student) {
        this.studentRepository.save(student);
    }

    public Student createStudent(StudentRecord dataStudent) {
        Student newStudent = new Student(dataStudent);
        this.saveStudent(newStudent);
        return newStudent;
    }

    public List<Student> getActiveStudents() {
        return studentRepository.findByStatusTrue();
    }

    public void deleteStudent(Long id) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isPresent()) {
            Student student = studentOptional.get();
            student.setStatus(false);
            studentRepository.save(student);
        } else {
            throw new IllegalArgumentException("Student not found with id: " + id);
        }
    }

    public void activateStudent(Long id) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isPresent()) {
            Student student = studentOptional.get();
            student.setStatus(true);
            studentRepository.save(student);
        } else {
            throw new IllegalArgumentException("Student not found with id: " + id);
        }
    }

    public Optional<Student> getStudentById(Long id) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isPresent() && studentOptional.get().isStatus()) {
            return studentOptional;
        }
        return Optional.empty();
    }

    public Student updateStudent(Long id, StudentRecord updatedData) {
        Optional<Student> studentOptional = studentRepository.findById(id);
        if (studentOptional.isPresent()) {
            Student student = studentOptional.get();

            if (updatedData.registration() != null) {
                student.setRegistration(updatedData.registration());
            }
            if (updatedData.name() != null) {
                student.setName(updatedData.name());
            }
            if (updatedData.type() != null) {
                student.setType(updatedData.type());
            }
            if (updatedData.schoolClass() != null) {
                student.setSchoolClass(updatedData.schoolClass());
            }
            if (updatedData.parents() != null) {
                student.setParents(updatedData.parents());
            }

            studentRepository.save(student);
            return student;
        } else {
            throw new IllegalArgumentException("Student not found with id: " + id);
        }
    }

}
