package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.UserAccount;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {

    @Query("SELECT u FROM UserAccount u WHERE u.email = ?1")
    Optional<UserAccount> findByEmail(String email);
    @Query("SELECT u FROM UserAccount u WHERE u.username = ?1")
    Optional<UserAccount> findByUsername(String username);
    @Modifying
    @Transactional
    @Query("UPDATE UserAccount u SET u.enabled = true WHERE u.nationalId = ?1")
    void enableUserAccountByNationalId(Long nationalId);
}
