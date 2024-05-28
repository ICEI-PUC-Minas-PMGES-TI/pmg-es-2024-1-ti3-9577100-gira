package com.app.pucTis.Services;

import com.app.pucTis.Entities.LoginRequest;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.AdiministratorRepository;
import com.app.pucTis.Repositories.ParentsRepository;
import com.app.pucTis.Repositories.TeacherRepository;
import org.mindrot.jbcrypt.BCrypt;
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
        String code  = loginRequest.getCode();
        String password = loginRequest.getPassword();

        Optional<Administrator>adminOptional = administratorRepository.findByCode(code);
        if (adminOptional.isPresent()) {
            Administrator administrator = adminOptional.get();

            if (BCrypt.checkpw(password, administrator.getPassword())) {
                SeesionManager.setAuthenticatedAdministrator(administrator);
                return administrator;
            }
        }

        Optional<Parents> parentsOptional = parentsRepository.findByCode(code);
        if (parentsOptional.isPresent()) {
            Parents parents = parentsOptional.get();

            if (BCrypt.checkpw(password, parents.getPassword())) {
                SeesionManager.setAuthenticatedParents(parents);
                return parents;
            }
        }

        Optional<Teacher> teacherOptional = teacherRepository.findByCode(code);
        if (teacherOptional.isPresent()) {
            Teacher teacher = teacherOptional.get();

            if (BCrypt.checkpw(password, teacher.getPassword())) {
                SeesionManager.setAuthenticatedTeacher(teacher);
                return teacher;
            }
        }

        throw new Exception("User authentication failed");
    }

    public boolean authenticate(String enteredPassword, String storedHash) {
        return BCrypt.checkpw(enteredPassword, storedHash);
    }


    public void logout() {
        SeesionManager.clearAuthenticatedAdministrator();
        SeesionManager.clearAuthenticatedTeacher();
        SeesionManager.clearAuthenticatedParents();
    }
}



