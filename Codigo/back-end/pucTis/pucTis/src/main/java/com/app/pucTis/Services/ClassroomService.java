package com.app.pucTis.Services;

import com.app.pucTis.Dtos.ClassroomRecord;
import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Repositories.SchoolClassRepository;
import com.app.pucTis.Repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ClassroomService {
    @Autowired
    private SchoolClassRepository classroomRepository;
    @Autowired
    private StudentRepository studentRepository;

    private void saveClassroom(Classroom classroom) {
        this.classroomRepository.save(classroom);

    }

    public boolean createClassroom(ClassroomRecord classroomRecord) {
        try {
            Classroom classroom = new Classroom(classroomRecord);

            classroomRepository.save(classroom);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Classroom> getAllClassrooms() {
        return classroomRepository.findAll();
    }

    public boolean addStudentToClassroom(Long classroomId, Long studentId) {
        Classroom classroom = classroomRepository.findById(classroomId).orElse(null);
        Student student = studentRepository.findById(studentId).orElse(null);

        if (classroom != null && student != null) {
            if (student.getSchoolClass() == null || !student.getSchoolClass().equals(classroom)) {
                student.setSchoolClass(classroom);
                studentRepository.save(student);
                return true;
            }
        }
        return false;
    }

    public List<Student> getClassroomStudents(Long classroomId) {
        Classroom classroom = classroomRepository.findById(classroomId).orElse(null);
        if (classroom != null) {
            return classroom.getStudents();
        } else {
            return null;
        }
    }

}
