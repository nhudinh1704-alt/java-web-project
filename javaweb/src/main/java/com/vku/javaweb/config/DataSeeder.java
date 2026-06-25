package com.vku.javaweb.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.vku.javaweb.model.Role;
import com.vku.javaweb.model.User;
import com.vku.javaweb.repository.UserRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Component
public class DataSeeder implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public void run(String... args) throws Exception {
        // 1. Tạo hoặc lấy Role ADMIN (id = 1)
        Role adminRole = entityManager.find(Role.class, 1L);
        if (adminRole == null) {
            adminRole = new Role();
            adminRole.setId(1L);
            adminRole.setName("ADMIN");
            entityManager.merge(adminRole);
        }

        // 2. Tạo hoặc lấy Role USER (id = 2)
        Role userRole = entityManager.find(Role.class, 2L);
        if (userRole == null) {
            userRole = new Role();
            userRole.setId(2L);
            userRole.setName("USER");
            entityManager.merge(userRole);
        }

        // 3. Tạo tài khoản Admin mẫu nếu chưa có
        if (userRepository.findByUsername("admin").isEmpty()) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword("123"); // Mật khẩu thuần để dễ test chuyên đề
            admin.setFullName("Quản Trị Viên");
            admin.setBalance(5000000.0); // Admin cho nhiều tiền tí
            admin.setRole(adminRole);
            userRepository.save(admin);
        }

        // 4. Tạo tài khoản User mẫu nếu chưa có
        if (userRepository.findByUsername("user").isEmpty()) {
            User user = new User();
            user.setUsername("user");
            user.setPassword("123");
            user.setFullName("Nguyễn Văn Khách");
            user.setBalance(50000.0); // Cho sẵn 50k trải nghiệm mua hộp mù
            user.setRole(userRole);
            userRepository.save(user);
        }
    }
}