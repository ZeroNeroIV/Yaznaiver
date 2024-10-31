package com.yaznaiver.authentication.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yaznaiver.authentication.dto.signInDto;
import com.yaznaiver.authentication.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SignInController {
    private final UserAccountService userAccountService;

    @MutationMapping
    public ResponseEntity<Map<String, Object>> signIn(@Argument signInDto signInDto) throws JsonProcessingException {
        return ResponseEntity.ok().body(userAccountService.signIn(signInDto));
    }
}
