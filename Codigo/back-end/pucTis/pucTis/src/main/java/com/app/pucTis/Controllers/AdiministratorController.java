package com.app.pucTis.Controllers;

import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Services.AdministratorService;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin("*")
@RequestMapping("/administrator")
public class AdiministratorController {
    @Autowired
    private AdministratorService administratorService;

    @PostMapping
    public ResponseEntity<Administrator> registerAdiministrator(
            @RequestBody @Valid AdiministratorRecord newAdiministrator) {
        Administrator adiministrator = administratorService.createAdiministrator(newAdiministrator);
        return new ResponseEntity<>(adiministrator, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Administrator>> getAllActiveAdministrators() {
        List<Administrator> administrators = administratorService.getAllActiveAdministrators();
        return ResponseEntity.ok().body(administrators);
    }

    @GetMapping("/id/{id}")
    public ResponseEntity<Administrator> getActiveAdministratorById(@PathVariable Long id) {
        Optional<Administrator> administratorOptional = administratorService.getActiveAdministratorById(id);

        if (administratorOptional.isPresent()) {
            Administrator administrator = administratorOptional.get();
            return ResponseEntity.ok().body(administrator);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deactivateAdministrator(@PathVariable Long id) {
        String message = administratorService.deactivateAdministrator(id);
        return ResponseEntity.ok().body(message);
    }

    @PutMapping("/activate/{id}")
    public ResponseEntity<String> activateAdministrator(@PathVariable Long id) {
        String message = administratorService.activateAdministrator(id);
        return ResponseEntity.ok().body(message);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<String> updateAdministrator(@PathVariable Long id,
            @RequestBody Administrator dataAdministrator) {
        String message = administratorService.updateAdministrator(id, dataAdministrator);
        return ResponseEntity.ok().body(message);
    }

}
