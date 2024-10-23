package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.exception.AccountVerificationCodeNotFoundException;
import com.yaznaiver.authentication.service.AccountVerificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController("/api/v1/auth/account-verification")
public class AccountVerificationController {
    private final AccountVerificationService accountVerificationService;

    @PostMapping("/verify")
    public ResponseEntity<String> accountVerificationCode(@RequestParam("verificationCode") String verificationCode)
            throws AccountVerificationCodeNotFoundException {
        accountVerificationService.accountVerificationCode(verificationCode);
        return ResponseEntity.ok().body("Account verification code has been verified");
    }
}
