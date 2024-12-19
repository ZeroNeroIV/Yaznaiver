package com.yaznaiver.authentication.configuration;

import com.yaznaiver.authentication.entity.Roles;
import com.yaznaiver.authentication.repository.RolesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class RolesConfiguration {
    private final RolesRepository rolesRepository;

    @Bean
    public CommandLineRunner initRoles() {
        return _ -> {
            // Check if roles already exist
            if (rolesRepository.count() == 0) {
                // Create and save admin role
                Roles adminRole = new Roles();
                adminRole.setRoleName("ADMIN");
                rolesRepository.save(adminRole);

                // Create and save user role
                Roles userRole = new Roles();
                userRole.setRoleName("USER");
                rolesRepository.save(userRole);

                System.out.println("Default roles created: [\"ADMIN\", \"USER\"].");
            } else {
                System.out.println("Default roles already exist.");
            }
        };
    }
}