package com.example.lab7_20190802.Controllers;

import com.example.lab7_20190802.Entities.Users;
import com.example.lab7_20190802.Repositories.UsersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
    @Autowired
    private UsersRepository usersRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Mostrar el formulario de login
    @GetMapping("/login")
    public String mostrarLogin() {
        return "login/login";
    }

    // Mostrar el formulario de registro
    @GetMapping("/register")
    public String mostrarRegistro(Model model) {
        model.addAttribute("user", new Users());
        return "login/register";
    }

    // Registrar un nuevo usuario
    @PostMapping("/register")
    public String registrarUsuario(Users user) {
        user.setPassword(passwordEncoder.encode(user.getPassword())); // Encriptar la contraseña
        user.setEnabled(true); // Activar la cuenta
        usersRepository.save(user); // Guardar el usuario en la base de datos
        return "redirect:/login";
    }
}
