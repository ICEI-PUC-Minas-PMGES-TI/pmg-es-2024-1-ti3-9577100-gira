package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.AdiministratorRecord;
import com.app.pucTis.Dtos.ClassroomRecord;
import jakarta.persistence.*;
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
    private String name;
    @OneToMany(mappedBy = "schoolClass")
    private List<Student> students;

    @ManyToMany
    @JoinTable(
            name = "TEACHER_CLASS", //TABELA
            joinColumns = @JoinColumn(name = "SCHOOL_ID"), //COLUNA QUE REFERENCIA A ESCOLA
            inverseJoinColumns = @JoinColumn(name = "TEACHER_ID")

    )
    private List<Teacher> teachers;

    public Classroom(ClassroomRecord data) {
        this.students = data.students();
        this.teachers = data.teachers();
        this.name = data.name();
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


}
