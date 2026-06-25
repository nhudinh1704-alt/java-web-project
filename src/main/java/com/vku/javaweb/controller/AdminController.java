package com.vku.javaweb.controller;

import com.vku.javaweb.model.RechargeRequest;
import com.vku.javaweb.model.User;
import com.vku.javaweb.repository.RechargeRequestRepository;
import com.vku.javaweb.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private RechargeRequestRepository rechargeRequestRepository;

    @Autowired
    private UserRepository userRepository;

    @GetMapping({"/admin/orders", "/admin/system"})
    public String viewAdminOrders(Model model) {
        List<RechargeRequest> requests = rechargeRequestRepository.findAll();
        model.addAttribute("rechargeRequests", requests);
        return "admin/orders";
    }

    @GetMapping("/admin/recharge/approve/{id}")
    public String approveRecharge(@PathVariable("id") Integer id) {

        RechargeRequest request =
                rechargeRequestRepository.findById(id).orElse(null);

        if (request != null &&
                "PENDING".equals(request.getStatus())) {

            User user =
                    userRepository.findById(request.getUserId())
                            .orElse(null);

            if (user != null) {

                Double currentBalance =
                        user.getBalance() == null ? 0.0 : user.getBalance();

                user.setBalance(
                        currentBalance + request.getAmount());

                userRepository.save(user);

                request.setStatus("APPROVED");
                rechargeRequestRepository.save(request);
            }
        }

        return "redirect:/admin/orders";
    }
}