package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.ClassroomRecord;
import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "tb_classroom")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Classroom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank
    @Column(nullable = false, unique = true)
    private String name;
    @JsonIgnore
    private boolean status;
    @OneToMany(mappedBy = "schoolClass")
    private List<Student> students;

    @ManyToMany
    @JoinTable(name = "TEACHER_CLASS", joinColumns = @JoinColumn(name = "SCHOOL_ID"), inverseJoinColumns = @JoinColumn(name = "TEACHER_ID")

    )
    private List<Teacher> teachers;

    public Classroom(ClassroomRecord data) {
        this.students = data.students();
        this.teachers = data.teachers();
        this.name = data.name();
        this.status = true;
    }

    public Classroom(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<Student> getStudents() {
        return students;
    }

    public void setStudents(List<Student> students) {
        this.students = students;
    }

    public List<Teacher> getTeachers() {
        return teachers;
    }

    public void setTeachers(List<Teacher> teachers) {
        this.teachers = teachers;
    }

    public void setTeacher(Teacher teacher) {
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

}
