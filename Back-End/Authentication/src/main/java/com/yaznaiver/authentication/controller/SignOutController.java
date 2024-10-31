package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequiredArgsConstructor
@RestController("/api/v1/auth/sign-out")
public class SignOutController {
    private final UserAccountService userAccountService;

    @GetMapping
    public ResponseEntity<String> signOut(@RequestHeader("Authorization") String bearerToken) {
        String accessToken = bearerToken.replace("Bearer ", "");
        userAccountService.signOut(accessToken);
        return ResponseEntity.ok().build();
    }
}
