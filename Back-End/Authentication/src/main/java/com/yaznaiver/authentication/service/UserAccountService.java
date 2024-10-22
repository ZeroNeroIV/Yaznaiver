package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;
    private final PasswordEncoder passwordEncoder;

    public UserAccount createUserAccount(@NotNull Long id,
                                         @NotBlank String firstName,
                                         @NotBlank String secondName,
                                         @NotBlank String thirdName,
                                         @NotBlank String lastName,
                                         @NotNull LocalDateTime birthDate,
                                         @NotNull @Email String email,
                                         @NotBlank String password
    ) {
        UserAccount userAccount =
                new UserAccount(id,
                        firstName,
                        secondName,
                        thirdName,
                        lastName,
                        email,
                        passwordEncoder.encode(password),
                        birthDate);

    }
}
