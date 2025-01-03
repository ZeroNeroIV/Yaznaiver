package com.yaznaiver.authentication.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.scheduling.annotation.Scheduled;

import java.time.LocalDateTime;

@Table
@Entity
@Data
public class AccountVerificationCode {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(nullable = false, unique = true)
    private String code;
    @OneToOne(fetch = FetchType.EAGER, optional = false, cascade = CascadeType.PERSIST)
    private UserAccount userAccount;
    @Column(nullable = false)
    private LocalDateTime expiresAt;

    @PrePersist
    void prePersist() {
        expiresAt = LocalDateTime.now().plusMinutes(10);
    }
}
