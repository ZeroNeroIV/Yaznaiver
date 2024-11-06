package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.exception.UserAccountNotFoundException;
import com.yaznaiver.authentication.repository.RefreshTokenRepository;
import com.yaznaiver.authentication.utility.JwtUtility;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SignOutService {

    private final JwtUtility jwtUtility;
    private final RefreshTokenRepository refreshTokenRepository;

    public void signOut(String accessToken) {
        try {
            Long nationalId = jwtUtility.getUserAccountIdFromAccessToken(accessToken);
            refreshTokenRepository.deleteByUserAccountNationalId(nationalId);
        } catch (Exception e) {
            throw new UserAccountNotFoundException();
        }
    }
}
