package com.app.pucTis.Services;

import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.ParentsRepository;
import com.app.pucTis.Repositories.StudentRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ParentsService {
    @Autowired
    private ParentsRepository parentsRepository;
    @Autowired
    private StudentRepository studentRepository;

    private void saveParents(Parents parents) {
        this.parentsRepository.save(parents);
    }

    public Parents createParents(ParentsRecord dataParents) {
        Parents newParents = new Parents(dataParents);
        String code = generateCode(newParents.getName());
        newParents.setCode(code);

        String hashedPassword = BCrypt.hashpw(dataParents.password(), BCrypt.gensalt());
        newParents.setPassword(hashedPassword);

        this.saveParents(newParents);
        return newParents;
    }

    public Optional<Parents> findByNameOrId(Parents parentService) {
        return parentsRepository.findByName(parentService.getName());
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
            code = code.substring(0, 8); // Limita o código a 8 caracteres
        }

        if (parentsRepository.existsByCode(code)) {
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

    public List<Parents> getAllActiveParents() {
        return parentsRepository.findByStatus(true);
    }

    public Optional<Parents> getParentsById(Long id) {
        return parentsRepository.findByIdAndStatus(id, true);
    }

    public String deactivateParents(Long id) {
        Optional<Parents> parentsOptional = parentsRepository.findById(id);
        if (parentsOptional.isPresent()) {
            Parents parents = parentsOptional.get();
            if (parents.getStatus()) {
                parents.setStatus(false);
                parentsRepository.save(parents);
                return "Parents deactivated successfully.";
            } else {
                return "Parents is already deactivated.";
            }
        } else {
            return "Parents not found.";
        }
    }

    public String activateParents(Long id) {
        Optional<Parents> parentsOptional = parentsRepository.findById(id);
        if (parentsOptional.isPresent()) {
            Parents parents = parentsOptional.get();
            if (!parents.getStatus()) {
                parents.setStatus(true);
                parentsRepository.save(parents);
                return "Parents activated successfully.";
            } else {
                return "Parents is already active.";
            }
        } else {
            return "Parents not found.";
        }
    }

    public String updateParents(Long id, Parents dataParents) {
        Optional<Parents> parentsOptional = parentsRepository.findById(id);

        if (parentsOptional.isPresent()) {
            Parents parents = parentsOptional.get();

            if (dataParents.getName() != null) {
                parents.setName(dataParents.getName());
            }
            if (dataParents.getCode() != null) {
                parents.setCode(dataParents.getCode());
            }
            if (dataParents.getPassword() != null) {
                parents.setPassword(dataParents.getPassword());
            }
            if (dataParents.getType() != null) {
                parents.setType(dataParents.getType());
            }
            if (dataParents.getStudents() != null) {
                parents.setStudents(dataParents.getStudents());
            }
            if (dataParents.getValidPass() != null) {
                parents.setValidPass(dataParents.getValidPass());
            }
            if (dataParents.getLikedNews() != null) {
                parents.setLikedNews(dataParents.getLikedNews());
            }

            parentsRepository.save(parents);

            return "Parents updated successfully.";
        } else {
            return "Parents not found.";
        }
    }

}
