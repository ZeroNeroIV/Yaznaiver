package com.yaznaiver.authentication.controller;

import com.yaznaiver.authentication.exception.SignUpException;
import com.yaznaiver.authentication.exception.WrongEmailOrPasswordException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
//    @ExceptionHandler(WrongEmailOrPasswordException.class)
//    public ResponseEntity<String> wrongEmailOrPasswordExceptionHandler(Exception e) {
//        return ResponseEntity.badRequest().body("Error type: " + e.getMessage());
//    }
//
//    @ExceptionHandler(SignUpException.class)
//    public ResponseEntity<String> signUpExceptionHandler(Exception e) {
//        return ResponseEntity.badRequest().body("Error type: " + e.getMessage());
//    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> generalExceptionHandler(Exception e) {
        return ResponseEntity.badRequest().body("Error type: " + e.getMessage());
    }

}
