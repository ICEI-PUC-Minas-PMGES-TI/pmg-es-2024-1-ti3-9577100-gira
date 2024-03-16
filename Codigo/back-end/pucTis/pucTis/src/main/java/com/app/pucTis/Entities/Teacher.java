package com.app.pucTis.Entities;

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

}
