package com.yaznaiver.authentication.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class signUpDto {
    private Long nationalId;
    private String firstName;
    private String secondName;
    private String thirdName;
    private String lastName;
    private String email;
    private String password;
    private LocalDateTime birthday;
}
