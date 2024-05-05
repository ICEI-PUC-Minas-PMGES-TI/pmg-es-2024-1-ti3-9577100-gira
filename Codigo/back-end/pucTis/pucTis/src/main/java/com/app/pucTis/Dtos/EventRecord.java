package com.app.pucTis.Dtos;

import com.app.pucTis.Entities.Classroom;

import java.util.Date;
import java.util.List;

public record EventRecord(
        Long id,
        String name,
        String description,
        Date date,
        String author,
        Classroom classroom
) {
}
