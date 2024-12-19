package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.service.AccountVerificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class AccountVerificationController {
    private final AccountVerificationService accountVerificationService;

    @QueryMapping(name = "verifyAccount")
    public Boolean accountVerificationCode(@Argument String code) {
        return accountVerificationService.verify(code);
    }
}
