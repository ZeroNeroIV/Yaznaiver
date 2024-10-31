package com.yaznaiver.authentication.dto;

import lombok.Data;

@Data
public class AccountVerificationCodeDto {
    private String email;
    private String code;
}