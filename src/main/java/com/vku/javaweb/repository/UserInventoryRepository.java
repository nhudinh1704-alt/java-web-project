package com.vku.javaweb.repository;

import com.vku.javaweb.model.UserInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserInventoryRepository extends JpaRepository<UserInventory, Integer> {
    List<UserInventory> findByUserId(Integer userId);
}