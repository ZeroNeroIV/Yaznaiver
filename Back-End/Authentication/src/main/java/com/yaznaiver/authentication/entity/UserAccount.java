package com.yaznaiver.authentication.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

@Getter
@Entity
@Table
@NoArgsConstructor
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
    @Column(nullable = false)
    private LocalDate birthDate;
    @Setter
    @Column(nullable = false)
    private LocalDateTime lastLogin;
    @CreatedDate
    @Column(nullable = false)
    private LocalDateTime createdAt;
    @Column(nullable = false)
    private LocalDateTime updatedAt;
    @Column(nullable = false)
    private Boolean enabled;

    public UserAccount(@NotNull Long id,
                       @NotBlank String firstName,
                       @NotBlank String secondName,
                       @NotBlank String thirdName,
                       @NotBlank String lastName,
                       @NotNull @Email String email,
                       String encodedPassword,
                       @NotNull LocalDateTime birthDate) {
        this.nationalId = id;
        this.firstName = firstName;
        this.secondName = secondName;
        this.thirdName = thirdName;
        this.lastName = lastName;
        this.password = encodedPassword;
        this.email = email;
        this.birthDate = birthDate;
    }

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

    @Override
    public boolean isEnabled() {
        return enabled;
    }
}
