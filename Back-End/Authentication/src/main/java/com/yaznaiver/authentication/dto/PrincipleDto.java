package com.yaznaiver.authentication.dto;

import lombok.Data;

@Data
public class PrincipleDto {
    private String username;
    private String email;

    public PrincipleDto(String username, String email) {
        this.username = username;
        this.email = email;
    }
}
