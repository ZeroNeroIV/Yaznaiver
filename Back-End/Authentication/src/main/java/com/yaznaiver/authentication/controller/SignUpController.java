package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.dto.signUpDto;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.SignUpException;
import com.yaznaiver.authentication.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController("/api/v1/auth/sign-up")
@RequiredArgsConstructor
public class SignUpController {
    private final UserAccountService userAccountService;

    @PostMapping
    public ResponseEntity<?> signUp(@RequestBody signUpDto signUpDto) throws SignUpException {
        UserAccount userAccount = userAccountService.createUserAccount(
                signUpDto.getNationalId(),
                signUpDto.getFirstName(),
                signUpDto.getSecondName(),
                signUpDto.getThirdName(),
                signUpDto.getLastName(),
                signUpDto.getBirthday(),
                signUpDto.getEmail(),
                signUpDto.getPassword()
        );
        return ResponseEntity.ok(userAccount);
    }
}
