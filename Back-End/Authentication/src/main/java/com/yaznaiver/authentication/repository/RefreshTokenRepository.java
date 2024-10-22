package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.RefreshToken;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {
    @Modifying
    @Transactional
    @Query("DELETE FROM RefreshToken r WHERE r.userAccount.nationalId = ?1")
    void deleteByUserAccountNationalId(Long nationalId);
}
