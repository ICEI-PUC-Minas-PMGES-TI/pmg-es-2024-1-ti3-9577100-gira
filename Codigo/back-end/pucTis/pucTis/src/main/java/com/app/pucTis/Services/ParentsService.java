package com.app.pucTis.Services;

import com.app.pucTis.Dtos.ParentsRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Parents;
import com.app.pucTis.Entities.Teacher;
import com.app.pucTis.Repositories.ParentsRepository;
import com.app.pucTis.Repositories.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
        this.saveParents(newParents);
        return newParents;
    }

    public Optional<Parents> findByNameOrId(Parents parentService) {
        return parentsRepository.findByName(parentService.getName());
    }

    public Parents authenticate(Parents parentsService) throws Exception {
        if (parentsService == null)
            throw new IllegalArgumentException("Parent cannot be null");

        Optional<Parents> optional = parentsRepository
                .findByName(parentsService.getName());

        return  optional.filter(storedParent ->
                        storedParent.getPassword().equals(parentsService.getPassword()))
                .orElseThrow(() -> new Exception("User or password invalid"));
    }

    public boolean authenticatePass(Parents parentService){
        return parentService.getValidPass();
    }

}
