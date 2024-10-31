package com.yaznaiver.authentication.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yaznaiver.authentication.entity.RefreshToken;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.WrongEmailOrPasswordException;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import com.yaznaiver.authentication.utility.JwtUtility;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SignInService {

    private final UserAccountRepository userAccountRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtility jwtUtility;

    public Map<String, Object> signIn(String email, String password) throws JsonProcessingException, WrongEmailOrPasswordException {
        UserAccount userAccount = userAccountRepository
                .findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
        if (!passwordEncoder.matches(password, userAccount.getPassword())) {
            throw new WrongEmailOrPasswordException();
        }
        RefreshToken refreshToken = new RefreshToken();
        refreshToken.setUserAccount(userAccount);
        refreshToken
                .setRefreshToken(jwtUtility
                        .generateRefreshToken(userAccount));

        String accessToken = jwtUtility.generateAccessToken(userAccount);
        Map<String, Object> response = new HashMap<>();
        response.put("accessToken", accessToken);
        response.put("refreshToken", refreshToken.getRefreshToken());
        return response;
    }
}
