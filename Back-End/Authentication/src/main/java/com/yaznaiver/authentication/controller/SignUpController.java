package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.dto.signUpDto;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.SignUpException;
import com.yaznaiver.authentication.service.UserAccountService;
import lombok.RequiredArgsConstructor;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.Arguments;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class SignUpController {
    private final UserAccountService userAccountService;

    @MutationMapping(name = "createUser")
    public ResponseEntity<UserAccount> signUp(
            @Argument Long nationalId,
            @Argument String firstName,
            @Argument String secondName,
            @Argument String thirdName,
            @Argument String lastName,
            @Argument String email,
            @Argument String password,
            @Argument String birthDate) throws SignUpException {
        UserAccount userAccount = userAccountService.createUserAccount(
                nationalId,
                firstName,
                secondName,
                thirdName,
                lastName,
                birthDate,
                email,
                password
        );
        return ResponseEntity.ok(userAccount);
    }
}
