package com.yaznaiver.authentication.utility;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yaznaiver.authentication.entity.UserAccount;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
    public String generateAccessToken(@NotNull UserAccount userAccount) throws JsonProcessingException {
        return generateToken(userAccount, "access");
    }

    //# Refresh Token

    public String generateRefreshToken(@NotNull UserAccount userAccount) throws JsonProcessingException {
        return generateToken(userAccount, "refresh");
    }

    // PRIVATE

    private String generateToken(@NotNull UserAccount userAccount, @NotBlank String type) throws JsonProcessingException {
        Map<String, String> subject = new HashMap<>();
        subject.put("username", userAccount.getUsername());
        subject.put("email", userAccount.getEmail());

        ObjectMapper mapper = new ObjectMapper();
        String jsonSubjectString = mapper.writeValueAsString(subject);

        return Jwts.builder()
                .signWith(type.equals("access")
                        ? accessTokenSecretSigningKey()
                        : refreshTokenSecretSigningKey())
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + (type.equals("access")
                        ? accessTokenExp
                        : refreshTokenExp)))
                .subject(jsonSubjectString)
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

    public String getUsernameFromAccessToken(@NotBlank String token) throws JsonProcessingException {
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

    public String getUsernameFromRefreshToken(@NotBlank String token) throws JsonProcessingException {
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

    private String extractUsername(@NotBlank String token, @NotBlank String type) throws JsonProcessingException {
        return (String) extractSubject(token, type).get("username");
    }

    private String extractEmail(@NotBlank String token, @NotBlank String type) throws JsonProcessingException {
        return (String) extractSubject(token, type).get("email");
    }

    private HashMap<?, ?> extractSubject(@NotBlank String token, @NotBlank String type) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(extractClaims(token, type).getSubject(), HashMap.class);
    }

    private Claims extractClaims(@NotBlank String token, @NotBlank String type) {
        try {
            return Jwts.parser()
                    .verifyWith(type.equals("access")
                            ? accessTokenSecretSigningKey()
                            : refreshTokenSecretSigningKey())
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
        } catch (SignatureException e) {
            throw new SignatureException("Invalid signature", e);
        } catch (MalformedJwtException e) {
            throw new MalformedJwtException("Invalid JWT token formatting", e);
        } catch (ExpiredJwtException e) {
            throw new ExpiredJwtException(null, null, "Expired JWT token: ", e);
        } catch (UnsupportedJwtException e) {
            throw new UnsupportedJwtException("Unsupported JWT token: ", e);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("JWT claims string is missing", e);
        }
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
