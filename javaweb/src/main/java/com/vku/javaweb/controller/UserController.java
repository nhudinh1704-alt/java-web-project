package com.vku.javaweb.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vku.javaweb.model.User;
import com.vku.javaweb.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // Trang chính
  @RequestMapping("/")
public String home(Model model) {
    model.addAttribute("bien1", "VKU");
    return "admin/user/trang1";
}

    // Trang form
   @RequestMapping("/user")
public String createPage(Model model) {
    model.addAttribute("newUser", new User());
    return "admin/user/create";
}
@RequestMapping("/users")
public String listUser(Model model) {
    model.addAttribute("users", userService.findAll());
    return "admin/user/list";
}
    // Xử lý POST
   @RequestMapping(value = "/admin/user/create1", method = RequestMethod.POST)
public String saveUser(@ModelAttribute("newUser") User user) {
    userService.save(user);
    return "redirect:/users";
}
}