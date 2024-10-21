package com.yaznaiver.authentication;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

@Entity
@Table
@Data
public class UserAccount implements UserDetails {

    @Id
    private Long nationalId;
    @Column(nullable = false)
    private String firstName;
    @Column(nullable = false)
    private String secondName;
    @Column(nullable = false)
    private String thirdName;
    @Column(nullable = false)
    private String lastName;
    @Column(nullable = false)
    private String username;
    @Column(nullable = false)
    private String email;
    @Column(nullable = false)
    private String password;
    @Column(nullable = false)
    private LocalDateTime lastLogin;
    @CreatedDate
    @Column(nullable = false)
    private LocalDateTime createdAt;
    @Column(nullable = false)
    private LocalDateTime updatedAt;


    @PostPersist
    private void postPersist() {
        createdAt = updatedAt = LocalDateTime.now();
        firstName = firstName.stripLeading().stripTrailing();
        secondName = secondName.stripLeading().stripTrailing();
        thirdName = thirdName.stripLeading().stripTrailing();
        lastName = lastName.stripLeading().stripTrailing();
        username = firstName + " " + lastName;
    }

    @PostUpdate
    private void postUpdate() {
        lastLogin = LocalDateTime.now();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }
}
