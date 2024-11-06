package com.yaznaiver.authentication.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table
@Data
public class RefreshToken {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @ManyToOne
    private UserAccount userAccount;
    @OneToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "device_id")
    private Device device;
    @Column(nullable = false, unique = true)
    private String refreshToken;
}
