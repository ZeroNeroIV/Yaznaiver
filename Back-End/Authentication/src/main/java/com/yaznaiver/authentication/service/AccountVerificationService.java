package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.entity.AccountVerificationCode;
import com.yaznaiver.authentication.entity.UserAccount;
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

    private AccountVerificationCode process(UserAccount user, int digits) {
        UserAccount userAccount =
                userAccountRepository.findById(user.getNationalId())
                        .orElseThrow(() -> new IllegalArgumentException("No user such found!"));

        String verificationCode = generateVerificationCode(digits);

        AccountVerificationCode newVerification = new AccountVerificationCode();
        newVerification.setUserAccount(userAccount);
        newVerification.setCode(verificationCode);

        return newVerification;
    }

    public void sendVerificationEmail(@NotNull UserAccount user) {
        AccountVerificationCode newVerification = process(user, 6);
        verificationRepository.save(newVerification);

        emailService.verificationEmailSender(
                user.getEmail(),
                "Verification Code",
                newVerification.getCode());
    }

    public void sendOTP(@NotNull UserAccount user) {
        AccountVerificationCode newVerification = process(user, 4);
        verificationRepository.save(newVerification);

        emailService.verificationEmailSender(
                user.getEmail(),
                "OTP" + newVerification.getCode(),
                newVerification.getCode()
        );
    }

    public Boolean verify(String verificationDto) {
        AccountVerificationCode userVerificationCode = verificationRepository
                .findByAccountVerificationCode(verificationDto)
                .orElseThrow(() -> new RuntimeException("No user found!"));
        if (userVerificationCode.getExpiresAt().isAfter(LocalDateTime.now())) {
            userAccountRepository.enableUserAccountByNationalId(
                    userVerificationCode.getUserAccount().getNationalId());
            verificationRepository.deleteById
                    (userVerificationCode.getUserAccount().getNationalId());
            return true;
        } else if (userVerificationCode.getExpiresAt().isBefore(LocalDateTime.now())) {
            verificationRepository.delete(userVerificationCode);
        }
        return false;
    }

    private String generateVerificationCode(int digits) {
        Random rand = new Random();
        Integer randomInteger = rand.nextInt(9 * (int) Math.pow(10, digits)) + (int) Math.pow(10, digits);
        return String.valueOf(randomInteger);
    }
}