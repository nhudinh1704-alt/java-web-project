package com.vku.javaweb.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vku.javaweb.model.User;
import com.vku.javaweb.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public void save(User user) {
        userRepository.save(user);
    }
public Iterable<User> findAll() {
    return userRepository.findAll();
}
    public String xinchaoVKU() {
        return "Xin chào VKU";
    }
}