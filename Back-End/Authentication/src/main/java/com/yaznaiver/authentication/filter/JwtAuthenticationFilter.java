package com.yaznaiver.authentication.filter;

import com.yaznaiver.authentication.dto.PrincipleDto;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.service.CustomUserDetailsService;
import com.yaznaiver.authentication.utility.JwtUtility;
import io.micrometer.common.lang.NonNullApi;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@NonNullApi
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtUtility jwtUtility;
    private final CustomUserDetailsService userDetailsService;

    @Override
    protected void doFilterInternal(
            @NotNull HttpServletRequest request,
            @NotNull HttpServletResponse response,
            @NotNull FilterChain filterChain
    ) throws ServletException, IOException {
        String authorizationHeader = request.getHeader("Authorization");

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.replace("Bearer ", "");

            try {
                // Retrieving National ID from access token either ways if the token is expired or not
                Long nationalId = jwtUtility.getUserAccountIdFromAccessToken(token);

                // If the access token is expired, check if there is a valid refresh token, if not then halt.
                if (jwtUtility.isAccessTokenExpired(token)) {
                    return;
                }


                if (nationalId != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                    UserAccount userAccount = userDetailsService.loadUserByNationalId(nationalId);
                    NationalIdPasswordAuthenticationToken authenticationToken = new NationalIdPasswordAuthenticationToken(
                            new PrincipleDto(userAccount.getUsername(), userAccount.getEmail()),
                            null,
                            userAccount.getAuthorities()
                    );

                    authenticationToken.setDetails(
                            new WebAuthenticationDetailsSource()
                                    .buildDetails
                                            (request)
                    );

                    SecurityContextHolder.getContext().setAuthentication(authenticationToken);
                }
            } catch (Exception e) {
                SecurityContextHolder.clearContext();
            }
        }
        filterChain.doFilter(request, response);

    }
}
