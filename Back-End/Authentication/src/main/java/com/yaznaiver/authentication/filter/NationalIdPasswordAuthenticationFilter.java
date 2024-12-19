package com.yaznaiver.authentication.filter;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;

public class NationalIdPasswordAuthenticationFilter extends AbstractAuthenticationProcessingFilter {
    public NationalIdPasswordAuthenticationFilter(String defaultFilterProcessesUrl, AuthenticationManager authenticationManager) {
        super(defaultFilterProcessesUrl, authenticationManager);
    }

    protected String obtainNationalId(HttpServletRequest request) {
        return request.getParameter("nationalId");
    }

    protected String obtainPassword(HttpServletRequest request) {
        return request.getParameter("password");
    }

    protected void setDetails(HttpServletRequest request, NationalIdPasswordAuthenticationToken authRequest) {
        authRequest.setDetails(this.authenticationDetailsSource.buildDetails(request));
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException {
        if (!request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
        } else {
            // Getting National ID from the request
            String nationalId = this.obtainNationalId(request);
            nationalId = nationalId != null ? nationalId.trim() : "";
            // Getting the password from the request
            String password = this.obtainPassword(request);
            password = password != null ? password : "";

            NationalIdPasswordAuthenticationToken authRequest =
                    NationalIdPasswordAuthenticationToken.unauthenticated(nationalId, password);
            this.setDetails(request, authRequest);
            return this.getAuthenticationManager().authenticate(authRequest);
        }
    }
}
