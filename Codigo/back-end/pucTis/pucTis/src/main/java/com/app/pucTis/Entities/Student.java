package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.StudentRecord;
import com.app.pucTis.Entities.Enuns.UserType;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "tb_student")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Integer registration;
    private String name;
    private UserType type;
    private boolean status;

    @JsonIgnore
    @ManyToOne
    private Classroom schoolClass;
    @ManyToOne
    private Parents parents;

    public void setId(Long id) {
        this.id = id;
    }

    public int getRegistration() {
        return this.registration;
    }

    public void setRegistration(int registration) {
        this.registration = registration;
    }

    public boolean isStatus() {
        return this.status;
    }

    public boolean getStatus() {
        return this.status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Student(StudentRecord data) {
        this.name = data.name();
        this.type = data.type(); // Tomar cuidado com import do enum la nos record, pode afetar aqui
        this.schoolClass = data.schoolClass();
        this.registration = data.registration();
        this.parents = data.parents();
        this.status = true;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public UserType getType() {
        return type;
    }

    public void setType(UserType type) {
        this.type = type;
    }

    public Classroom getSchoolClass() {
        return schoolClass;
    }

    public void setSchoolClass(Classroom schoolClass) {
        this.schoolClass = schoolClass;
    }

    public Parents getParents() {
        return parents;
    }

    public void setParents(Parents parents) {
        this.parents = parents;
    }
}