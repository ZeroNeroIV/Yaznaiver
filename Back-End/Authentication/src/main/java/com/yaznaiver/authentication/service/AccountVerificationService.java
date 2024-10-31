package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.dto.AccountVerificationCodeDto;
import com.yaznaiver.authentication.entity.AccountVerificationCode;
import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.exception.AccountVerificationCodeNotFoundException;
import com.yaznaiver.authentication.repository.AccountVerificationRepository;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Random;


@Service
@RequiredArgsConstructor
public class AccountVerificationService {

    private final AccountVerificationRepository verificationRepository;
    private final EmailService emailService;
    private final UserAccountRepository userAccountRepository;

    public void sendVerificationEmail(@NotNull UserAccount user) {
        String verificationCode = generateVerificationCode();

        AccountVerificationCode newVerification = new AccountVerificationCode();

        UserAccount userAccount =
                userAccountRepository.findById(user.getNationalId())
                        .orElseThrow(() -> new IllegalArgumentException("No user such found!"));

        newVerification.setUserAccount(userAccount);
        newVerification.setCode(verificationCode);

        // 10 minutes
        newVerification.setExpiresAt(LocalDateTime.now().plusMinutes(10));

        verificationRepository.save(newVerification);

        emailService.verificationEmailSender(
                user.getEmail(),
                "Verification Code",
                verificationCode);
    }

    public Boolean isCodeCorrect(@NotNull AccountVerificationCodeDto verificationDto) {
        AccountVerificationCode userVerificationCode = verificationRepository
                .findByAccountVerificationCode(verificationDto.getCode())
                .orElseThrow(() -> new RuntimeException("No user found!"));
        if (userVerificationCode.getExpiresAt().isAfter(LocalDateTime.now())) {
            userAccountRepository.enableUserAccountByNationalId(
                    userVerificationCode.getUserAccount().getNationalId());
            verificationRepository.deleteBy
                    (userVerificationCode.getUserAccount().getNationalId());
            return true;
        }
        else if (userVerificationCode.getExpiresAt().isBefore(LocalDateTime.now())) {
            verificationRepository.delete(userVerificationCode);
        }
        return false;
    }

    private String generateVerificationCode() {
        Random rand = new Random();
        Integer randomInteger = rand.nextInt(90000000) + 10000000;
        return String.valueOf(randomInteger);
    }
}