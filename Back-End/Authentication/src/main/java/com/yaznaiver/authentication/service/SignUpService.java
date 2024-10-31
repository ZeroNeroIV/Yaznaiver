package com.yaznaiver.authentication.service;

import ch.qos.logback.classic.encoder.JsonEncoder;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.SignUpException;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.antlr.v4.runtime.misc.LogManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class SignUpService {

    private final PasswordEncoder passwordEncoder;
    private final UserAccountRepository userAccountRepository;

    public UserAccount createUserAccount(@NotNull Long id,
                                         @NotBlank String firstName,
                                         @NotBlank String secondName,
                                         @NotBlank String thirdName,
                                         @NotBlank String lastName,
                                         @NotBlank String birthDate,
                                         @NotNull @Email String email,
                                         @NotBlank String password
    ) throws SignUpException {
        try {
            UserAccount userAccount =
                    new UserAccount(id,
                            firstName,
                            secondName,
                            thirdName,
                            lastName,
                            email,
                            passwordEncoder.encode(password),
                            LocalDate.parse(birthDate, DateTimeFormatter.ISO_LOCAL_DATE));
            return userAccountRepository.save(userAccount);
        } catch (Exception e) {
            throw new SignUpException();
        }
    }
}
