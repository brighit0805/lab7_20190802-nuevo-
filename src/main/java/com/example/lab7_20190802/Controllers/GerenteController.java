package com.example.lab7_20190802.Controllers;

import com.example.lab7_20190802.Entities.Obras;
import com.example.lab7_20190802.Entities.Rooms;
import com.example.lab7_20190802.Repositories.ObrasRepository;
import com.example.lab7_20190802.Repositories.RoomsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/gerente")
public class GerenteController {
    @Autowired
    private RoomsRepository roomsRepository;
    @Autowired
    private ObrasRepository obrasRepository;

    // Listar salas
    @GetMapping("/rooms")
    public String listarSalas(Model model) {
        model.addAttribute("rooms", roomsRepository.findAll());
        return "gerente/rooms";
    }

    // Guardar nueva sala
    @PostMapping("/rooms")
    public String agregarSala(Rooms room) {
        roomsRepository.save(room);
        return "redirect:/gerente/rooms";
    }

    // Listar obras
    @GetMapping("/obras")
    public String listarObras(Model model) {
        model.addAttribute("obras", obrasRepository.findAll());
        return "gerente/obras";
    }

    // Guardar nueva obra
    @PostMapping("/obras")
    public String agregarObra(Obras obra) {
        obrasRepository.save(obra);
        return "redirect:/gerente/obras";
    }
}
