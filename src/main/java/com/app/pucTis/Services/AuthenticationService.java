package com.app.pucTis.Services;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Exceptions.UnauthorizedUserException;
import org.springframework.stereotype.Service;

@Service
public class AuthenticationService {
    public Object getAuthenticatedUser() {

        Administrator administrator = SeesionManager.getAuthenticatedAdministrator();

        if (administrator != null) {
            return administrator;
        }

        Teacher teacher = SeesionManager.getAuthenticatedTeacher();
        if (teacher != null) {
            return teacher;
        }

        Parents parents = SeesionManager.getAuthenticatedParents();
        if (parents != null) {
            return parents;
        }

        return null;
    }

    public void validateAuthorizedUser(Object user) {
        if (!(user instanceof Administrator || user instanceof Teacher || user instanceof Parents)) {
            throw new UnauthorizedUserException("Nenhum administrador, professor ou pai autenticado encontrado.");
        }
    }
}
