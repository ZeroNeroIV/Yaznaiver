package com.yaznaiver.authentication;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtUtility {
    @Value("spring.security.access-token.secret-key")
    private String accessTokenSecretKey;
    @Value("spring.security.refresh-token.secret-key")
    private String refreshTokenSecretKey;
    @Value("spring.security.access-token.expiration-time")
    private Long accessTokenExp;
    @Value("spring.security.refresh-token.expiration-time")
    private Long refreshTokenExp;

    /// ======================================================================================
    //! Secret Signing Keys
    // PRIVATE

    //# Access Token
    private SecretKey accessTokenSecretSigningKey() {
        return secretSigningKey(accessTokenSecretKey);
    }

    private SecretKey refreshTokenSecretSigningKey() {
        return secretSigningKey(refreshTokenSecretKey);
    }


    private SecretKey secretSigningKey(@NotBlank String secretKey) {
        return Keys.hmacShaKeyFor(secretKey.getBytes());
    }

    /// /// ======================================================================================
    //! Generate Tokens
    // PUBLIC

    //# Access Token
    public String generateAccessToken(@NotNull UserAccount userAccount) {
        return generateToken(userAccount, "access");
    }

    //# Refresh Token

    public String generateRefreshToken(@NotNull UserAccount userAccount) {
        return generateToken(userAccount, "refresh");
    }

    // PRIVATE

    private String generateToken(@NotNull UserAccount userAccount, @NotBlank String type) {
        return Jwts.builder()
                .signWith(type.equals("access")
                        ? accessTokenSecretSigningKey()
                        : refreshTokenSecretSigningKey())
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + (type.equals("access")
                        ? accessTokenExp
                        : refreshTokenExp)))
                .subject(userAccount.getUsername())
                .id(userAccount.getNationalId().toString())
                .compact();
    }

    /// ======================================================================================
    //! Extract Claims
    // PUBLIC

    //# Access Token
    public Date getIssuedAtFromAccessToken(@NotBlank String token) {
        return extractIssuedAt(token, "access");
    }

    public Date getExpirationFromAccessToken(@NotBlank String token) {
        return extractExpiration(token, "access");
    }

    public Long getUserAccountIdFromAccessToken(@NotBlank String token) {
        return extractUserAccountId(token, "access");
    }

    public String getUsernameFromAccessToken(@NotBlank String token) {
        return extractUsername(token, "access");
    }

    //# Refresh Token

    public Date getIssuedAtFromRefreshToken(@NotBlank String token) {
        return extractIssuedAt(token, "refresh");
    }

    public Date getExpirationFromRefreshToken(@NotBlank String token) {
        return extractExpiration(token, "refresh");
    }

    public Long getUserAccountIdFromRefreshToken(@NotBlank String token) {
        return extractUserAccountId(token, "refresh");
    }

    public String getUsernameFromRefreshToken(@NotBlank String token) {
        return extractUsername(token, "refresh");
    }

    // PRIVATE

    private Date extractIssuedAt(@NotBlank String token, @NotBlank String type) {
        return extractClaims(token, type).getIssuedAt();
    }

    private Date extractExpiration(@NotBlank String token, @NotBlank String type) {
        return extractClaims(token, type).getExpiration();
    }

    private Long extractUserAccountId(@NotBlank String token, @NotBlank String type) {
        return Long.valueOf(extractClaims(token, type).getId());
    }

    private String extractUsername(@NotBlank String token, @NotBlank String type) {
        return extractClaims(token, type).getSubject();
    }

    private Claims extractClaims(@NotBlank String token, @NotBlank String type) {
        return Jwts.parser()
                .verifyWith(type.equals("access")
                        ? accessTokenSecretSigningKey()
                        : refreshTokenSecretSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /// ======================================================================================
    //! Validate Token
    // PUBLIC

    //# Access Token
    public Boolean isAccessTokenValid(@NotBlank String token, @NotNull UserAccount userAccount) {
        return isTokenValid(token, userAccount, "access");
    }

    //# Refresh Token

    public Boolean isRefreshTokenValid(@NotBlank String token, @NotNull UserAccount userAccount) {
        return isTokenValid(token, userAccount, "refresh");
    }

    // PRIVATE

    private Boolean isTokenValid(@NotBlank String token, @NotNull UserAccount userAccount, @NotBlank String type) {
        String username = extractUsername(token, type);
        return !isTokenExpired(token, type) && username.equals(userAccount.getUsername());
    }

    /// ======================================================================================
    //! Check Token Expiration
    // PUBLIC

    //# Access Token
    public Boolean isAccessTokenExpired(@NotBlank String token) {
        return isTokenExpired(token, "access");
    }

    //# Refresh Token

    public Boolean isRefreshTokenExpired(@NotBlank String token) {
        return isTokenExpired(token, "refresh");
    }

    // PRIVATE

    private Boolean isTokenExpired(@NotBlank String token, @NotBlank String type) {
        return extractExpiration(token, type).before(new Date());
    }

}
