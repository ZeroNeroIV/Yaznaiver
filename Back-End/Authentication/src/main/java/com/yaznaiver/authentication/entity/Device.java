package com.yaznaiver.authentication.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table
@Data
public class Device {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "user_account_id", nullable = false)
    private UserAccount userAccount; // Reference to the user account

    @Column(nullable = false)
    private String userAgent; // User agent string

    @Column(nullable = false)
    private String ipAddress; // Last known IP address

    @Column(nullable = false)
    private String deviceType; // Device type (mobile, desktop, etc.)
}
