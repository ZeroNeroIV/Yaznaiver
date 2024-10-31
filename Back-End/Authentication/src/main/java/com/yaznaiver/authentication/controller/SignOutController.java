package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.service.SignOutService;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequiredArgsConstructor
public class SignOutController {
    private final SignOutService signOutService;

    @QueryMapping(name = "signOut")
    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    public Boolean signOut(@RequestHeader("Authorization") String bearerToken) {
        String accessToken = bearerToken.replace("Bearer ", "");
        signOutService.signOut(accessToken);
        return true;
    }
}
