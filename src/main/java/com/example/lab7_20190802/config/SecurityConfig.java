package com.example.lab7_20190802.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // BCrypt para encriptar contraseñas
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailsService(); // Servicio personalizado para cargar usuarios
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests()
                .antMatchers("/login", "/register", "/css/**", "/js/**").permitAll() // Páginas accesibles sin login
                .antMatchers("/admin/**").hasRole("ADMIN") // Rutas solo accesibles por ADMIN
                .antMatchers("/gerente/**").hasRole("GERENTE") // Rutas solo accesibles por GERENTE
                .antMatchers("/cliente/**").hasRole("CLIENTE") // Rutas solo accesibles por CLIENTE
                .anyRequest().authenticated() // Todas las demás rutas requieren autenticación
                .and()
                .formLogin()
                .loginPage("/login") // Página personalizada de login
                .permitAll()
                .and()
                .logout()
                .permitAll();
        return http.build();
    }
}
