package com.yaznaiver.authentication.repository;

import com.yaznaiver.authentication.entity.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RolesRepository extends JpaRepository<Roles, Long> {

    //Find by RoleName
    @Query("SELECT r from Roles r where r.roleName=?1")
    Optional<Roles> findByRoleName(String roleName);
}