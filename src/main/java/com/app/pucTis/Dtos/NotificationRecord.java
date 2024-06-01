package com.app.pucTis.Dtos;

import java.time.LocalDate;

public record NotificationRecord(
        String senderName,
        LocalDate date,
        Long classroomId,
        String message) {
    public String getMessage() {
        return message;
    }
}
