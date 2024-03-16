package com.app.pucTis.Services;

import com.app.pucTis.Repositories.SchoolClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClassroomService {
    @Autowired
    private SchoolClassRepository schoolClassRepository;
}
