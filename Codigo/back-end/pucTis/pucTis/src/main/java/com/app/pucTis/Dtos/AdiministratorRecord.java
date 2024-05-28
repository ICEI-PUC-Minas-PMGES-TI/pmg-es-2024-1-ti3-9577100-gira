package com.app.pucTis.Dtos;


import com.app.pucTis.Entities.Enuns.UserType;
import com.app.pucTis.Entities.News;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.List;

public record AdiministratorRecord(

        Long id,
        @NotBlank
        String name,
        String code,
        @NotBlank
        @Size(min = 5)
        String password,
        UserType type,
        Boolean validPass,
        List<News> likedNews
) {
}
