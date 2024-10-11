package com.example.lab7_20190802.Controllers;


import com.example.lab7_20190802.Entities.Reservations;
import com.example.lab7_20190802.Entities.Users;
import com.example.lab7_20190802.Repositories.ObrasRepository;
import com.example.lab7_20190802.Repositories.ReservationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cliente")
public class ClienteController {
    @Autowired
    private ObrasRepository obrasRepository;

    @Autowired
    private ReservationsRepository reservationsRepository;

    // Listar todas las obras disponibles para el cliente
    @GetMapping("/obras")
    public String listarObras(Model model) {
        // Obtener todas las obras de la base de datos y añadirlas al modelo
        model.addAttribute("obras", obrasRepository.findAll());
        return "cliente/obras"; // Retorna la vista 'obras.html'
    }

    // Listar las reservas del cliente autenticado
    @GetMapping("/reservas")
    public String listarReservas(Model model, @AuthenticationPrincipal Users user) {
        // Obtener las reservas del usuario autenticado y enviarlas a la vista
        model.addAttribute("reservas", reservationsRepository.findByUser(user));
        return "cliente/reservas"; // Retorna la vista de las reservas del cliente
    }

    // Reservar una función
    @PostMapping("/reservas")
    public String reservarFuncion(Reservations reserva) {
        // Guardar la reserva en la base de datos
        reservationsRepository.save(reserva);
        return "redirect:/cliente/reservas"; // Redirige a la vista de reservas una vez realizada
    }
}
