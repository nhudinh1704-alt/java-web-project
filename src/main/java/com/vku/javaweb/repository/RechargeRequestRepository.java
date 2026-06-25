package com.vku.javaweb.repository;

import com.vku.javaweb.model.RechargeRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RechargeRequestRepository extends JpaRepository<RechargeRequest, Integer> {
    // Kế thừa các hàm CRUD cơ bản phục vụ duyệt đơn
}