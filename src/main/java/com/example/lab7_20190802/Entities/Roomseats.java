package com.example.lab7_20190802.Entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "roomseats")
public class Roomseats {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "roomId")
    private Rooms room;

    @Column(name = "seatNumber", nullable = false, length = 10)
    private String seatNumber;

    @Column(name = "rowNumber", nullable = false, length = 2)
    private String rowNumber;

    @ColumnDefault("1")
    @Column(name = "isAvailable", nullable = false)
    private Boolean isAvailable = false;

}