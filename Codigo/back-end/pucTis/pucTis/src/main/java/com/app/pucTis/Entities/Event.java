package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.EventRecord;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "tb_event")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank
    @Column(nullable = false)
    private String name;
    @NotBlank
    @Column(nullable = false)
    private String description;
    private Date date;
    private String author;
    private boolean status;
    @ManyToOne
    @JoinColumn(name = "classroom_id")
    private Classroom classroom;

    public Event(EventRecord data) {
        this.id = data.id();
        this.name = data.name();
        this.description = data.description();
        this.date = new Date();
        this.author = data.author();
        this.classroom = data.classroom();
        this.status = true;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Classroom getClassroom() {
        return classroom;
    }

    public void setClassrooms(Classroom classroom) {
        this.classroom = classroom;
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

    public void setClassroom(Classroom classroom) {
        this.classroom = classroom;
    }

}
