package com.vku.javaweb.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "blind_boxes")
public class BlindBox {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;        
    private String brand;       
    private Double price;       
    private Integer stock;      
    private String description; 
    private String imageUrl;    

    // --- 2 THUỘC TÍNH MỚI ĐỂ LƯU NHÂN VẬT ĐỘNG ---
    private String characterList;   // Lưu chuỗi: "Labubu Đỏ, Labubu Xanh, Labubu Tím"
    private String secretCharacter; // Lưu tên con hiếm: "Labubu Vàng"
    
    public BlindBox() {}

    // Cập nhật Constructor đầy đủ tham số
    public BlindBox(String name, String brand, Double price, Integer stock, String description, String imageUrl, String characterList, String secretCharacter) {
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.imageUrl = imageUrl;
        this.characterList = characterList;
        this.secretCharacter = secretCharacter;
    }

    // ================= GETTERS VÀ SETTERS =================
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getCharacterList() { return characterList; }
    public void setCharacterList(String characterList) { this.characterList = characterList; }

    public String getSecretCharacter() { return secretCharacter; }
    public void setSecretCharacter(String secretCharacter) { this.secretCharacter = secretCharacter; }
}