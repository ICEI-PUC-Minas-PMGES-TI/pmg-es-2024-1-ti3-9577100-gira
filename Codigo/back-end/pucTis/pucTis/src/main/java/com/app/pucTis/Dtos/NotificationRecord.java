package com.app.pucTis.Dtos;

import com.app.pucTis.Entities.Classroom;
import com.app.pucTis.Entities.Student;
import jakarta.validation.constraints.NotBlank;

import java.time.LocalDate;

public record NotificationRecord(
        String senderName,
        LocalDate date,
        Long classroomId,
        String message
) {
    public String getMessage() {
        return message;
    }
}
