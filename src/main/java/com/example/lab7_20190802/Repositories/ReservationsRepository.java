package com.example.lab7_20190802.Repositories;

import com.example.lab7_20190802.Entities.Reservations;
import com.example.lab7_20190802.Entities.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReservationsRepository extends JpaRepository<Reservations, Integer> {
    List<Reservations> findByUser(Users user);
}
