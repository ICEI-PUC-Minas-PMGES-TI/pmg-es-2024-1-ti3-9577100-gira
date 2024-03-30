package com.app.pucTis.Dtos;

import com.app.pucTis.Entities.Enuns.UserType;
import jakarta.validation.constraints.NotBlank;
import java.util.Date;

public record NewsRecord(
        Long id,
        @NotBlank
        String description,
        Date date,
        String image,
        UserType author,
        int likes
) {


}
