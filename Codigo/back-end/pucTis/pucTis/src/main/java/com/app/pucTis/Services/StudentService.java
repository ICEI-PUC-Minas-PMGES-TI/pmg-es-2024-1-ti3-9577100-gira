package com.app.pucTis.Services;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Event;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.EventRepository;
import com.app.pucTis.Repositories.StudentRepository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private EventRepository eventRepository;
    @Autowired
    private ClassroomService classroomService;

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

            studentRepository.save(student);
            return student;
        } else {
            throw new IllegalArgumentException("Student not found with id: " + id);
        }
    }

    public Optional<Classroom> getStudentClassroomById(Long studentId) {
        Optional<Student> studentOptional = studentRepository.findById(studentId);
        if (studentOptional.isPresent()) {
            Student student = studentOptional.get();
            return Optional.ofNullable(student.getSchoolClass());
        }
        return Optional.empty();
    }

}
