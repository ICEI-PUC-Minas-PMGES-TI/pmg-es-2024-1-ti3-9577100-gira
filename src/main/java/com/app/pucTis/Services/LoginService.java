package com.app.pucTis.Services;

import com.app.pucTis.Entities.LoginRequest;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.AdiministratorRepository;
import com.app.pucTis.Repositories.ParentsRepository;
import com.app.pucTis.Repositories.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
public class LoginService {

    private final AdiministratorRepository administratorRepository;
    private final ParentsRepository parentsRepository;
    private final TeacherRepository teacherRepository;

    @Autowired
    public LoginService(AdiministratorRepository administratorRepository,
                        ParentsRepository parentsRepository,
                        TeacherRepository teacherRepository) {
        this.administratorRepository = administratorRepository;
        this.parentsRepository = parentsRepository;
        this.teacherRepository = teacherRepository;
    }

    public Object authenticateUser(LoginRequest loginRequest) throws Exception {
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();

        Optional<Administrator> adminOptional = administratorRepository.findByName(username);
        if (adminOptional.isPresent()) {
            Administrator administrator = adminOptional.get();

            if (administrator.getPassword().equals(password)) {
                SeesionManager.setAuthenticatedAdministrator(administrator);
                return administrator;
            }
        }

        Optional<Parents> parentsOptional = parentsRepository.findByName(username);
        if (parentsOptional.isPresent()) {
            Parents parents = parentsOptional.get();

            if (parents.getPassword().equals(password)) {
                SeesionManager.setAuthenticatedParents(parents);
                return parents;
            }
        }

        Optional<Teacher> teacherOptional = teacherRepository.findByName(username);
        if (teacherOptional.isPresent()) {
            Teacher teacher = teacherOptional.get();

            if (teacher.getPassword().equals(password)) {
                SeesionManager.setAuthenticatedTeacher(teacher);
                return teacher;
            }
        }

        throw new Exception("User authentication failed");
    }

    public void logout() {
        SeesionManager.clearAuthenticatedAdministrator();
        SeesionManager.clearAuthenticatedTeacher();
        SeesionManager.clearAuthenticatedParents();
    }
}


