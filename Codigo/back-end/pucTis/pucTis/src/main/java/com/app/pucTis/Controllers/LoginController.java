package com.app.pucTis.Controllers;

import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Enuns.UserType;
import com.app.pucTis.Entities.LoginRequest;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Services.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/login")
public class LoginController {
    private final LoginService loginService;

    @Autowired
    public LoginController(LoginService loginService) {
        this.loginService = loginService;
    }

    @PostMapping
    public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
        try {
            Object authenticatedUser = loginService.authenticateUser(loginRequest);


            UserType userType = null;
            if (authenticatedUser instanceof Administrator) {
                userType = UserType.ADMINISTRATOR;
            } else if (authenticatedUser instanceof Parents) {
                userType = UserType.PARENTS;
            } else if (authenticatedUser instanceof Teacher) {
                userType = UserType.TEACHER;
            }

            Map<String, Object> response = new HashMap<>();
            response.put("user", authenticatedUser);
            response.put("userType", userType);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Failed to login: " + e.getMessage());
        }
    }


    @PostMapping("/logout")
    public ResponseEntity<String> logout() {
        loginService.logout();
        return ResponseEntity.ok("Logged out successfully");
    }
}
