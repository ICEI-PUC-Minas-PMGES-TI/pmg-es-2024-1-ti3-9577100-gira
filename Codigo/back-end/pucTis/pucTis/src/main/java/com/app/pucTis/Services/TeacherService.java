package com.app.pucTis.Services;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Student;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TeacherService {
    @Autowired
    private TeacherRepository teacherRepository;

    public void saveTeacher(Teacher teacher){
        this.teacherRepository.save(teacher);
    }
    public Teacher createTeacher(TeacherRecord dataTeacher){
        Teacher newTeacher = new Teacher(dataTeacher);
        this.saveTeacher(newTeacher);
        return newTeacher;
    }

    public Optional<Teacher> findByNameOrId(Teacher teacherService) {
        return teacherRepository.findByName(teacherService.getName());
    }

    public boolean authenticateTeacher(Teacher teacherService) {
        Optional<Teacher> optionalTeacher = teacherRepository.findByName(teacherService.getName());

        if (optionalTeacher.isPresent()) {
            Teacher storedTeacher = optionalTeacher.get();
            return storedTeacher.getPassword().equals(teacherService.getPassword());
        } else {
            return false;
        }
    }
    public boolean authenticatePass(Parents parentService){
        return parentService.getValidPass();
    }
}
