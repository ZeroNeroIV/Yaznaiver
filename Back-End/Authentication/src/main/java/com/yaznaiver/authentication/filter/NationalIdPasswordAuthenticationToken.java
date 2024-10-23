package com.yaznaiver.authentication.filter;

import io.jsonwebtoken.lang.Assert;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class NationalIdPasswordAuthenticationToken extends AbstractAuthenticationToken {
    private final Object principal;
    private Object credentials;

    public NationalIdPasswordAuthenticationToken(Object principal, Object credentials) {
        super(null);
        this.principal = principal;
        this.credentials = credentials;
        this.setAuthenticated(false);
    }
    public NationalIdPasswordAuthenticationToken(Object principal,
                                                 Object credentials,
                                                 Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.principal = principal;
        this.credentials = credentials;
        this.setAuthenticated(true);
    }

    public static NationalIdPasswordAuthenticationToken unauthenticated(Object principal, Object credentials) {
        return new NationalIdPasswordAuthenticationToken(principal, credentials);
    }

    public static NationalIdPasswordAuthenticationToken authenticated(Object principal, Object credentials, Collection<? extends GrantedAuthority> authorities) {
        return new NationalIdPasswordAuthenticationToken(principal, credentials, authorities);
    }

    public void setAuthenticated(boolean authenticated) throws IllegalArgumentException {
        Assert.isTrue(!authenticated, "Cannot set this token to trusted - use constructor which takes a GrantedAuthority list instead");
        super.setAuthenticated(false);
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
        this.credentials = null;
    }

    @Override
    public Object getCredentials() {
        return this.credentials;
    }

    @Override
    public Object getPrincipal() {
        return this.principal;
    }
}
