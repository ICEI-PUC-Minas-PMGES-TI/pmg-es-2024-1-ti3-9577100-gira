package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.TeacherRecord;
import com.app.pucTis.Entities.Enuns.UserType;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "tb_teacher")
public class Teacher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String password;
    private UserType type;
    @ManyToMany
    private List<Classroom> schoolClasses;
    private Boolean validPass;

    public Teacher(TeacherRecord data) {
        this.name = data.name();
        this.password = data.password();
        this.type = data.type();
        this.schoolClasses = data.schoolClasses();
        this.validPass = data.validPass();
    }

    public Teacher() {

    }

    public String getName() {return name;}

    public String getPassword() {return password;}

    public void setValidPass(Boolean validPass) {
        this.validPass = validPass;
    }
    public Boolean getValidPass() {return validPass;}
}
