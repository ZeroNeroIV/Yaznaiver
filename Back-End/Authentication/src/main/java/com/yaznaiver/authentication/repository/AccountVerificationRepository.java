package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.AccountVerificationCode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountVerificationRepository extends JpaRepository<AccountVerificationCode, Integer> {
    @Query("SELECT a FROM AccountVerificationCode a WHERE a.code = ?1")
    Optional<AccountVerificationCode> findByCode(String code);
}
