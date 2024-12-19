package com.yaznaiver.authentication.exception;

public class WrongEmailOrPasswordException extends Throwable {
    @Override
    public String getMessage() {
        return "Wrong Email or Password.";
    }
}
