package com.app.pucTis.Dtos;

import jakarta.validation.constraints.NotBlank;
import java.util.Date;

public record NewsRecord(
        Long id,
        @NotBlank
        String description,
        Date date,
        String image,
        String author
) {


}
