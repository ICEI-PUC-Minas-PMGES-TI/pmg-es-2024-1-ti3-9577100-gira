package com.app.pucTis.Controllers;

import com.app.pucTis.Services.ClassroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/class")
public class ClassroomController {
    @Autowired
    private ClassroomService schoolClassService;
}
