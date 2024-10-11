package com.example.lab7_20190802.Repositories;

import com.example.lab7_20190802.Entities.Rooms;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomsRepository extends JpaRepository<Rooms, Integer> {
}
