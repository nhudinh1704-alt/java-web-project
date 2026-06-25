package com.vku.javaweb.controller;

import com.vku.javaweb.model.User;
import com.vku.javaweb.model.UserInventory;
import com.vku.javaweb.model.BlindBox;
import com.vku.javaweb.repository.UserInventoryRepository;
import com.vku.javaweb.repository.BlindBoxRepository;
import com.vku.javaweb.repository.RechargeRequestRepository;
import com.vku.javaweb.model.RechargeRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserInventoryRepository inventoryRepository;

    @Autowired
    private BlindBoxRepository blindBoxRepository;

    @Autowired
    private RechargeRequestRepository rechargeRequestRepository;

    @GetMapping("/user/inventory")
    public String showInventory(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        // 🛠️ SỬA TẠI ĐÂY: Lấy trực tiếp id bỏ ép kiểu intValue() tránh lỗi dereferenced
        Integer userId = (int) loggedInUser.getId();
        List<UserInventory> rawInventory = inventoryRepository.findByUserId(userId);
        List<BlindBox> userItems = new ArrayList<>();

        if (rawInventory != null) {
            for (UserInventory inv : rawInventory) {
                blindBoxRepository.findById(inv.getItemId()).ifPresent(box -> {
                    String currentStatus = inv.getStatus();
                    if (currentStatus == null || currentStatus.trim().isEmpty()) {
                        currentStatus = "IN_STOCK";
                    }
                    box.setDescription(currentStatus);
                    box.setId(inv.getId());
                    userItems.add(box);
                });
            }
        }

        model.addAttribute("inventoryItems", userItems);
        return "user/inventory";
    }

    @PostMapping("/user/recharge-request")
    public String handleRechargeRequest(@RequestParam Double amount, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            return "redirect:/auth/login";
        }

        if (amount != null && amount >= 10000) {
            RechargeRequest req = new RechargeRequest();
            req.setUserId(loggedInUser.getId());
            req.setAmount(amount);
            req.setStatus("PENDING");
            rechargeRequestRepository.save(req);
        }
        return "redirect:/blindbox/list?msg=submitted";
    }
}