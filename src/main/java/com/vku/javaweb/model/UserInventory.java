package com.vku.javaweb.model;

import jakarta.persistence.*;

@Entity
@Table(name = "user_inventory")
public class UserInventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "item_id")
    private Integer itemId;

    @Column(name = "status")
    private String status;

    // --- GETTER & SETTER ---
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getItemId() { return itemId; }
    public void setItemId(Integer itemId) { this.itemId = itemId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}