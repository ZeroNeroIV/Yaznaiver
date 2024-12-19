package com.yaznaiver.authentication.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yaznaiver.authentication.exception.WrongEmailOrPasswordException;
import com.yaznaiver.authentication.service.SignInService;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SignInController {
    private final SignInService signInService;

    @MutationMapping(name = "signIn")
    public Map<String, Object> signIn(
            @Argument String email,
            @Argument String password
    ) throws JsonProcessingException, WrongEmailOrPasswordException {
        return signInService.signIn(email, password);
    }
}
