package com.yaznaiver.authentication.exception;

public class SignUpException extends Throwable {
    @Override
    public String getMessage() {
        return "Something went wrong in the sign up process";
    }
}
