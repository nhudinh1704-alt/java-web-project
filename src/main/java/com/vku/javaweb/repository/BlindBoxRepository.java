package com.vku.javaweb.repository;

import com.vku.javaweb.model.BlindBox;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BlindBoxRepository extends JpaRepository<BlindBox, Integer> {
    // Khóa chính đã chuyển về Integer
}