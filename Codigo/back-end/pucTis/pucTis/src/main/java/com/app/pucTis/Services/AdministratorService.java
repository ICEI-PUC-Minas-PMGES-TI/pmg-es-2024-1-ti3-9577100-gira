package com.app.pucTis.Services;

import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Repositories.AdiministratorRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AdministratorService {
    @Autowired
    AdiministratorRepository administratorRepository;

    private void saveAdiministrator(Administrator adm) {
        this.administratorRepository.save((adm));
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

    public Administrator findAdiministratorById(Long id) throws Exception {
        return this.administratorRepository.findAdiministratorById(id)
                .orElseThrow(() -> new Exception("User not found"));
    }

    public Optional<Administrator> findByNameOrId(Administrator administratorService) {
        return administratorRepository.findByName(administratorService.getName());
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

        if (administratorRepository.existsByCode(code)) {
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

    public List<Administrator> getAllActiveAdministrators() {
        return administratorRepository.findByStatus(true);
    }

    public Optional<Administrator> getActiveAdministratorById(Long id) {
        return administratorRepository.findByIdAndStatus(id, true);
    }

    public String deactivateAdministrator(Long id) {
        Optional<Administrator> administratorOptional = administratorRepository.findById(id);

        if (administratorOptional.isPresent()) {
            Administrator administrator = administratorOptional.get();
            administrator.setStatus(false);
            administratorRepository.save(administrator);
            return "Administrator deactivated successfully.";
        } else {
            return "Administrator not found.";
        }
    }

    public String activateAdministrator(Long id) {
        Optional<Administrator> administratorOptional = administratorRepository.findById(id);

        if (administratorOptional.isPresent()) {
            Administrator administrator = administratorOptional.get();
            administrator.setStatus(true);
            administratorRepository.save(administrator);
            return "Administrator activated successfully.";
        } else {
            return "Administrator not found.";
        }
    }

    public String updateAdministrator(Long id, Administrator dataAdministrator) {
        Optional<Administrator> administratorOptional = administratorRepository.findById(id);

        if (administratorOptional.isPresent()) {
            Administrator administrator = administratorOptional.get();

            if (dataAdministrator.getName() != null) {
                administrator.setName(dataAdministrator.getName());
            }
            if (dataAdministrator.getCode() != null) {
                administrator.setCode(dataAdministrator.getCode());
            }
            if (dataAdministrator.getPassword() != null) {
                administrator.setPassword(dataAdministrator.getPassword());
            }

            administratorRepository.save(administrator);
            return "Administrator updated successfully.";
        } else {
            return "Administrator not found.";
        }
    }

}
