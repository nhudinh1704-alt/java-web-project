package com.vku.javaweb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vku.javaweb.model.User;
import com.vku.javaweb.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/recharge")
    public String rechargeMoney(@RequestParam Double amount, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null && amount > 0) {
            // Cộng tiền vào đối tượng hiện tại
            loggedInUser.setBalance(loggedInUser.getBalance() + amount);
            // Lưu cập nhật vào Cơ sở dữ liệu
            userRepository.save(loggedInUser);
            // Cập nhật lại session để giao diện hiển thị số tiền mới ngay lập tức
            session.setAttribute("loggedInUser", loggedInUser);
        }
        return "redirect:/blindbox/list";
    }
}