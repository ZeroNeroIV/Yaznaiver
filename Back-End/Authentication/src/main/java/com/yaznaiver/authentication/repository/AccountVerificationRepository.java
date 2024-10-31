package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.AccountVerificationCode;
import com.yaznaiver.authentication.entity.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountVerificationRepository extends JpaRepository<AccountVerificationCode, Integer> {
    @Query("SELECT a FROM AccountVerificationCode a WHERE a.code = ?1")
    Optional<AccountVerificationCode> findByAccountVerificationCode(String code);

    @Query("SELECT u FROM AccountVerificationCode u WHERE u.userAccount.email = ?1")
    Optional<UserAccount> findByUserAccountEmail(String email);

    // TODO:
    void deleteById(Long nationalId);
}
