package com.yaznaiver.authentication.exception;

public class AccountVerificationCodeNotFoundException extends Throwable {
    @Override
    public String getMessage() {
        return "Account verification code not found";
    }
}
