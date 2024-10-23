package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.entity.AccountVerificationCode;
import com.yaznaiver.authentication.exception.AccountVerificationCodeNotFoundException;
import com.yaznaiver.authentication.repository.AccountVerificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountVerificationService {
    private final AccountVerificationRepository accountVerificationRepository;

    public void accountVerificationCode(String code) throws AccountVerificationCodeNotFoundException {
        AccountVerificationCode accountVerificationCode =
                accountVerificationRepository.findByCode(code).orElseThrow(AccountVerificationCodeNotFoundException::new);
    }
}
