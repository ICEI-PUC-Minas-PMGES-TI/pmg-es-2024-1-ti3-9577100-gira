package com.app.pucTis.Dtos;

import java.util.Date;
import java.util.List;

public record EventRecordWithClassrooms(
        Long id,
        String name,
        String description,
        Date date,
        String author,
        List<Long> classroomIds
) {
}
