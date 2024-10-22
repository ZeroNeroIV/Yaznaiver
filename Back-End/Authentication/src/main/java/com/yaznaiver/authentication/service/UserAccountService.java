package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.dto.signInDto;
import com.yaznaiver.authentication.entity.RefreshToken;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.SignUpException;
import com.yaznaiver.authentication.repository.RefreshTokenRepository;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import com.yaznaiver.authentication.utility.JwtUtility;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserAccountService {
    private final UserAccountRepository userAccountRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtility jwtUtility;

    public UserAccount createUserAccount(@NotNull Long id,
                                         @NotBlank String firstName,
                                         @NotBlank String secondName,
                                         @NotBlank String thirdName,
                                         @NotBlank String lastName,
                                         @NotNull LocalDateTime birthDate,
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
                            birthDate);
            return userAccountRepository.save(userAccount);
        } catch (Exception e) {
            throw new SignUpException();
        }
    }

    public Map<String, Object> signIn(signInDto signInDto) {
        UserAccount userAccount = userAccountRepository
                .findByEmail(signInDto.getEmail())
                .orElseThrow(() -> new RuntimeException("User not found"));
        if (!passwordEncoder.matches(signInDto.getPassword(), userAccount.getPassword())) {
            throw new RuntimeException("Wrong password");
        }
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUserAccount(userAccount);
        refreshToken
                .setRefreshToken(jwtUtility
                        .generateRefreshToken(userAccount));
        String accessToken = jwtUtility.generateAccessToken(userAccount);
        Map<String, Object> response = new HashMap<>();
        response.put("access_token", accessToken);
        response.put("refresh_token", refreshToken.getRefreshToken());
        return response;
    }

    public void signOut(String accessToken) {
        Long nationalId = jwtUtility.getUserAccountIdFromAccessToken(accessToken);
        refreshTokenRepository.deleteByUserAccountNationalId(nationalId);
    }
}
