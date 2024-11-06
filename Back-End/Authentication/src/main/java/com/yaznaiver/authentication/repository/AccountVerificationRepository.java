package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.AccountVerificationCode;
import com.yaznaiver.authentication.entity.UserAccount;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountVerificationRepository extends JpaRepository<AccountVerificationCode, Integer> {
    @Query("SELECT a FROM AccountVerificationCode a WHERE a.code = ?1")
    Optional<AccountVerificationCode> findByAccountVerificationCode(String code);

    @Query("SELECT u FROM AccountVerificationCode u WHERE u.userAccount.email = ?1")
    Optional<UserAccount> findByUserAccountEmail(String email);

    @Modifying
    @Transactional
    @Query("DELETE FROM AccountVerificationCode a WHERE a.userAccount.nationalId = ?1")
    void deleteById(Long nationalId);
}
