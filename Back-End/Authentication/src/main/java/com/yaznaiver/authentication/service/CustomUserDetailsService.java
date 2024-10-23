package com.yaznaiver.authentication.service;

import com.yaznaiver.authentication.entity.UserAccount;
import com.yaznaiver.authentication.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserAccountRepository userAccountRepository;

    @Override
    public UserAccount loadUserByUsername(String username) throws UsernameNotFoundException {
        return userAccountRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(username));
    }

    public UserAccount loadUserByNationalId(Long nationalId) {
        return userAccountRepository.findById(nationalId)
                .orElseThrow(() -> new UsernameNotFoundException(String.valueOf(nationalId)));
    }
}
