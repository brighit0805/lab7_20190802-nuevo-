package com.example.lab7_20190802.Repositories;

import com.example.lab7_20190802.Entities.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UsersRepository extends JpaRepository<Users ,Integer> {
    Optional<Users> findByEmail(String email); // Buscar por email para el login
}
