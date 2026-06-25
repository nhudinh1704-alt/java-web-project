package com.vku.javaweb.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String username;
    private String password;
    private String fullName;
    private Double balance = 0.0;

    // Thiết lập mối quan hệ: Nhiều Người dùng thuộc về Một Quyền (Many Users to One Role)
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    public User() {
        // Default constructor for framework instantiation
    }

    // --- GETTER VÀ SETTER CHO BALANCE ---
    public Double getBalance() { 
        return balance; 
    }
    
    public void setBalance(Double balance) { 
        this.balance = balance; 
    }

    // --- GETTER VÀ SETTER CHO ROLE ---
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    // --- CÁC GETTER VÀ SETTER CŨ ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}