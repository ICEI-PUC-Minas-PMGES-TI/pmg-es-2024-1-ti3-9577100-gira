package com.app.pucTis.Services;

import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Entities.Administrator;
import com.app.pucTis.Repositories.AdiministratorRepository;
import com.sun.net.httpserver.Headers;
import org.hibernate.query.sqm.UnknownPathException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.net.http.HttpHeaders;
import java.util.List;
import java.util.Optional;

@Service
public class AdiministratorService {
    @Autowired
    AdiministratorRepository adiministratorRepository;

    private void saveAdiministrator(Administrator adm) {
        this.adiministratorRepository.save((adm));
    }

    public Administrator createAdiministrator(AdiministratorRecord dataAdm) {
        Administrator newAdiministrator = new Administrator(dataAdm);
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

    public Administrator authenticateAdministrator(Administrator administratorService) throws Exception {
        if (administratorService == null)
            throw new IllegalArgumentException("Administrator cannot be null");

        Optional<Administrator> optionalAdministrator = adiministratorRepository
                .findByName(administratorService.getName());

        Administrator authenticated =  optionalAdministrator.filter(storedAdministrator ->
                        storedAdministrator.getPassword().equals(administratorService.getPassword()))
                .orElseThrow(() -> new Exception("User or password invalid"));
        SeesionManager.setAuthenticatedAdministrator(authenticated);

        return authenticated;
    }

    public void logout(){
        SeesionManager.clearAuthenticatedAdministrator();
    }

    public boolean authenticatePass(Administrator administratorService){
        return administratorService.getValidPass();
    }



}


