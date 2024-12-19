package com.yaznaiver.authentication.exception;

public class UserAccountNotFoundException extends RuntimeException {
    @Override
    public String getMessage() {
        return "User not found";
    }
}
