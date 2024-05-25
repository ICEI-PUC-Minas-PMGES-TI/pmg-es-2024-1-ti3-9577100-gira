package com.app.pucTis.Services;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.*;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.TeacherRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TeacherService {
    @Autowired
    private TeacherRepository teacherRepository;

    public void saveTeacher(Teacher teacher){
        this.teacherRepository.save(teacher);
    }
    public Teacher createTeacher(TeacherRecord dataTeacher){
        Teacher newTeacher = new Teacher(dataTeacher);
        String code = generateCode(newTeacher.getName());
        newTeacher.setCode(code);

        String hashedPassword = BCrypt.hashpw(dataTeacher.password(), BCrypt.gensalt());
        newTeacher.setPassword(hashedPassword);

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
                .findByCode(teacherService.getCode());

        Teacher authenticated =  optional.filter(storedTeacher ->
                        storedTeacher.getPassword().equals(teacherService.getPassword()))
                .orElseThrow(() -> new Exception("User or password invalid"));
        SeesionManager.setAuthenticatedTeacher(authenticated);

        return authenticated;
    }
    public boolean authenticatePass(Teacher parentService){
        return parentService.getValidPass();
    }

    private String generateCode(String name) {
        return generateUniqueCode(name);
    }

    private String generateUniqueCode(String name) {
        LocalDate createdAt = LocalDate.now();
        int year = createdAt.getYear();
        String initials = shuffleString(name.replaceAll("[^A-Za-z]", "").toUpperCase());

        String code = year + initials;

        if (code.length() > 8) {
            code = code.substring(0, 8);
        }

        if (teacherRepository.existsByCode(code)) {
            return generateUniqueCode(name);
        } else {
            return code;
        }
    }

    private String shuffleString(String input) {
        List<Character> characters = input.chars()
                .mapToObj(c -> (char) c)
                .collect(Collectors.toList());
        Collections.shuffle(characters);
        StringBuilder sb = new StringBuilder();
        characters.forEach(sb::append);
        return sb.toString();
    }
}
