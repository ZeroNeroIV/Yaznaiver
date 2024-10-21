package com.yaznaiver.authentication;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {

    @Query("SELECT u FROM UserAccount u WHERE u.email = ?1")
    Optional<UserAccount> findByEmail(String email);
    @Query("SELECT u FROM UserAccount u WHERE u.username = ?1")
    Optional<UserAccount> findByUsername(String username);
}
