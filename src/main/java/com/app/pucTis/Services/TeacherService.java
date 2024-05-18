package com.app.pucTis.Services;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.*;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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
    public List<Teacher> getAllTeachers() {
        return teacherRepository.findAll();
    }

    public Optional<Teacher> findByNameOrId(Teacher teacherService) {
        return teacherRepository.findByName(teacherService.getName());
    }

    public Teacher authenticate(Teacher teacherService) throws Exception {
        if (teacherService == null)
            throw new IllegalArgumentException("Teacher cannot be null");

        Optional<Teacher> optional = teacherRepository
                .findByName(teacherService.getName());

        Teacher authenticated =  optional.filter(storedTeacher ->
                        storedTeacher.getPassword().equals(teacherService.getPassword()))
                .orElseThrow(() -> new Exception("User or password invalid"));
        SeesionManager.setAuthenticatedTeacher(authenticated);

        return authenticated;
    }
    public boolean authenticatePass(Parents parentService){
        return parentService.getValidPass();
    }
}
