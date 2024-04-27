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


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserType getType() {
        return type;
    }

    public void setType(UserType type) {
        this.type = type;
    }

    public List<Classroom> getSchoolClasses() {
        return schoolClasses;
    }

    public void setSchoolClasses(List<Classroom> schoolClasses) {
        this.schoolClasses = schoolClasses;
    }

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
