package com.vku.javaweb.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "recharge_requests")
public class RechargeRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    private Double amount;
    private String status; // PENDING, APPROVED, REJECTED

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    public RechargeRequest() {}

    // ================= GETTERS VÀ SETTERS =================
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}