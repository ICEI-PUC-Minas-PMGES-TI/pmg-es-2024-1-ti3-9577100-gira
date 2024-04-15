package main.java.com.app.pucTis.Dtos;

import com.app.pucTis.Entities.Student;

import java.time.LocalDate;

public record NotificationRecord(
        Long senderId,
        String senderName,
        LocalDate date,
        Long recieverId,
        Student recipientId,
        String message) {
}
