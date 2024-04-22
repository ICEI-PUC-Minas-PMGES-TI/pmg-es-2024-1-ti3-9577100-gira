package com.app.pucTis.Entities;

import com.app.pucTis.Dtos.NotificationRecord;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.apache.tomcat.util.modeler.NotificationInfo;

import java.time.LocalDate;

@Entity
@Table(name = "tb_notification")
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "id")
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long classroomId;
    private String senderName;
    private LocalDate date;
    private String message;

    public Notification(NotificationRecord data) {
        this.senderName = data.senderName();
        this.date = LocalDate.now();
        this.message = data.message();
        this.classroomId = data.classroomId();
    }


    public Long getClassroomId() {
        return classroomId;
    }

    public void setClassroomId(Long classroomId) {
        this.classroomId = classroomId;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
