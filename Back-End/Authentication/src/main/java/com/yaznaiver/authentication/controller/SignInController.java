package com.yaznaiver.authentication.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yaznaiver.authentication.dto.signInDto;
import com.yaznaiver.authentication.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController("/api/v1/auth/sign-in")
@RequiredArgsConstructor
public class SignInController {
    private final UserAccountService userAccountService;

    @PostMapping
    public ResponseEntity<Map<String, Object>> signIn(@RequestBody signInDto signInDto) throws JsonProcessingException {
        return ResponseEntity.ok().body(userAccountService.signIn(signInDto));
    }
}
