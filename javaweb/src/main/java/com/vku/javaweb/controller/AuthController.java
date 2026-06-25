package com.vku.javaweb.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vku.javaweb.model.Role;
import com.vku.javaweb.model.User;
import com.vku.javaweb.repository.UserRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired private UserRepository userRepository;
    @PersistenceContext private EntityManager entityManager;

    @GetMapping("/login")
    public String showLoginForm() {
        return "auth/login";
    }

    // LOGIC ĐĂNG NHẬP
    @PostMapping("/login")
    public String handleLogin(@RequestParam String username, @RequestParam String password, HttpSession session) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            User user = userOpt.get();
            session.setAttribute("loggedInUser", user); // Lưu phiên đăng nhập
            return "redirect:/blindbox/list"; 
        }
        return "redirect:/auth/login?error=true";
    }

    // LOGIC ĐĂNG KÝ TÀI KHOẢN MỚI
    @PostMapping("/register")
    @Transactional
    public String handleRegister(@RequestParam String username, @RequestParam String password, @RequestParam String fullName) {
        // Kiểm tra xem trùng username chưa
        if (userRepository.findByUsername(username).isPresent()) {
            return "redirect:/auth/login?usernameExists=true";
        }

        // Lấy hoặc tạo mặc định Role USER (id = 2) cho người mới ký
        Role userRole = entityManager.find(Role.class, 2L);
        if (userRole == null) {
            userRole = new Role();
            userRole.setId(2L);
            userRole.setName("USER");
            entityManager.merge(userRole);
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setFullName(fullName);
        newUser.setBalance(0.0); // Tài khoản mới có 0đ, bắt buộc phải nạp tiền mới mua được
        newUser.setRole(userRole);

        userRepository.save(newUser);
        return "redirect:/auth/login?registerSuccess=true";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }
}