package com.vku.javaweb.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vku.javaweb.model.BlindBox;

@Repository
public interface BlindBoxRepository extends JpaRepository<BlindBox, Long> {
  
}