package com.example.lab7_20190802.Controllers;

import com.example.lab7_20190802.Entities.Funciones;
import com.example.lab7_20190802.Entities.Obras;
import com.example.lab7_20190802.Repositories.FuncionesRepository;
import com.example.lab7_20190802.Repositories.ObrasRepository;
import com.example.lab7_20190802.Repositories.ReservationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private FuncionesRepository funcionesRepository;
    @Autowired
    private ObrasRepository obrasRepository;
    @Autowired
    private ReservationsRepository reservationsRepository;

    @GetMapping("/funciones")
    public String listarFunciones(Model model) {
        List<Funciones> funciones = funcionesRepository.findAll();
        List<Obras> obras = obrasRepository.findAll();
        model.addAttribute("funciones", funciones);
        model.addAttribute("obras", obras);
        return "admin/funciones";
    }

    @PostMapping("/funciones")
    public String agregarFuncion(Funciones funcion) {
        funcionesRepository.save(funcion);
        return "redirect:/admin/funciones";
    }
    @GetMapping("/reservas")
    public String listarTodasReservas(Model model) {
        model.addAttribute("reservas", reservationsRepository.findAll());
        return "admin/reservas";
    }

}
