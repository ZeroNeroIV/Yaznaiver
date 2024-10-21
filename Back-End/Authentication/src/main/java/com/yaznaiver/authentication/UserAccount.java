package com.yaznaiver.authentication;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

@Getter
@Entity
@Table
public class UserAccount implements UserDetails {
    @Setter
    @Id
    private Long nationalId;
    @Setter
    @Column(nullable = false)
    private String firstName;
    @Setter
    @Column(nullable = false)
    private String secondName;
    @Setter
    @Column(nullable = false)
    private String thirdName;
    @Setter
    @Column(nullable = false)
    private String lastName;
    @Column(nullable = false)
    private String username;
    @Setter
    @Column(nullable = false)
    private String email;
    @Setter
    @Column(nullable = false)
    private String password;
    @Setter
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
