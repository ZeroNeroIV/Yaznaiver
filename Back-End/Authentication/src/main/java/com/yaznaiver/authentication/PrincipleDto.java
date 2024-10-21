package com.yaznaiver.authentication;

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
