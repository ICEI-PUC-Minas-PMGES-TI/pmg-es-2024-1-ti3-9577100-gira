package com.app.pucTis.Services;

import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Repositories.AdiministratorRepository;
import com.sun.net.httpserver.Headers;
import org.hibernate.query.sqm.UnknownPathException;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.net.http.HttpHeaders;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AdiministratorService {
    @Autowired
    AdiministratorRepository adiministratorRepository;

    private void saveAdiministrator(Administrator adm) {
        this.adiministratorRepository.save((adm));
    }

    public Administrator createAdiministrator(AdiministratorRecord dataAdm) {
        Administrator newAdiministrator = new Administrator(dataAdm);
        String code = generateCode(newAdiministrator.getName());
        newAdiministrator.setCode(code);

        String hashedPassword = BCrypt.hashpw(dataAdm.password(), BCrypt.gensalt());
        newAdiministrator.setPassword(hashedPassword);

        this.saveAdiministrator(newAdiministrator);
        return newAdiministrator;
    }

    public List<Administrator> getAllAdiministrators() {
        return this.adiministratorRepository.findAll();
    }

    public Administrator findAdiministratorById(Long id) throws Exception {
        return this.adiministratorRepository.findAdiministratorById(id).orElseThrow(() -> new Exception("User not found"));
    }

    public Optional<Administrator> findByNameOrId(Administrator administratorService) {
        return adiministratorRepository.findByName(administratorService.getName());
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

        if (adiministratorRepository.existsByCode(code)) {
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


