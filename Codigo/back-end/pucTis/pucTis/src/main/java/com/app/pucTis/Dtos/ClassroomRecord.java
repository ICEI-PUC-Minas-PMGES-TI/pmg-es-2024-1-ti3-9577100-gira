package com.app.pucTis.Dtos;

import com.app.pucTis.Entities.Student;

import java.util.List;

public record ClassroomRecord(
        Long id,
        List<Student> students
) {
}