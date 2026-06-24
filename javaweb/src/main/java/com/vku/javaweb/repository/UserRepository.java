package com.vku.javaweb.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vku.javaweb.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Hàm cốt lõi để tìm xem tài khoản đăng nhập có tồn tại trong CSDL không
    Optional<User> findByUsername(String username);
}